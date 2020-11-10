FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["webapisample1.csproj", "./"]
RUN dotnet restore "webapisample1.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "webapisample1.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "webapisample1.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "webapisample1.dll"]
