local assetPath = "epstein.png"

if not isfile(assetPath) then
    local response = request({
        Url = "https://github.com/veryimportantrr/epstein/raw/refs/heads/main/pic.png",
        Method = "GET"
    })

    if response and response.Body then
        writefile(assetPath, response.Body)
    end
end

local customAsset = getcustomasset(assetPath)

local faces = {
    Enum.NormalId.Top, Enum.NormalId.Bottom, Enum.NormalId.Left, 
    Enum.NormalId.Right, Enum.NormalId.Front, Enum.NormalId.Back
}

local function applyToEverything(obj)
    if obj:IsA("BasePart") and not obj:IsA("Terrain") then
        for _, face in ipairs(faces) do
            local decal = Instance.new("Decal")
            decal.Texture = customAsset
            decal.Face = face
            decal.Parent = obj
        end
    elseif obj:IsA("MeshPart") then
        obj.TextureID = customAsset
    elseif obj:IsA("Sky") then
        obj.SkyboxBk = customAsset
        obj.SkyboxDn = customAsset
        obj.SkyboxFt = customAsset
        obj.SkyboxLf = customAsset
        obj.SkyboxRt = customAsset
        obj.SkyboxUp = customAsset
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj.Texture = customAsset
    end
end

if not game.Lighting:FindFirstChildOfClass("Sky") then
    local newSky = Instance.new("Sky", game.Lighting)
    applyToEverything(newSky)
end

for _, object in ipairs(game:GetDescendants()) do
    applyToEverything(object)
end

game.DescendantAdded:Connect(applyToEverything)
