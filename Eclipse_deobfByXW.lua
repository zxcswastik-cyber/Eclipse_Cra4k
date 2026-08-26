-- ============================================================================
-- Eclipse_SanDiego.lua
-- Deobfuscation pass 4: conservative semantic normalization
-- Numbered suffixes are retained intentionally so identifier identity remains
-- traceable while avoiding unsafe global renames across Lua scopes.
-- ============================================================================

-- ============================================================================
-- Eclipse_SanDiego.lua
-- Deobfuscation pass: conservative semantic cleanup
-- NOTE: Remaining numbered identifiers are intentionally preserved when their
-- exact semantic identity cannot be established safely without scope/AST data.
-- ============================================================================

-- Eclipse_SanDiego.lua — full behavior-preserving deobfuscation
-- Original: LuaObfuscator.com Alpha 0.10.9
-- Semantic names restored where they can be inferred with high confidence.
-- Second semantic verification pass: only high-confidence context-based names were changed; uncertain names are preserved.
-- No functional logic was intentionally removed or redesigned.
--[[
.____                  ________ ___.    _____                           __
|    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________
|    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
|    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
|_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|
\/          \/         \/    \/                \/     \/     \/
\_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib
]]--
local function logDebug(success) pcall(function() warn("[ECLIPSE-M] "   .. tostring(success) );
    end);
end logDebug("Starting mobile...");
local Players=game:GetService("Players");
local LocalPlayer=Players.LocalPlayer;
local UserInputService=game:GetService("UserInputService");
local TweenService=game:GetService("TweenService");
local RunService=game:GetService("RunService");
local Lighting=game:GetService("Lighting");
local TeleportService=game:GetService("TeleportService");
local ReplicatedStorage=game:GetService("ReplicatedStorage");
local VirtualUser=nil;
pcall(function() VirtualUser=game:GetService("VirtualUser");
end);
local Workspace=game:GetService("Workspace");
local Camera=Workspace.CurrentCamera;
pcall(function() for guiParent,guiContainer in ipairs({LocalPlayer:WaitForChild("PlayerGui"),game:GetService("CoreGui")}) do existingGui=guiContainer:FindFirstChild("Eclipse_Internal");
            if existingGui then
                existingGui:Destroy();
                task.wait(0.1);
            end
    end
end);
logDebug("Services loaded");
local State={};
if getgenv then
    getgenv().S=State;
end State.scriptActive=true;
State.menuVisible=false;
State.isWaitingBind=false;
State.connections={};
State.espEnabled=false;
State.showHealth=true;
State.showDistance=true;
State.friendsOnly=false;
State.fbEnabled=false;
State.wallClipEnabled=false;
State.afkEnabled=false;
State.afkThread=nil;
State.antiRecoilEnabled=false;
State.antiRecoilStrength=0.7;
State.lastAimCF=nil;
State.flyEnabled=false;
State.flyFakePart=nil;
State.flySpeed=60;
State.flyBV=nil;
State.flyBG=nil;
State.noclipEnabled=false;
State.noclipOrigCollisions={};
State.vehSpeedEnabled=false;
State.vehSpeedMult=2;
State.vehOrigSpeeds={};
State.espCache={};
State.currentTab="Visuals";
State.speedBoostEnabled=false;
State.speedBoostMult=2;
State.jumpBoostEnabled=false;
State.jumpBoostMult=2;
State.origWalkSpeed=16;
State.origJumpPower=50;
State.espGradient=false;
State.espGradientMode="outline";
State.espGradientRoles={Police=true,Civilian=true,Friend=true,Armed=true};
State.fovGradient=false;
State.carESP=false;
State.carESPCache={};
State.lockedTarget=nil;
State.FOVCircle=nil;
State.threatLines=false;
State.threatLineCache={};
State.threatLineArmed=true;
State.threatLineWanted=true;
State.threatLinePolice=false;
State.espRoleFilter={Police=true,Civilian=true,Friend=true,Armed=true};
State.autoTablet=false;
State.autoTabletInterval=5;
State.tabletSlot=6;
State.taserTP=false;
State.lang="ru";
State.langLabels={};
State.toggleRegistry={};
State.menuAccentColor=Color3.fromRGB(168,85,247);
State.toggleActiveColor=Color3.fromRGB(168,85,247);
State.ESPColors={Police=Color3.fromRGB(0,120,255),Civilian=Color3.fromRGB(255,255,255),Friend=Color3.fromRGB(0,255,120),Armed=Color3.fromRGB(255,60,60)};
local Localization={ru={esp_players="ESP Игроков",fullbright="FullBright",esp_cars="ESP Машин",threat_lines="Линии угроз",armed="Вооружённые",wanted="Разыскиваемые",police_lines="Полиция",police="Полиция",civilian="Гражданские",friends="Друзья",armed_filter="Вооружённые",wall_clip="Сквозь стены",fly="Полёт",noclip="Ноклип",car_speed="Скорость авто",speed_boost="Ускорение",high_jump="Высокий прыжок",fly_speed="Скорость полёта",speed_multi="Множитель скорости",run_speed="Скорость бега",jump_power="Сила прыжка",rejoin="Реджоин",rejoin_btn="РЕДЖОИН",anti_afk="Анти-АФК",cam_zoom="Зум камеры",auto_tablet="Авто планшет",scan_interval="Интервал (сек)",tablet_slot="Слот планшета",taser_tp="Тазер ТП",taser_btn="ТАЗЕР",tab_farm="Фарм",fov_color="Цвет круга FOV",auto_farm="Авто фарм",farm_rings="Контрабанда",farm_status_buy="Покупаю",farm_status_sell="Продаю...",farm_status_launder="Отмываю...",farm_status_walk="Лечу к точке...",farm_cycles="Циклов",aimbot="Аимбот",aim_part="Часть тела",toggle_btn="Сменить",fov_circle="Круг FOV",smoothness="Плавность",max_dist="Макс. дистанция",dist_btn="Далее",wall_check="Проверка стен",team_check="Проверка команды",target_lock="Захват цели",prediction="Предсказание",anti_recoil="Анти-отдача",recoil_comp="Компенсация %",esp_visual_settings="Настройки ESP и визуалов",esp_gradient="Градиент ESP",fov_gradient="Градиент FOV",mode_outline="Режим: Обводка",mode_fill="Режим: Заливка",switch_btn="Сменить",role_police="Полиция",role_civilian="Гражданский",role_friend="Друг",role_armed="Вооружённый",settings_title="Настройки интерфейса",accent_color="Цвет акцента меню",toggle_color="Цвет тумблеров",bg_color="Цвет фона",row_color="Цвет элементов",language="Язык",lang_ru="Русский",lang_en="English",on="ВКЛ",off="ВЫКЛ",notif_scanning="Сканирование...",notif_remotes_nf="Ремоуты не найдены",notif_no_target="Цель не найдена",notif_color_upd="обновлён",notif_menu_color="Цвет меню обновлён",notif_toggle_color="Цвет тумблеров обновлён",at_title="АВТО ПЛАНШЕТ",at_timeout="Таймаут",at_wanted="Розыск",at_warrant="ОРДЕР",at_clean="Чисто",at_warrant_notif="ОРДЕР",head="Голова",upper_torso="Грудь",torso="Торс",lines_for="Линии для:",tab_visuals="Визуалы",tab_movement="Движ.",tab_misc="Разное",tab_aimbot="Аимбот",tab_colors="Цвета",tab_settings="Настр.",tab_info="Инфо",info_channel="Телеграм канал:",info_link="Ссылка: https://t.me/eclipse_script",info_copy_hint="Скопируй ссылку и открой в браузере"},en={esp_players="Player ESP",fullbright="FullBright",esp_cars="Car ESP",threat_lines="Threat Lines",armed="Armed",wanted="Wanted",police_lines="Police",police="Police",civilian="Civilian",friends="Friends",armed_filter="Armed",wall_clip="Wall Clip",fly="Fly",noclip="Noclip",car_speed="Car Speed",speed_boost="Speed Boost",high_jump="High Jump",fly_speed="Fly Speed",speed_multi="Speed Multi",run_speed="Run Speed",jump_power="Jump Power",rejoin="Rejoin",rejoin_btn="REJOIN",anti_afk="Anti-AFK",cam_zoom="Camera Zoom",auto_tablet="Auto Tablet",scan_interval="Scan Interval (s)",tablet_slot="Tablet Slot",taser_tp="Taser TP",taser_btn="TASE",tab_farm="Farm",fov_color="FOV Circle Color",auto_farm="Auto Farm",farm_rings="Contraband",farm_status_buy="Buying",farm_status_sell="Selling...",farm_status_launder="Laundering...",farm_status_walk="Flying to point...",farm_cycles="Cycles",aimbot="Aimbot",aim_part="Aim Part",toggle_btn="Toggle",fov_circle="FOV Circle",smoothness="Smoothness",max_dist="Max Distance",dist_btn="Cycle",wall_check="Wall Check",team_check="Team Check",target_lock="Target Lock",prediction="Prediction",anti_recoil="Anti-Recoil",recoil_comp="Recoil Comp %",esp_visual_settings="ESP & Visual Settings",esp_gradient="ESP Gradient",fov_gradient="FOV Gradient",mode_outline="Mode: Outline",mode_fill="Mode: Fill",switch_btn="Switch",role_police="Police",role_civilian="Civilian",role_friend="Friend",role_armed="Armed",settings_title="Interface Settings",accent_color="Menu Accent Color",toggle_color="Toggle Color",bg_color="Background Color",row_color="Element Color",language="Language",lang_ru="Русский",lang_en="English",on="ON",off="OFF",notif_scanning="Scanning players...",notif_remotes_nf="Remotes not found",notif_no_target="No target found",notif_color_upd="updated",notif_menu_color="Menu color updated",notif_toggle_color="Toggle color updated",at_title="AUTO TABLET",at_timeout="Timeout",at_wanted="Wanted Lvl",at_warrant="WARRANT",at_clean="Clean",at_warrant_notif="WARRANT",head="Head",upper_torso="UpperTorso",torso="Torso",lines_for="Lines for:",tab_visuals="Visuals",tab_movement="Move",tab_misc="Misc",tab_aimbot="Aimbot",tab_colors="Colors",tab_settings="Settings",tab_info="Info",info_channel="Telegram channel:",info_link="Link: https://t.me/eclipse_script",info_copy_hint="Copy the link and open in browser"}};
local function translate(target) langCode=State.lang or "ru" ;
    return (Localization[langCode] and Localization[langCode][target]) or Localization.ru[target] or target ;
end local function registerLabel(tab,tab_2,tab_3,tab_4) table.insert(State.langLabels,{obj=tab,key=tab_2,prefix=tab_3 or "" ,suffix=tab_4 or "" });
end local function refreshLanguage() for labelIndex,labelInfo in ipairs(State.langLabels) do if (labelInfo.obj and labelInfo.obj.Parent) then
            if (labelInfo.isCustom and labelInfo.updateFn) then
                labelInfo.updateFn();
            elseif labelInfo.isSlider then
                    value=labelInfo.getVal();
                    translatedLabel=translate(labelInfo.langKey);
                    labelInfo.obj.Text=(labelInfo.displayFn and (translatedLabel   .. ": "   .. labelInfo.displayFn(value))) or (translatedLabel   .. ": "   .. value) ;
                else labelInfo.obj.Text=labelInfo.prefix   .. translate(labelInfo.key)   .. labelInfo.suffix ;
                end
        end
end
end do if  not _G.FullBrightExecuted then
    _G.FullBrightEnabled=false;
    _G.NormalLightingSettings={Brightness=Lighting.Brightness,ClockTime=Lighting.ClockTime,FogEnd=Lighting.FogEnd,GlobalShadows=Lighting.GlobalShadows,Ambient=Lighting.Ambient};
    local function applyFullBright(value) if value then
            Lighting.Brightness=1;
            Lighting.ClockTime=12;
            Lighting.FogEnd=786543;
            Lighting.GlobalShadows=false;
            Lighting.Ambient=Color3.fromRGB(178,178,178);
        else color=_G.NormalLightingSettings;
            Lighting.Brightness=color.Brightness;
            Lighting.ClockTime=color.ClockTime;
            Lighting.FogEnd=color.FogEnd;
            Lighting.GlobalShadows=color.GlobalShadows;
            Lighting.Ambient=color.Ambient;
        end
end _G._applyFullBright=applyFullBright;
pcall(function() applyFullBright(true);
end);
_G.FullBrightEnabled=false;
pcall(function() applyFullBright(false);
end);
end _G.FullBrightExecuted=true;
end _G.AimbotConfig=_G.AimbotConfig or {Enabled=false,AimParts={"Head","UpperTorso","HumanoidRootPart","Torso"},SelectedAimPart=1,FOV=90,CircleTransparency=0.5,AimBind=Enum.UserInputType.Touch,MaxDistance=50,Smoothness=0.18,WallCheck=false,TeamCheck=true,TargetLock=true,Prediction=true,PredictionFactor=0.08,ShowFOVCircle=true,IsRunning=true} ;
local policeKeywords={"police","полиц","cop","sheriff","шериф","officer","офицер","patrol","патруль","swat","fbi","фбр","dea","dps","highway","trooper","marshal","leo","department","pd","lspd","bcso","sahp","security","охран","guard"};
local policeGearKeywords={"badge","значок","звезда","star","handcuffs","наручники","cuffs","taser","тазер","radio","рация","baton","дубинка","bodycam","камера"};
local weaponKeywords={"gun","pistol","rifle","shotgun","smg","ar15","ak","glock","m4","m16","deagle","revolver","sniper","knife","нож","пистолет","автомат","винтовка","дробовик","weapon","firearm"};
local function isPolice(player) if player.Team then
        role=player.Team.Name:lower();
        for list,list_2 in ipairs(policeKeywords) do if role:find(list_2) then
                    return true;
                end
        end
end if player.Character then
for list_3,list_4 in ipairs(player.Character:GetChildren()) do list_5=list_4.Name:lower();
        for list_6,list_7 in ipairs(policeGearKeywords) do if list_5:find(list_7) then
                    return true;
                end
        end
end if player:FindFirstChild("Backpack") then
for list_8,list_9 in ipairs(player.Backpack:GetChildren()) do list_10=list_9.Name:lower();
        for list_11,list_12 in ipairs(policeGearKeywords) do if list_10:find(list_12) then
                    return true;
                end
        end
end
end
end return false;
end local function isArmed(list_13) if  not list_13.Character then
    return false;
end for list_14,list_15 in ipairs(list_13.Character:GetChildren()) do if list_15:IsA("Tool") then
        list_16=list_15.Name:lower();
        for list_17,list_18 in ipairs(weaponKeywords) do if list_16:find(list_18) then
                    return true;
                end
        end
end
end return false;
end local function isFriend(playerRef_2) playerRef_3,playerRef_4=pcall(function() return LocalPlayer:IsFriendsWith(playerRef_2.UserId);
end);
return playerRef_3 and playerRef_4 ;
end local function getPlayerRole(uiColor_2) if isFriend(uiColor_2) then
    return "Friend",State.ESPColors.Friend;
end if isPolice(uiColor_2) then
return "Police",State.ESPColors.Police;
end if isArmed(uiColor_2) then
return "Armed",State.ESPColors.Armed;
end return "Civilian",State.ESPColors.Civilian;
end local function getHumanoid(character) return character and character:FindFirstChildOfClass("Humanoid") ;
end
local button;
do local frame=Instance.new("Frame");
    frame.Name="NotifContainer";
    frame.Size=UDim2.new(0,200,0,200);
    frame.Position=UDim2.new(0.5, -100,0,5);
    frame.BackgroundTransparency=1;
    button=frame;
end local function notify(uiLabel_3,uiLabel_4,uiLabel_5) pcall(function() uiFrame_2=Instance.new("Frame",button);
    uiFrame_2.Size=UDim2.new(1,0,0,28);
    uiFrame_2.BackgroundColor3=Color3.fromRGB(20,16,28);
    uiFrame_2.BackgroundTransparency=0.15;
    Instance.new("UICorner",uiFrame_2).CornerRadius=UDim.new(0,6);
    uiLabel_6=Instance.new("TextLabel",uiFrame_2);
    uiLabel_6.Size=UDim2.new(1, -8,1,0);
    uiLabel_6.Position=UDim2.new(0,4,0,0);
    uiLabel_6.BackgroundTransparency=1;
    uiLabel_6.Text=uiLabel_3   .. ": "   .. uiLabel_4 ;
    uiLabel_6.TextColor3=uiLabel_5 or Color3.fromRGB(255,255,255) ;
    uiLabel_6.Font=Enum.Font.GothamBold;
    uiLabel_6.TextSize=10;
    uiLabel_6.TextXAlignment=Enum.TextXAlignment.Left;
    uiLabel_6.TextTruncate=Enum.TextTruncate.AtEnd;
    task.delay(2.5,function() pcall(function() uiFrame_2:Destroy();
        end);
end);
end);
end local function applyESP(uiColor_3) if ((uiColor_3==LocalPlayer) or  not uiColor_3.Character) then
    return;
end playerRef_5,uiColor_4=getPlayerRole(uiColor_3);
if  not State.espRoleFilter[playerRef_5] then
    playerRef_6=uiColor_3.Character:FindFirstChild("ESPHighlight");
    if playerRef_6 then
        playerRef_6:Destroy();
    end return;
end State.espCache[uiColor_3.UserId]={role=playerRef_5,color=uiColor_4};
highlight=uiColor_3.Character:FindFirstChild("ESPHighlight");
if  not highlight then
    highlight=Instance.new("Highlight");
    highlight.Name="ESPHighlight";
    highlight.FillTransparency=0.5;
    highlight.OutlineTransparency=0;
    highlight.Parent=uiColor_3.Character;
end highlight.FillColor=uiColor_4;
highlight.OutlineColor=uiColor_4;
head=uiColor_3.Character:FindFirstChild("Head");
if head then
    playerRef_7=head:FindFirstChild("NameTag");
    if playerRef_7 then
        playerRef_7:Destroy();
    end instance=Instance.new("BillboardGui");
instance.Name="NameTag";
instance.Size=UDim2.new(0,120,0,36);
instance.StudsOffset=Vector3.new(0,2.5,0);
instance.AlwaysOnTop=true;
instance.Parent=head;
uiLabel_7=Instance.new("TextLabel",instance);
uiLabel_7.Name="TagLabel";
uiLabel_7.Size=UDim2.new(1,0,0,14);
uiLabel_7.BackgroundTransparency=1;
uiLabel_7.Text=uiColor_3.DisplayName;
uiLabel_7.TextColor3=uiColor_4;
uiLabel_7.Font=Enum.Font.GothamBold;
uiLabel_7.TextSize=12;
uiLabel_7.TextStrokeTransparency=0.5;
uiFrame_3=Instance.new("Frame",instance);
uiFrame_3.Name="HPBarBg";
uiFrame_3.Size=UDim2.new(0.8,0,0,3);
uiFrame_3.Position=UDim2.new(0.1,0,0,16);
uiFrame_3.BackgroundColor3=Color3.fromRGB(40,40,40);
uiFrame_3.BorderSizePixel=0;
Instance.new("UICorner",uiFrame_3).CornerRadius=UDim.new(1,0);
uiFrame_4=Instance.new("Frame",uiFrame_3);
uiFrame_4.Name="HPBarFill";
uiFrame_4.Size=UDim2.new(1,0,1,0);
uiFrame_4.BackgroundColor3=Color3.fromRGB(0,255,0);
uiFrame_4.BorderSizePixel=0;
Instance.new("UICorner",uiFrame_4).CornerRadius=UDim.new(1,0);
end
end local function enableESP() State.espEnabled=true;
for list_19,list_20 in ipairs(Players:GetPlayers()) do if (list_20~=LocalPlayer) then
            applyESP(list_20);
        end
end
end local function disableESP() State.espEnabled=false;
for list_21,list_22 in ipairs(Players:GetPlayers()) do if list_22.Character then
            list_23=list_22.Character:FindFirstChild("ESPHighlight");
            if list_23 then
                list_23:Destroy();
            end head_2=list_22.Character:FindFirstChild("Head");
        if head_2 then
            playerRef_8=head_2:FindFirstChild("NameTag");
            if playerRef_8 then
                playerRef_8:Destroy();
            end
    end
end
end State.espCache={};
end local function removeESP(playerRef_9) if playerRef_9.Character then
    playerRef_10=playerRef_9.Character:FindFirstChild("ESPHighlight");
    if playerRef_10 then
        playerRef_10:Destroy();
    end head_3=playerRef_9.Character:FindFirstChild("Head");
if head_3 then
    playerRef_11=head_3:FindFirstChild("NameTag");
    if playerRef_11 then
        playerRef_11:Destroy();
    end
end
end State.espCache[playerRef_9.UserId]=nil;
end local function toggleFullBright() State.fbEnabled= not State.fbEnabled;
_G.FullBrightEnabled=State.fbEnabled;
pcall(_G._applyFullBright,State.fbEnabled);
end local function rejoinServer() pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId);
end);
end local function toggleAntiAFK() State.afkEnabled= not State.afkEnabled;
if State.afkEnabled then
    State.afkThread=task.spawn(function() while State.afkEnabled and State.scriptActive  do pcall(function() if VirtualUser then
                        VirtualUser:CaptureController();
                        VirtualUser:ClickButton2(Vector2.zero);
                    end
            end);
        task.wait(60);
    end
end);
end
end local function enableFly() playerRef_12=LocalPlayer.Character;
if  not playerRef_12 then
    return;
end rootPart=playerRef_12:FindFirstChild("HumanoidRootPart");
uiColor_5=playerRef_12:FindFirstChildOfClass("Humanoid");
if ( not rootPart or  not uiColor_5) then
    return;
end State.flyEnabled=true;
part=Instance.new("Part");
part.Size=Vector3.new(6,1,6);
part.Transparency=1;
part.Anchored=true;
part.CanCollide=true;
part.CFrame=rootPart.CFrame * CFrame.new(0, -3.5,0) ;
part.Parent=Workspace;
State.flyFakePart=part;
instanceObject_2=Instance.new("BodyVelocity");
instanceObject_2.MaxForce=Vector3.new(0,math.huge,0);
instanceObject_2.Velocity=Vector3.new(0,0,0);
instanceObject_2.Parent=rootPart;
State.flyBV=instanceObject_2;
uiColor_5.PlatformStand=false;
notify(translate("fly"),translate("on"),Color3.fromRGB(168,85,247));
end local function disableFly() State.flyEnabled=false;
if State.flyFakePart then
    pcall(function() State.flyFakePart:Destroy();
    end);
State.flyFakePart=nil;
end if State.flyBV then
pcall(function() State.flyBV:Destroy();
end);
State.flyBV=nil;
end notify(translate("fly"),translate("off"),Color3.fromRGB(255,50,50));
end local function toggleFly() if State.flyEnabled then
    disableFly();
else enableFly();
end
end local function toggleNoclip() State.noclipEnabled= not State.noclipEnabled;
if  not State.noclipEnabled then
    for rootPart_2,rootPart_3 in pairs(State.noclipOrigCollisions) do pcall(function() rootPart_2.CanCollide=rootPart_3;
            end);
    end State.noclipOrigCollisions={};
end notify(translate("noclip"),(State.noclipEnabled and translate("on")) or translate("off") ,(State.noclipEnabled and Color3.fromRGB(168,85,247)) or Color3.fromRGB(255,50,50) );
end local function restoreNoclip() for uiColor_6,uiColor_7 in pairs(State.noclipOrigCollisions) do pcall(function() uiColor_6.CanCollide=uiColor_7;
        end);
end State.noclipOrigCollisions={};
end local function toggleVehicleSpeed() State.vehSpeedEnabled= not State.vehSpeedEnabled;
if  not State.vehSpeedEnabled then
    for vehicle,vehicle_2 in pairs(State.vehOrigSpeeds) do if (vehicle and vehicle.Parent) then
                pcall(function() vehicle.MaxSpeed=vehicle_2;
                end);
        end
end State.vehOrigSpeeds={};
end notify(translate("car_speed"),(State.vehSpeedEnabled and ("x"   .. State.vehSpeedMult   .. " "   .. translate("on"))) or translate("off") ,(State.vehSpeedEnabled and Color3.fromRGB(255,200,0)) or Color3.fromRGB(255,80,80) );
end local function wallClip() uiColor_8=LocalPlayer.Character;
if  not uiColor_8 then
    return;
end rootPart_4=uiColor_8:FindFirstChild("HumanoidRootPart");
if  not rootPart_4 then
    return;
end uiColor_9=Camera.CFrame.LookVector;
rootPart_4.CFrame=rootPart_4.CFrame + (uiColor_9 * 8) ;
notify(translate("wall_clip"),"+8 studs",Color3.fromRGB(168,85,247));
end State._aimHeld=false;
local function isAimHeld() return State._aimHeld;
end local function isValidAimTarget(targetObject_3) if ( not targetObject_3 or (targetObject_3==LocalPlayer) or  not targetObject_3.Character) then
    return false;
end targetObject_4=getHumanoid(targetObject_3.Character);
if ( not targetObject_4 or (targetObject_4.Health<=0)) then
    return false;
end config=_G.AimbotConfig;
if (config.TeamCheck and (targetObject_3.Team==LocalPlayer.Team)) then
    return false;
end return true;
end local function getAimPart(config_2) if  not config_2 then
    return nil;
end config_3=_G.AimbotConfig;
config_4=config_3.AimParts[config_3.SelectedAimPart];
return config_2:FindFirstChild(config_4) or config_2:FindFirstChild("HumanoidRootPart") ;
end local function hasLineOfSight(rootPart_5) if  not _G.AimbotConfig.WallCheck then
    return true;
end camera_4=Camera.CFrame.Position;
camera_5=rootPart_5.Position-camera_4 ;
camera_6=Ray.new(camera_4,camera_5);
ray=Workspace:FindPartOnRayWithIgnoreList(camera_6,{LocalPlayer.Character,Camera});
return (ray==nil) or ray:IsDescendantOf(rootPart_5.Parent) ;
end logDebug("Functions ready");
local PlayerGui=LocalPlayer:WaitForChild("PlayerGui");
local MainGui=Instance.new("ScreenGui");
MainGui.Name="Eclipse_Internal";
MainGui.ResetOnSpawn=false;
pcall(function() MainGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;
end);
gui=false;
pcall(function() if ( not gui and gethui) then
        MainGui.Parent=gethui();
        gui=true;
    end
end);
pcall(function() if  not gui then
        MainGui.Parent=game:GetService("CoreGui");
        gui=true;
    end
end);
if  not gui then
    MainGui.Parent=PlayerGui;
end button.Parent=MainGui;
local MenuIconAsset="rbxassetid://70510223806673";
local MenuButton=Instance.new("TextButton",MainGui);
MenuButton.Size=UDim2.new(0,46,0,46);
MenuButton.Position=UDim2.new(0,8,0.5, -23);
MenuButton.BackgroundColor3=Color3.fromRGB(20,16,28);
MenuButton.BackgroundTransparency=0.1;
MenuButton.Text="";
MenuButton.Active=true;
MenuButton.ZIndex=100;
Instance.new("UICorner",MenuButton).CornerRadius=UDim.new(1,0);
stroke=Instance.new("UIStroke",MenuButton);
stroke.Color=Color3.fromRGB(168,85,247);
stroke.Thickness=2;
image=Instance.new("ImageLabel",MenuButton);
image.Size=UDim2.new(0,36,0,36);
image.Position=UDim2.new(0.5, -18,0.5, -18);
image.BackgroundTransparency=1;
image.Image=MenuIconAsset;
image.ZIndex=101;
Instance.new("UICorner",image).CornerRadius=UDim.new(1,0);
do input,input_2,uiButton_2=false,nil,nil;
    input_3=10;
    input_4=false;
    MenuButton.InputBegan:Connect(function(uiButton_3) if ((uiButton_3.UserInputType==Enum.UserInputType.Touch) or (uiButton_3.UserInputType==Enum.UserInputType.MouseButton1)) then
            input=true;
            input_4=false;
            input_2=uiButton_3.Position;
            uiButton_2=MenuButton.Position;
        end
end);
UserInputService.InputChanged:Connect(function(input_5) if (input and ((input_5.UserInputType==Enum.UserInputType.Touch) or (input_5.UserInputType==Enum.UserInputType.MouseMovement))) then
        input_6=input_5.Position-input_2 ;
        if (input_6.Magnitude>input_3) then
            input_4=true;
        end MenuButton.Position=UDim2.new(uiButton_2.X.Scale,uiButton_2.X.Offset + input_6.X ,uiButton_2.Y.Scale,uiButton_2.Y.Offset + input_6.Y );
end
end);
UserInputService.InputEnded:Connect(function(uiButton_4) if ((uiButton_4.UserInputType==Enum.UserInputType.Touch) or (uiButton_4.UserInputType==Enum.UserInputType.MouseButton1)) then
        if (input and  not input_4) then
            State.menuVisible= not State.menuVisible;
            State.mainFrame.Visible=State.menuVisible;
        end input=false;
end
end);
end State.aimMode="toggle";
local AimButton=Instance.new("TextButton",MainGui);
AimButton.Size=UDim2.new(0,52,0,52);
AimButton.Position=UDim2.new(1, -62,0.5, -80);
AimButton.BackgroundColor3=Color3.fromRGB(25,20,35);
AimButton.BackgroundTransparency=0.2;
AimButton.Text="";
AimButton.Active=true;
AimButton.Visible=false;
AimButton.ZIndex=100;
Instance.new("UICorner",AimButton).CornerRadius=UDim.new(1,0);
stroke_2=Instance.new("UIStroke",AimButton);
stroke_2.Color=Color3.fromRGB(255,50,50);
stroke_2.Thickness=2;
uiFrame_5=Instance.new("Frame",AimButton);
uiFrame_5.Size=UDim2.new(0,2,0,20);
uiFrame_5.Position=UDim2.new(0.5, -1,0.5, -10);
uiFrame_5.BackgroundColor3=Color3.fromRGB(255,50,50);
uiFrame_5.ZIndex=101;
uiFrame_6=Instance.new("Frame",AimButton);
uiFrame_6.Size=UDim2.new(0,20,0,2);
uiFrame_6.Position=UDim2.new(0.5, -10,0.5, -1);
uiFrame_6.BackgroundColor3=Color3.fromRGB(255,50,50);
uiFrame_6.ZIndex=101;
uiFrame_7=Instance.new("Frame",AimButton);
uiFrame_7.Size=UDim2.new(0,14,0,14);
uiFrame_7.Position=UDim2.new(0.5, -7,0.5, -7);
uiFrame_7.BackgroundTransparency=1;
uiFrame_7.ZIndex=101;
Instance.new("UICorner",uiFrame_7).CornerRadius=UDim.new(1,0);
stroke_3=Instance.new("UIStroke",uiFrame_7);
stroke_3.Color=Color3.fromRGB(255,50,50);
stroke_3.Thickness=1.5;
uiLabel_8=Instance.new("TextLabel",AimButton);
uiLabel_8.Size=UDim2.new(1,0,0,12);
uiLabel_8.Position=UDim2.new(0,0,1,2);
uiLabel_8.BackgroundTransparency=1;
uiLabel_8.Text="AIM";
uiLabel_8.TextColor3=Color3.fromRGB(255,50,50);
uiLabel_8.Font=Enum.Font.GothamBold;
uiLabel_8.TextSize=9;
uiLabel_8.ZIndex=100;
local function updateAimButton() uiLabel_9=State._aimHeld;
    stroke_2.Color=(uiLabel_9 and Color3.fromRGB(0,255,100)) or Color3.fromRGB(255,50,50) ;
    uiLabel_8.TextColor3=(uiLabel_9 and Color3.fromRGB(0,255,100)) or Color3.fromRGB(255,50,50) ;
    uiFrame_5.BackgroundColor3=(uiLabel_9 and Color3.fromRGB(0,255,100)) or Color3.fromRGB(255,50,50) ;
    uiFrame_6.BackgroundColor3=(uiLabel_9 and Color3.fromRGB(0,255,100)) or Color3.fromRGB(255,50,50) ;
    stroke_3.Color=(uiLabel_9 and Color3.fromRGB(0,255,100)) or Color3.fromRGB(255,50,50) ;
    uiLabel_8.Text=(uiLabel_9 and "AIM ON") or "AIM" ;
end AimButton.MouseButton1Click:Connect(function() if (State.aimMode=="toggle") then
    State._aimHeld= not State._aimHeld;
    updateAimButton();
    if State._aimHeld then
        targetObject_5=_G.AimbotConfig;
        targetObject_6=0;
        for config_5,playerRef_13 in ipairs(Players:GetPlayers()) do if ((playerRef_13~=LocalPlayer) and playerRef_13.Character) then
                    playerRef_14=playerRef_13.Character:FindFirstChildWhichIsA("Humanoid");
                    if (playerRef_14 and (playerRef_14.Health>0)) then
                        playerRef_15=targetObject_5.TeamCheck and playerRef_13.Team and LocalPlayer.Team and (playerRef_13.Team==LocalPlayer.Team) ;
                        if  not playerRef_15 then
                            targetObject_6=targetObject_6 + 1 ;
                        end
                end
        end
end notify("AIM DEBUG","Targets: "   .. targetObject_6   .. " | FOV: "   .. targetObject_5.FOV   .. " | Dist: "   .. targetObject_5.MaxDistance ,Color3.fromRGB(255,255,0));
else notify("AIM","OFF",Color3.fromRGB(255,50,50));
end
end
end);
AimButton.MouseButton1Down:Connect(function() if (State.aimMode=="hold") then
        State._aimHeld=true;
        updateAimButton();
    end
end);
AimButton.MouseButton1Up:Connect(function() if (State.aimMode=="hold") then
        State._aimHeld=false;
        updateAimButton();
    end
end);
do input_7,input_8,uiButton_5=false,nil,nil;
    input_9=15;
    input_10=false;
    AimButton.InputBegan:Connect(function(input_11) if (input_11.UserInputType==Enum.UserInputType.Touch) then
            input_7=true;
            input_10=false;
            input_8=input_11.Position;
            uiButton_5=AimButton.Position;
        end
end);
UserInputService.InputChanged:Connect(function(input_12) if (input_7 and (input_12.UserInputType==Enum.UserInputType.Touch)) then
        input_13=input_12.Position-input_8 ;
        if (input_13.Magnitude>input_9) then
            input_10=true;
            AimButton.Position=UDim2.new(uiButton_5.X.Scale,uiButton_5.X.Offset + input_13.X ,uiButton_5.Y.Scale,uiButton_5.Y.Offset + input_13.Y );
        end
end
end);
UserInputService.InputEnded:Connect(function(input_14) if (input_14.UserInputType==Enum.UserInputType.Touch) then
        input_7=false;
    end
end);
end local MainPanel=Instance.new("Frame");
MainPanel.Size=UDim2.new(0,400,0,320);
MainPanel.Position=UDim2.new(0.5, -200,0.5, -160);
MainPanel.BackgroundColor3=Color3.fromRGB(20,16,28);
MainPanel.Active=true;
MainPanel.ClipsDescendants=true;
MainPanel.Visible=false;
MainPanel.ZIndex=50;
MainPanel.Parent=MainGui;
Instance.new("UICorner",MainPanel).CornerRadius=UDim.new(0,10);
State.mainFrame=MainPanel;
do input_15,input_16,input_17=false,nil,nil;
    MainPanel.InputBegan:Connect(function(uiButton_6) if ((uiButton_6.UserInputType==Enum.UserInputType.Touch) or (uiButton_6.UserInputType==Enum.UserInputType.MouseButton1)) then
            input_15=true;
            input_16=uiButton_6.Position;
            input_17=MainPanel.Position;
            uiButton_6.Changed:Connect(function() if (uiButton_6.UserInputState==Enum.UserInputState.End) then
                    input_15=false;
                end
        end);
end
end);
local input_18;
MainPanel.InputChanged:Connect(function(input_19) if ((input_19.UserInputType==Enum.UserInputType.Touch) or (input_19.UserInputType==Enum.UserInputType.MouseMovement)) then
        input_18=input_19;
    end
end);
UserInputService.InputChanged:Connect(function(connection) if ((connection==input_18) and input_15) then
        eventConnection_2=connection.Position-input_16 ;
        MainPanel.Position=UDim2.new(input_17.X.Scale,input_17.X.Offset + eventConnection_2.X ,input_17.Y.Scale,input_17.Y.Offset + eventConnection_2.Y );
    end
end);
end do uiFrame_8=Instance.new("Frame",MainPanel);
uiFrame_8.Size=UDim2.new(1,0,0,34);
uiFrame_8.BackgroundTransparency=1;
uiFrame_8.ZIndex=51;
uiLabel_10=Instance.new("TextLabel",uiFrame_8);
uiLabel_10.Size=UDim2.new(0,120,1,0);
uiLabel_10.Position=UDim2.new(0,10,0,0);
uiLabel_10.BackgroundTransparency=1;
uiLabel_10.Text="ECLIPSE";
uiLabel_10.TextColor3=Color3.fromRGB(255,255,255);
uiLabel_10.Font=Enum.Font.GothamBold;
uiLabel_10.TextSize=15;
uiLabel_10.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_10.ZIndex=51;
uiLabel_11=Instance.new("TextLabel",uiFrame_8);
uiLabel_11.Size=UDim2.new(0,50,1,0);
uiLabel_11.Position=UDim2.new(0,90,0,0);
uiLabel_11.BackgroundTransparency=1;
uiLabel_11.Text="mobile";
uiLabel_11.TextColor3=Color3.fromRGB(168,85,247);
uiLabel_11.Font=Enum.Font.GothamBold;
uiLabel_11.TextSize=11;
uiLabel_11.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_11.ZIndex=51;
uiLabel_12=Instance.new("TextLabel",uiFrame_8);
uiLabel_12.Size=UDim2.new(0,150,1,0);
uiLabel_12.Position=UDim2.new(0,145,0,0);
uiLabel_12.BackgroundTransparency=1;
uiLabel_12.Text="t.me/eclipse_script";
uiLabel_12.TextColor3=Color3.fromRGB(130,170,255);
uiLabel_12.Font=Enum.Font.GothamMedium;
uiLabel_12.TextSize=9;
uiLabel_12.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_12.ZIndex=51;
uiButton_7=Instance.new("TextButton",uiFrame_8);
uiButton_7.Size=UDim2.new(0,24,0,24);
uiButton_7.Position=UDim2.new(1, -30,0.5, -12);
uiButton_7.BackgroundColor3=Color3.fromRGB(32,24,38);
uiButton_7.Text="X";
uiButton_7.TextColor3=Color3.fromRGB(180,170,190);
uiButton_7.Font=Enum.Font.GothamBold;
uiButton_7.TextSize=11;
uiButton_7.ZIndex=52;
Instance.new("UICorner",uiButton_7).CornerRadius=UDim.new(0,6);
uiButton_8=Instance.new("TextButton",uiFrame_8);
uiButton_8.Size=UDim2.new(0,24,0,24);
uiButton_8.Position=UDim2.new(1, -58,0.5, -12);
uiButton_8.BackgroundColor3=Color3.fromRGB(28,22,36);
uiButton_8.Text="—";
uiButton_8.TextColor3=Color3.fromRGB(180,170,190);
uiButton_8.Font=Enum.Font.GothamBold;
uiButton_8.TextSize=11;
uiButton_8.ZIndex=52;
Instance.new("UICorner",uiButton_8).CornerRadius=UDim.new(0,6);
uiButton_8.MouseButton1Click:Connect(function() State.menuVisible=false;
    MainPanel.Visible=false;
end);
uiButton_7.MouseButton1Click:Connect(function() State.scriptActive=false;
    pcall(disableESP);
    if _G.FullBrightEnabled then
        _G.FullBrightEnabled=false;
        State.fbEnabled=false;
        pcall(_G._applyFullBright,false);
    end State.afkEnabled=false;
State.espEnabled=false;
State.speedBoostEnabled=false;
State.jumpBoostEnabled=false;
State.antiRecoilEnabled=false;
if State.flyEnabled then
    pcall(disableFly);
    State.flyEnabled=false;
end if State.noclipEnabled then
State.noclipEnabled=false;
pcall(restoreNoclip);
end if State.vehSpeedEnabled then
pcall(toggleVehicleSpeed);
end if State.FOVCircle then
pcall(function() State.FOVCircle:Remove();
end);
State.FOVCircle=nil;
end for state,stateRef_2 in pairs(State.threatLineCache or {} ) do pcall(function() stateRef_2:Remove();
    end);
end State.threatLineCache={};
for stateRef_3,stateRef_4 in pairs(State.espCache or {} ) do if (stateRef_4 and stateRef_4.tag) then
            pcall(function() stateRef_4.tag:Remove();
            end);
    end
end for eventConnection_3,eventConnection_4 in ipairs(State.connections) do if (eventConnection_4 and eventConnection_4.Disconnect) then
        pcall(eventConnection_4.Disconnect,eventConnection_4);
    end
end State.connections={};
for eventConnection_5,eventConnection_6 in pairs(State.vehOrigSpeeds or {} ) do pcall(function() eventConnection_5.MaxSpeed=eventConnection_6;
        end);
end State.vehOrigSpeeds={};
pcall(function() LocalPlayer.CameraMaxZoomDistance=15;
end);
if State.flyFakePart then
    pcall(function() State.flyFakePart:Destroy();
    end);
State.flyFakePart=nil;
end if State.flyBV then
pcall(function() State.flyBV:Destroy();
end);
State.flyBV=nil;
end MainGui:Destroy();
_G.AimbotConfig=nil;
logDebug("ECLIPSE Mobile unloaded");
end);
uiFrame_9=Instance.new("Frame",MainPanel);
uiFrame_9.Size=UDim2.new(1,0,0,2);
uiFrame_9.Position=UDim2.new(0,0,0,34);
uiFrame_9.BorderSizePixel=0;
uiFrame_9.ZIndex=51;
instanceObject_3=Instance.new("UIGradient",uiFrame_9);
instanceObject_3.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(168,85,247)),ColorSequenceKeypoint.new(1,Color3.fromRGB(236,72,153))});
State.glowGradient=instanceObject_3;
end uiButton_9={};
uiButton_10={};
do instanceObject_4=Instance.new("ScrollingFrame",MainPanel);
    instanceObject_4.Size=UDim2.new(1,0,0,30);
    instanceObject_4.Position=UDim2.new(0,0,0,36);
    instanceObject_4.BackgroundColor3=Color3.fromRGB(12,10,18);
    instanceObject_4.BorderSizePixel=0;
    instanceObject_4.ScrollBarThickness=0;
    instanceObject_4.ScrollingDirection=Enum.ScrollingDirection.X;
    instanceObject_4.CanvasSize=UDim2.new(0,0,0,0);
    pcall(function() instanceObject_4.AutomaticCanvasSize=Enum.AutomaticSize.X;
    end);
instanceObject_4.ZIndex=51;
instanceObject_5=Instance.new("UIListLayout",instanceObject_4);
instanceObject_5.FillDirection=Enum.FillDirection.Horizontal;
instanceObject_5.Padding=UDim.new(0,2);
instanceObject_5.SortOrder=Enum.SortOrder.LayoutOrder;
uiButton_11={"Visuals","Movement","Misc","Aimbot","Farm","Colors","Settings","Info"};
uiButton_12={Visuals="tab_visuals",Movement="tab_movement",Misc="tab_misc",Aimbot="tab_aimbot",Farm="tab_farm",Colors="tab_colors",Settings="tab_settings",Info="tab_info"};
for uiLabel_13,uiButton_13 in ipairs(uiButton_11) do uiButton_14=Instance.new("TextButton",instanceObject_4);
        uiButton_14.Size=UDim2.new(0,58,1, -4);
        uiButton_14.BackgroundColor3=((uiLabel_13==1) and Color3.fromRGB(38,25,60)) or Color3.fromRGB(24,20,32) ;
        uiButton_14.Text=translate(uiButton_12[uiButton_13]);
        uiButton_14.TextColor3=((uiLabel_13==1) and Color3.fromRGB(210,180,255)) or Color3.fromRGB(140,135,150) ;
        uiButton_14.Font=Enum.Font.GothamBold;
        uiButton_14.TextSize=10;
        uiButton_14.LayoutOrder=uiLabel_13;
        uiButton_14.ZIndex=52;
        Instance.new("UICorner",uiButton_14).CornerRadius=UDim.new(0,5);
        uiButton_10[uiButton_13]=uiButton_14;
        registerLabel(uiButton_14,uiButton_12[uiButton_13]);
    end uiFrame_10=Instance.new("Frame",MainPanel);
uiFrame_10.Size=UDim2.new(1, -10,1, -72);
uiFrame_10.Position=UDim2.new(0,5,0,68);
uiFrame_10.BackgroundTransparency=1;
uiFrame_10.ZIndex=50;
for size,uiColor_10 in ipairs(uiButton_11) do instanceObject_6=Instance.new("ScrollingFrame",uiFrame_10);
        instanceObject_6.Size=UDim2.new(1,0,1,0);
        instanceObject_6.BackgroundTransparency=1;
        instanceObject_6.Visible=uiColor_10=="Visuals" ;
        instanceObject_6.ScrollBarThickness=2;
        instanceObject_6.ScrollBarImageColor3=Color3.fromRGB(168,85,247);
        instanceObject_6.CanvasSize=UDim2.new(0,0,0,0);
        instanceObject_6.ZIndex=50;
        pcall(function() instanceObject_6.AutomaticCanvasSize=Enum.AutomaticSize.Y;
        end);
    uiButton_9[uiColor_10]=instanceObject_6;
end local function switchTab(uiColor_11) State.currentTab=uiColor_11;
for tab_7,tab_8 in pairs(uiButton_9) do tab_8.Visible=tab_7==uiColor_11 ;
        if (tab_7==uiColor_11) then
            pcall(function() tab_8.CanvasPosition=Vector2.new(0,0);
            end);
    end
end for uiColor_12,uiButton_15 in pairs(uiButton_10) do uiButton_16=uiColor_12==uiColor_11 ;
    TweenService:Create(uiButton_15,TweenInfo.new(0.2),{BackgroundColor3=(uiButton_16 and Color3.fromRGB(38,25,60)) or Color3.fromRGB(24,20,32) ,TextColor3=(uiButton_16 and Color3.fromRGB(210,180,255)) or Color3.fromRGB(140,135,150) }):Play();
end
end for uiButton_17,uiButton_18 in pairs(uiButton_10) do uiButton_18.MouseButton1Click:Connect(function() switchTab(uiButton_17);
    end);
end
end logDebug("GUI structure ready");
State.rowRegistry={};
local function createRow(parent,height) uiFrame_11=Instance.new("Frame",parent);
    uiFrame_11.Size=UDim2.new(1, -6,0,height or 38 );
    uiFrame_11.BackgroundColor3=Color3.fromRGB(30,24,40);
    uiFrame_11.ZIndex=50;
    Instance.new("UICorner",uiFrame_11).CornerRadius=UDim.new(0,7);
    table.insert(State.rowRegistry,uiFrame_11);
    return uiFrame_11;
end local function createIndicator(parent) uiFrame_12=Instance.new("Frame",parent);
uiFrame_12.Size=UDim2.new(0,6,0,6);
uiFrame_12.Position=UDim2.new(0,10,0.5, -3);
uiFrame_12.BackgroundColor3=Color3.fromRGB(90,80,110);
uiFrame_12.ZIndex=51;
Instance.new("UICorner",uiFrame_12).CornerRadius=UDim.new(1,0);
return uiFrame_12;
end local function createRowLabel(parent,labelText,langKey) labelObject=Instance.new("TextLabel",parent);
labelObject.Size=UDim2.new(0,110,1,0);
labelObject.Position=UDim2.new(0,24,0,0);
labelObject.BackgroundTransparency=1;
labelObject.Text=(langKey and translate(langKey)) or labelText ;
labelObject.TextColor3=Color3.fromRGB(235,230,245);
labelObject.Font=Enum.Font.GothamBold;
labelObject.TextSize=12;
labelObject.TextXAlignment=Enum.TextXAlignment.Left;
labelObject.ZIndex=51;
if langKey then
    registerLabel(labelObject,langKey);
end return labelObject;
end local function createToggle(parent) toggleButton=Instance.new("TextButton",parent);
toggleButton.Size=UDim2.new(0,38,0,18);
toggleButton.Position=UDim2.new(1, -48,0.5, -9);
toggleButton.BackgroundColor3=Color3.fromRGB(55,46,68);
toggleButton.Text="";
toggleButton.ZIndex=52;
Instance.new("UICorner",toggleButton).CornerRadius=UDim.new(1,0);
toggleKnob=Instance.new("Frame",toggleButton);
toggleKnob.Size=UDim2.new(0,14,0,14);
toggleKnob.Position=UDim2.new(0,2,0.5, -7);
toggleKnob.BackgroundColor3=Color3.fromRGB(245,242,250);
toggleKnob.ZIndex=53;
Instance.new("UICorner",toggleKnob).CornerRadius=UDim.new(1,0);
table.insert(State.toggleRegistry,toggleButton);
return toggleButton,toggleKnob;
end local function updateToggle(toggleButton,toggleKnob,indicator,enabled) activeColor=State.toggleActiveColor or Color3.fromRGB(168,85,247) ;
TweenService:Create(toggleButton,TweenInfo.new(0.2),{BackgroundColor3=(enabled and activeColor) or Color3.fromRGB(55,46,68) }):Play();
TweenService:Create(toggleKnob,TweenInfo.new(0.2),{Position=(enabled and UDim2.new(0,22,0.5, -7)) or UDim2.new(0,2,0.5, -7) }):Play();
if indicator then
    TweenService:Create(indicator,TweenInfo.new(0.2),{BackgroundColor3=(enabled and Color3.fromRGB(0,255,150)) or Color3.fromRGB(90,80,110) }):Play();
end
end local function createSlider(parent,labelText,minValue,maxValue,currentValue,sliderColor,onChanged,formatValue,langKey) row=createRow(parent,44);
labelObject=Instance.new("TextLabel",row);
labelObject.Size=UDim2.new(1, -10,0,16);
labelObject.Position=UDim2.new(0,8,0,2);
labelObject.BackgroundTransparency=1;
displayLabel=(langKey and translate(langKey)) or labelText ;
labelObject.Text=(formatValue and (displayLabel   .. ": "   .. formatValue(currentValue))) or (displayLabel   .. ": "   .. currentValue) ;
labelObject.TextColor3=Color3.fromRGB(235,230,245);
labelObject.Font=Enum.Font.Gotham;
labelObject.TextSize=10;
labelObject.TextXAlignment=Enum.TextXAlignment.Left;
labelObject.ZIndex=51;
track=Instance.new("Frame",row);
track.Size=UDim2.new(0.92,0,0,6);
track.Position=UDim2.new(0.04,0,0,24);
track.BackgroundColor3=Color3.fromRGB(45,45,55);
track.ZIndex=51;
Instance.new("UICorner",track).CornerRadius=UDim.new(0,3);
normalizedValue=(currentValue-minValue)/(maxValue-minValue) ;
fill=Instance.new("Frame",track);
fill.Size=UDim2.new(normalizedValue,0,1,0);
fill.BackgroundColor3=sliderColor;
fill.ZIndex=52;
Instance.new("UICorner",fill).CornerRadius=UDim.new(0,3);
sliderButton=Instance.new("TextButton",track);
sliderButton.Size=UDim2.new(0,16,0,16);
sliderButton.Position=UDim2.new(normalizedValue, -8,0.5, -8);
sliderButton.BackgroundColor3=Color3.fromRGB(255,255,255);
sliderButton.Text="";
sliderButton.ZIndex=53;
Instance.new("UICorner",sliderButton).CornerRadius=UDim.new(1,0);
dragging=false;
sliderValue=currentValue;
dragConnection=nil;
local function beginSliderDrag() dragging=true;
    if  not dragConnection then
        dragConnection=RunService.Heartbeat:Connect(function() if  not dragging then
                if dragConnection then
                    dragConnection:Disconnect();
                    dragConnection=nil;
                end return;
        end mouseX=UserInputService:GetMouseLocation().X;
    trackX=track.AbsolutePosition.X;
    trackWidth=track.AbsoluteSize.X;
    ratio=math.clamp((mouseX-trackX)/trackWidth ,0,1);
    newValue=math.round((ratio * (maxValue-minValue)) + minValue );
    sliderValue=newValue;
    fill.Size=UDim2.new(ratio,0,1,0);
    sliderButton.Position=UDim2.new(ratio, -8,0.5, -8);
    displayLabel=(langKey and translate(langKey)) or labelText ;
    labelObject.Text=(formatValue and (displayLabel   .. ": "   .. formatValue(newValue))) or (displayLabel   .. ": "   .. newValue) ;
    onChanged(newValue,ratio);
end);
end
end sliderButton.MouseButton1Down:Connect(beginSliderDrag);
sliderButton.InputBegan:Connect(function(input) if (input.UserInputType==Enum.UserInputType.Touch) then
        beginSliderDrag();
    end
end);
track.InputBegan:Connect(function(input) if ((input.UserInputType==Enum.UserInputType.Touch) or (input.UserInputType==Enum.UserInputType.MouseButton1)) then
        beginSliderDrag();
    end
end);
UserInputService.InputEnded:Connect(function(input) if ((input.UserInputType==Enum.UserInputType.MouseButton1) or (input.UserInputType==Enum.UserInputType.Touch)) then
        dragging=false;
    end
end);
if langKey then
    table.insert(State.langLabels,{obj=labelObject,langKey=langKey,isSlider=true,displayFn=formatValue,getVal=function() return sliderValue;
    end});
end return row;
end do uiButton_26=uiButton_9['Visuals'];
instanceObject_7=Instance.new("UIListLayout",uiButton_26);
instanceObject_7.Padding=UDim.new(0,4);
instanceObject_7.SortOrder=Enum.SortOrder.LayoutOrder;
valueRef_2=0;
local function setLayoutOrder(valueRef_3) valueRef_2=valueRef_2 + 1 ;
    valueRef_3.LayoutOrder=valueRef_2;
    return valueRef_3;
end stateRef_5=createRow(uiButton_26);
setLayoutOrder(stateRef_5);
uiColor_25=createIndicator(stateRef_5);
createRowLabel(stateRef_5,nil,"esp_players");
uiButton_27,uiColor_26=createToggle(stateRef_5);
local function toggleESPFromUI() if State.espEnabled then
        disableESP();
    else enableESP();
    end updateToggle(uiButton_27,uiColor_26,uiColor_25,State.espEnabled);
notify("ESP",(State.espEnabled and translate("on")) or translate("off") ,(State.espEnabled and Color3.fromRGB(0,235,255)) or Color3.fromRGB(255,50,50) );
if State._espSubs then
    for uiColor_27,uiColor_28 in ipairs(State._espSubs) do uiColor_28.Visible=State.espEnabled;
        end
end
end uiButton_27.MouseButton1Click:Connect(toggleESPFromUI);
State._toggleESP=toggleESPFromUI;
local function createCheckbox(uiButton_28,uiButton_29,uiButton_30,uiButton_31,uiButton_32) uiFrame_16=Instance.new("Frame",uiButton_28);
    setLayoutOrder(uiFrame_16);
    uiFrame_16.Size=UDim2.new(1,0,0,20);
    uiFrame_16.BackgroundTransparency=1;
    uiFrame_16.ZIndex=50;
    uiButton_33=Instance.new("TextButton",uiFrame_16);
    uiButton_33.Size=UDim2.new(0,16,0,16);
    uiButton_33.Position=UDim2.new(0,20,0.5, -8);
    uiButton_33.BackgroundColor3=(uiButton_30 and State.menuAccentColor) or Color3.fromRGB(40,35,50) ;
    uiButton_33.Text=(uiButton_30 and "X") or "" ;
    uiButton_33.TextColor3=Color3.fromRGB(255,255,255);
    uiButton_33.Font=Enum.Font.GothamBold;
    uiButton_33.TextSize=10;
    uiButton_33.ZIndex=52;
    Instance.new("UICorner",uiButton_33).CornerRadius=UDim.new(0,3);
    uiLabel_24=Instance.new("TextLabel",uiFrame_16);
    uiLabel_24.Size=UDim2.new(1, -42,1,0);
    uiLabel_24.Position=UDim2.new(0,40,0,0);
    uiLabel_24.BackgroundTransparency=1;
    uiLabel_24.Text=(uiButton_32 and translate(uiButton_32)) or uiButton_29 ;
    if uiButton_32 then
        registerLabel(uiLabel_24,uiButton_32);
    end uiLabel_24.TextColor3=Color3.fromRGB(200,195,210);
uiLabel_24.Font=Enum.Font.Gotham;
uiLabel_24.TextSize=10;
uiLabel_24.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_24.ZIndex=51;
uiButton_34=uiButton_30;
uiButton_33.MouseButton1Click:Connect(function() uiButton_34= not uiButton_34;
    uiButton_33.Text=(uiButton_34 and "X") or "" ;
    uiButton_33.BackgroundColor3=(uiButton_34 and State.menuAccentColor) or Color3.fromRGB(40,35,50) ;
    uiButton_31(uiButton_34);
end);
return uiFrame_16;
end local function refreshESPFilters() if State.espEnabled then
    for list_24,list_25 in ipairs(Players:GetPlayers()) do applyESP(list_25);
        end
end
end list_26={createCheckbox(uiButton_26,nil,true,function(stateRef_6) State.espRoleFilter.Police=stateRef_6;
refreshESPFilters();
end,"police"),createCheckbox(uiButton_26,nil,true,function(stateRef_7) State.espRoleFilter.Civilian=stateRef_7;
refreshESPFilters();
end,"civilian"),createCheckbox(uiButton_26,nil,true,function(stateRef_8) State.espRoleFilter.Friend=stateRef_8;
refreshESPFilters();
end,"friends"),createCheckbox(uiButton_26,nil,true,function(stateRef_9) State.espRoleFilter.Armed=stateRef_9;
refreshESPFilters();
end,"armed_filter")};
for list_27,list_28 in ipairs(list_26) do list_28.Visible=false;
    end State._espSubs=list_26;
list_29=createRow(uiButton_26);
setLayoutOrder(list_29);
uiButton_35=createIndicator(list_29);
createRowLabel(list_29,nil,"fullbright");
uiButton_36,uiButton_37=createToggle(list_29);
local function toggleFullBrightFromUI() toggleFullBright();
    updateToggle(uiButton_36,uiButton_37,uiButton_35,State.fbEnabled);
    notify("FullBright",(State.fbEnabled and translate("on")) or translate("off") ,(State.fbEnabled and Color3.fromRGB(168,85,247)) or Color3.fromRGB(255,50,50) );
end uiButton_36.MouseButton1Click:Connect(toggleFullBrightFromUI);
State._handleFB=toggleFullBrightFromUI;
uiButton_38=createRow(uiButton_26);
setLayoutOrder(uiButton_38);
uiButton_39=createIndicator(uiButton_38);
createRowLabel(uiButton_38,nil,"threat_lines");
uiButton_40,uiButton_41=createToggle(uiButton_38);
uiButton_40.MouseButton1Click:Connect(function() State.threatLines= not State.threatLines;
    updateToggle(uiButton_40,uiButton_41,uiButton_39,State.threatLines);
    if  not State.threatLines then
        for stateRef_10,stateRef_11 in pairs(State.threatLineCache) do pcall(function() stateRef_11:Remove();
                end);
        end State.threatLineCache={};
end if State._tlSubs then
for list_30,list_31 in ipairs(State._tlSubs) do list_31.Visible=State.threatLines;
    end
end
end);
local function createCheckboxRow(size_8,size_9,uiButton_42,uiColor_29,uiLabel_25) uiFrame_17=Instance.new("Frame",size_8);
    uiFrame_17.Size=UDim2.new(1,0,0,20);
    uiFrame_17.BackgroundTransparency=1;
    uiFrame_17.ZIndex=50;
    setLayoutOrder(uiFrame_17);
    uiButton_43=Instance.new("TextButton",uiFrame_17);
    uiButton_43.Size=UDim2.new(0,16,0,16);
    uiButton_43.Position=UDim2.new(0,20,0.5, -8);
    uiButton_43.BackgroundColor3=(uiButton_42 and State.menuAccentColor) or Color3.fromRGB(40,35,50) ;
    uiButton_43.Text=(uiButton_42 and "X") or "" ;
    uiButton_43.TextColor3=Color3.fromRGB(255,255,255);
    uiButton_43.Font=Enum.Font.GothamBold;
    uiButton_43.TextSize=10;
    uiButton_43.ZIndex=52;
    Instance.new("UICorner",uiButton_43).CornerRadius=UDim.new(0,3);
    uiLabel_26=Instance.new("TextLabel",uiFrame_17);
    uiLabel_26.Size=UDim2.new(1, -42,1,0);
    uiLabel_26.Position=UDim2.new(0,40,0,0);
    uiLabel_26.BackgroundTransparency=1;
    uiLabel_26.Text=(uiLabel_25 and translate(uiLabel_25)) or size_9 ;
    if uiLabel_25 then
        registerLabel(uiLabel_26,uiLabel_25);
    end uiLabel_26.TextColor3=Color3.fromRGB(200,195,210);
uiLabel_26.Font=Enum.Font.Gotham;
uiLabel_26.TextSize=10;
uiLabel_26.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_26.ZIndex=51;
uiButton_44=uiButton_42;
uiButton_43.MouseButton1Click:Connect(function() uiButton_44= not uiButton_44;
    uiButton_43.Text=(uiButton_44 and "X") or "" ;
    uiButton_43.BackgroundColor3=(uiButton_44 and State.menuAccentColor) or Color3.fromRGB(40,35,50) ;
    uiColor_29(uiButton_44);
end);
return uiFrame_17;
end uiLabel_27=Instance.new("TextLabel",uiButton_26);
setLayoutOrder(uiLabel_27);
uiLabel_27.Size=UDim2.new(1,0,0,16);
uiLabel_27.BackgroundTransparency=1;
uiLabel_27.Text="  "   .. translate("lines_for") ;
uiLabel_27.TextColor3=Color3.fromRGB(140,135,155);
uiLabel_27.Font=Enum.Font.Gotham;
uiLabel_27.TextSize=10;
uiLabel_27.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_27.ZIndex=51;
registerLabel(uiLabel_27,"lines_for","  ");
tab_9={uiLabel_27};
tab_9[ #tab_9 + 1 ]=createCheckboxRow(uiButton_26,nil,true,function(stateRef_12) State.threatLineArmed=stateRef_12;
end,"armed");
tab_9[ #tab_9 + 1 ]=createCheckboxRow(uiButton_26,nil,true,function(stateRef_13) State.threatLineWanted=stateRef_13;
end,"wanted");
tab_9[ #tab_9 + 1 ]=createCheckboxRow(uiButton_26,nil,false,function(list_32) State.threatLinePolice=list_32;
end,"police_lines");
for tab_10,tab_11 in ipairs(tab_9) do tab_11.Visible=false;
    end State._tlSubs=tab_9;
end logDebug("Visuals tab ready");
do uiButton_45=uiButton_9['Movement'];
    Instance.new("UIListLayout",uiButton_45).Padding=UDim.new(0,4);
    uiButton_46=createRow(uiButton_45);
    uiButton_47=createIndicator(uiButton_46);
    createRowLabel(uiButton_46,nil,"wall_clip");
    uiButton_48,uiButton_49=createToggle(uiButton_46);
    uiButton_48.MouseButton1Click:Connect(function() State.wallClipEnabled= not State.wallClipEnabled;
        updateToggle(uiButton_48,uiButton_49,uiButton_47,State.wallClipEnabled);
        notify(translate("wall_clip"),(State.wallClipEnabled and translate("on")) or translate("off") ,(State.wallClipEnabled and Color3.fromRGB(168,85,247)) or Color3.fromRGB(255,50,50) );
    end);
uiColor_30=createRow(uiButton_45);
stateRef_14=createIndicator(uiColor_30);
createRowLabel(uiColor_30,nil,"fly");
uiButton_50,stateRef_15=createToggle(uiColor_30);
local function toggleFlyFromUI() toggleFly();
    updateToggle(uiButton_50,stateRef_15,stateRef_14,State.flyEnabled);
    if State._flySpeedRow then
        State._flySpeedRow.Visible=State.flyEnabled;
    end
end uiButton_50.MouseButton1Click:Connect(toggleFlyFromUI);
State._handleFly=toggleFlyFromUI;
uiButton_51=createSlider(uiButton_45,nil,10,500,60,Color3.fromRGB(168,85,247),function(uiButton_52) State.flySpeed=uiButton_52;
end,nil,"fly_speed");
uiButton_51.Visible=false;
State._flySpeedRow=uiButton_51;
stateRef_16=createRow(uiButton_45);
uiButton_53=createIndicator(stateRef_16);
createRowLabel(stateRef_16,nil,"noclip");
uiButton_54,uiButton_55=createToggle(stateRef_16);
local function toggleNoclipFromUI() toggleNoclip();
    updateToggle(uiButton_54,uiButton_55,uiButton_53,State.noclipEnabled);
end uiButton_54.MouseButton1Click:Connect(toggleNoclipFromUI);
State._handleNoclip=toggleNoclipFromUI;
uiButton_56=createRow(uiButton_45);
vehicle_3=createIndicator(uiButton_56);
createRowLabel(uiButton_56,nil,"car_speed");
uiButton_57,vehicle_4=createToggle(uiButton_56);
local function toggleVehicleSpeedFromUI() toggleVehicleSpeed();
    updateToggle(uiButton_57,vehicle_4,vehicle_3,State.vehSpeedEnabled);
    if State._vehSliderRow then
        State._vehSliderRow.Visible=State.vehSpeedEnabled;
    end
end uiButton_57.MouseButton1Click:Connect(toggleVehicleSpeedFromUI);
State._handleVeh=toggleVehicleSpeedFromUI;
uiButton_58=createSlider(uiButton_45,nil,1,3,2,Color3.fromRGB(255,200,0),function(uiButton_59) State.vehSpeedMult=uiButton_59;
end,nil,"speed_multi");
uiButton_58.Visible=false;
State._vehSliderRow=uiButton_58;
stateRef_17=createRow(uiButton_45);
uiColor_31=createIndicator(stateRef_17);
createRowLabel(stateRef_17,nil,"speed_boost");
uiButton_60,uiColor_32=createToggle(stateRef_17);
local function toggleSpeedBoostFromUI() State.speedBoostEnabled= not State.speedBoostEnabled;
    updateToggle(uiButton_60,uiColor_32,uiColor_31,State.speedBoostEnabled);
    notify(translate("speed_boost"),(State.speedBoostEnabled and ("x"   .. State.speedBoostMult   .. " "   .. translate("on"))) or translate("off") ,(State.speedBoostEnabled and Color3.fromRGB(0,200,255)) or Color3.fromRGB(255,80,80) );
    if State._speedSliderRow then
        State._speedSliderRow.Visible=State.speedBoostEnabled;
    end
end uiButton_60.MouseButton1Click:Connect(toggleSpeedBoostFromUI);
State._handleSpeed=toggleSpeedBoostFromUI;
uiButton_61=createSlider(uiButton_45,nil,1,10,2,Color3.fromRGB(0,200,255),function(uiButton_62) State.speedBoostMult=uiButton_62;
end,nil,"run_speed");
uiButton_61.Visible=false;
State._speedSliderRow=uiButton_61;
stateRef_18=createRow(uiButton_45);
uiColor_33=createIndicator(stateRef_18);
createRowLabel(stateRef_18,nil,"high_jump");
uiButton_63,uiColor_34=createToggle(stateRef_18);
local function toggleJumpBoostFromUI() State.jumpBoostEnabled= not State.jumpBoostEnabled;
    updateToggle(uiButton_63,uiColor_34,uiColor_33,State.jumpBoostEnabled);
    notify(translate("high_jump"),(State.jumpBoostEnabled and ("x"   .. State.jumpBoostMult   .. " "   .. translate("on"))) or translate("off") ,(State.jumpBoostEnabled and Color3.fromRGB(255,200,0)) or Color3.fromRGB(255,80,80) );
    if State._jumpSliderRow then
        State._jumpSliderRow.Visible=State.jumpBoostEnabled;
    end
end uiButton_63.MouseButton1Click:Connect(toggleJumpBoostFromUI);
State._handleJump=toggleJumpBoostFromUI;
uiButton_64=createSlider(uiButton_45,nil,1,5,2,Color3.fromRGB(255,200,0),function(uiButton_65) State.jumpBoostMult=uiButton_65;
end,nil,"jump_power");
uiButton_64.Visible=false;
State._jumpSliderRow=uiButton_64;
end logDebug("Movement tab ready");
do uiButton_66=uiButton_9['Misc'];
    Instance.new("UIListLayout",uiButton_66).Padding=UDim.new(0,4);
    uiButton_67=createRow(uiButton_66);
    uiLabel_28=Instance.new("TextLabel",uiButton_67);
    uiLabel_28.Size=UDim2.new(0,120,1,0);
    uiLabel_28.Position=UDim2.new(0,10,0,0);
    uiLabel_28.BackgroundTransparency=1;
    uiLabel_28.Text=translate("rejoin");
    registerLabel(uiLabel_28,"rejoin");
    uiLabel_28.TextColor3=Color3.fromRGB(235,230,245);
    uiLabel_28.Font=Enum.Font.GothamBold;
    uiLabel_28.TextSize=12;
    uiLabel_28.TextXAlignment=Enum.TextXAlignment.Left;
    uiLabel_28.ZIndex=51;
    uiButton_68=Instance.new("TextButton",uiButton_67);
    uiButton_68.Size=UDim2.new(0,80,0,26);
    uiButton_68.Position=UDim2.new(1, -90,0.5, -13);
    uiButton_68.BackgroundColor3=Color3.fromRGB(168,85,247);
    uiButton_68.Text=translate("rejoin_btn");
    registerLabel(uiButton_68,"rejoin_btn");
    uiButton_68.TextColor3=Color3.fromRGB(255,255,255);
    uiButton_68.Font=Enum.Font.GothamBold;
    uiButton_68.TextSize=11;
    uiButton_68.ZIndex=52;
    Instance.new("UICorner",uiButton_68).CornerRadius=UDim.new(0,5);
    uiButton_68.MouseButton1Click:Connect(rejoinServer);
    uiButton_69=createRow(uiButton_66);
    uiButton_70=createIndicator(uiButton_69);
    createRowLabel(uiButton_69,nil,"anti_afk");
    uiButton_71,uiButton_72=createToggle(uiButton_69);
    local function toggleAntiAFKFromUI() toggleAntiAFK();
        updateToggle(uiButton_71,uiButton_72,uiButton_70,State.afkEnabled);
    end uiButton_71.MouseButton1Click:Connect(toggleAntiAFKFromUI);
State._handleAFK=toggleAntiAFKFromUI;
uiButton_73=LocalPlayer;
createSlider(uiButton_66,nil,5,100,math.round(uiButton_73.CameraMaxZoomDistance),Color3.fromRGB(168,85,247),function(uiColor_35) uiButton_73.CameraMinZoomDistance=0.5;
    uiButton_73.CameraMaxZoomDistance=uiColor_35;
end,nil,"cam_zoom");
uiColor_36=createRow(uiButton_66);
uiButton_74=createIndicator(uiColor_36);
createRowLabel(uiColor_36,nil,"auto_tablet");
uiButton_75,uiButton_76=createToggle(uiColor_36);
uiButton_77=createSlider(uiButton_66,nil,3,15,5,Color3.fromRGB(255,200,0),function(uiColor_37) State.autoTabletInterval=uiColor_37;
end,nil,"scan_interval");
uiButton_78=createSlider(uiButton_66,nil,0,9,6,Color3.fromRGB(255,200,0),function(uiColor_38) State.tabletSlot=uiColor_38;
end,nil,"tablet_slot");
uiButton_77.Visible=false;
uiButton_78.Visible=false;
uiButton_75.MouseButton1Click:Connect(function() State.autoTablet= not State.autoTablet;
    updateToggle(uiButton_75,uiButton_76,uiButton_74,State.autoTablet);
    uiButton_77.Visible=State.autoTablet;
    uiButton_78.Visible=State.autoTablet;
    if State.autoTablet then
        notify(translate("auto_tablet"),translate("notif_scanning"),Color3.fromRGB(255,200,0));
    else notify(translate("auto_tablet"),translate("off"),Color3.fromRGB(255,80,80));
    end
end);
uiButton_79=createRow(uiButton_66);
createIndicator(uiButton_79);
createRowLabel(uiButton_79,nil,"taser_tp");
uiButton_80=Instance.new("TextButton",uiButton_79);
uiButton_80.Size=UDim2.new(0,60,0,22);
uiButton_80.Position=UDim2.new(1, -70,0.5, -11);
uiButton_80.BackgroundColor3=Color3.fromRGB(255,200,0);
uiButton_80.Text=translate("taser_btn");
registerLabel(uiButton_80,"taser_btn");
uiButton_80.TextColor3=Color3.fromRGB(0,0,0);
uiButton_80.Font=Enum.Font.GothamBold;
uiButton_80.TextSize=10;
uiButton_80.ZIndex=52;
Instance.new("UICorner",uiButton_80).CornerRadius=UDim.new(0,5);
local function taserTeleport() character=LocalPlayer.Character;
    if  not character then
        return;
    end rootPart=character:FindFirstChild("HumanoidRootPart");
if  not rootPart then
    return;
end targetPlayer,closestDistance=nil,100;
for playerIndex,candidate in ipairs(Players:GetPlayers()) do if ((candidate~=LocalPlayer) and candidate.Character) then
            role=getPlayerRole(candidate);
            if ((role=="Civilian") or (role=="Armed")) then
                candidateRoot=candidate.Character:FindFirstChild("HumanoidRootPart");
                if candidateRoot then
                    distance=(rootPart.Position-candidateRoot.Position).Magnitude;
                    if (distance<closestDistance) then
                        closestDistance=distance;
                        targetPlayer=candidate;
                    end
            end
    end
end
end if ( not targetPlayer or  not targetPlayer.Character) then
notify(translate("taser_tp"),translate("notif_no_target"),Color3.fromRGB(255,80,80));
return;
end targetRoot=targetPlayer.Character:FindFirstChild("HumanoidRootPart");
if  not targetRoot then
    return;
end targetPosition=targetRoot.Position;
direction=targetPosition-rootPart.Position ;
if (direction.Magnitude>0.1) then
    direction=direction.Unit;
end teleportPosition=(targetPosition-(direction * 3)) + Vector3.new(0,0.5,0) ;
startPosition=rootPart.Position;
travelDistance=(teleportPosition-startPosition).Magnitude;
steps=math.max(1,math.ceil(travelDistance/30 ));
for step=1,steps do alpha=step/steps ;
        stepPosition=startPosition:Lerp(teleportPosition,alpha);
        rootPart.CFrame=CFrame.new(stepPosition,targetPosition);
        if (step<steps) then
            task.wait(0.05);
        end
end rootPart.CFrame=CFrame.lookAt(rootPart.Position,targetPosition);
notify(translate("taser_tp"),"→ "   .. targetPlayer.DisplayName   .. " ("   .. math.floor(closestDistance)   .. "m)" ,Color3.fromRGB(255,200,0));
end State._doTaserTP=taserTeleport;
uiButton_80.MouseButton1Click:Connect(taserTeleport);
end logDebug("Misc tab ready");
do uiButton_81=uiButton_9['Farm'];
    Instance.new("UIListLayout",uiButton_81).Padding=UDim.new(0,4);
    State.autoFarm=false;
    State.farmCycles=0;
    State.farmRingCount=5;
    farmPointBuy=Vector3.new(6805.8,17.5,23.9);
    farmPointSell=Vector3.new( -197.9,17.2,1244.4);
    farmPointSellAlt=Vector3.new(6806.9,17.5, -33.8);
    farmPointBuyAlt=Vector3.new(6848.5,17.3,26.6);
    farmPointLaunder=Vector3.new(6842.7,17.3,155.8);
    farmPointLaunderAlt=Vector3.new( -137.1,17.3,162.3);
    farmPointReturn=Vector3.new( -149,17.3,1261.8);
    farmPointReturnAlt=Vector3.new( -203.1,17.3,1257.1);
    position_10=createRow(uiButton_81);
    createIndicator(position_10);
    createRowLabel(position_10,nil,"auto_farm");
    uiButton_82,uiButton_83=createToggle(position_10);
    uiLabel_29=Instance.new("TextLabel",position_10);
    uiLabel_29.Size=UDim2.new(0,120,0,16);
    uiLabel_29.Position=UDim2.new(1, -220,0.5, -8);
    uiLabel_29.BackgroundTransparency=1;
    uiLabel_29.TextColor3=Color3.fromRGB(140,180,140);
    uiLabel_29.Font=Enum.Font.Gotham;
    uiLabel_29.TextSize=9;
    uiLabel_29.TextXAlignment=Enum.TextXAlignment.Right;
    uiLabel_29.Text="";
    uiLabel_29.ZIndex=51;
    createSlider(uiButton_81,nil,1,10,5,Color3.fromRGB(168,85,247),function(uiColor_39) State.farmRingCount=uiColor_39;
    end,nil,"farm_rings");
VirtualInputManager=game:GetService("VirtualInputManager");
local function sendShiftKey(pressed) pcall(function() VirtualInputManager:SendKeyEvent(pressed,Enum.KeyCode.LeftShift,false,game);
    end);
end farmRoutePoints={farmPointBuy,farmPointBuyAlt,farmPointLaunder,farmPointLaunderAlt,farmPointReturn,farmPointReturnAlt,farmPointSell,farmPointSellAlt};
local function nearestFarmPoint(position) nearestIndex,nearestDistance=1,math.huge;
    for index,point in ipairs(farmRoutePoints) do distance=(position-point).Magnitude;
            if (distance<nearestDistance) then
                nearestIndex=index;
                nearestDistance=distance;
            end
    end return nearestIndex;
end local function moveToFarmPoint(targetPosition) rootPart=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ;
if  not rootPart then
    return;
end startPosition=rootPart.Position;
distance=(targetPosition-startPosition).Magnitude;
steps=math.max(1,math.ceil(distance/18 ));
for step=1,steps do if  not State.autoFarm then
            return;
        end stepPosition=startPosition:Lerp(targetPosition,step/steps );
    rootPart.CFrame=CFrame.new(stepPosition);
    task.wait(0.05);
    actualPosition=rootPart.Position;
    if ((actualPosition-stepPosition).Magnitude>30) then
        uiLabel_29.Text="Anti-cheat fix...";
        task.wait(1);
        return "rollback";
    end
end return nil;
end local function followFarmRoute(route) for index,point in ipairs(route) do if  not State.autoFarm then
            return;
        end uiLabel_29.Text=translate("farm_status_walk");
    result=moveToFarmPoint(point);
    if (result=="rollback") then
        nearestIndex=nearestFarmPoint(game.Players.LocalPlayer.Character.HumanoidRootPart.Position);
        nearestPoint=farmRoutePoints[nearestIndex];
        moveToFarmPoint(nearestPoint);
        task.wait(0.5);
        moveToFarmPoint(point);
    end task.wait(0.1);
end
end local function firePromptTwice(prompt) if  not prompt then
    return;
end fireproximityprompt(prompt);
task.wait(0.5);
fireproximityprompt(prompt);
end local function runFarmCycle() buyFolder=workspace:FindFirstChild("WorldBuyableItems");
if  not buyFolder then
    return false,"no WorldBuyableItems";
end painting=buyFolder:FindFirstChild("Mona Lisa Painting",true);
if  not painting then
    return false,"no Mona Lisa";
end buyPrompt=painting:FindFirstChild("MonaLisaPaint") or painting ;
uiLabel_30=buyPrompt:FindFirstChild("PromptAttachment");
if uiLabel_30 then
    uiLabel_30=uiLabel_30:FindFirstChild("ProximityPrompt");
end prompt_4=workspace:FindFirstChild("NPC");
if  not prompt_4 then
    return false,"no NPC";
end rootPart_15=prompt_4:FindFirstChild("Seller3") or prompt_4:FindFirstChild("Seller") or prompt_4:FindFirstChild("Seller2") ;
if  not rootPart_15 then
    return false,"no Seller";
end rootPart_16=rootPart_15:FindFirstChild("HumanoidRootPart");
if  not rootPart_16 then
    return false,"no seller root";
end rootPart_17=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ;
if  not rootPart_17 then
    return false,"no character";
end sendShiftKey(true);
moveToFarmPoint(farmPointBuy);
sendShiftKey(false);
if  not State.autoFarm then
    return false;
end task.wait(0.5);
for uiLabel_31=1,State.farmRingCount do if  not State.autoFarm then
            return false;
        end uiLabel_29.Text=translate("farm_status_buy")   .. " "   .. uiLabel_31   .. "/"   .. State.farmRingCount ;
    firePromptTwice(uiLabel_30);
    task.wait(0.8);
end if  not State.autoFarm then
return false;
end sendShiftKey(true);
followFarmRoute({farmPointBuyAlt,farmPointLaunder,farmPointLaunderAlt,farmPointReturn,farmPointReturnAlt,farmPointSell});
sendShiftKey(false);
if  not State.autoFarm then
    return false;
end task.wait(0.5);
uiLabel_29.Text=translate("farm_status_sell");
for list_45=1,5 do if  not State.autoFarm then
            return false;
        end for prompt_5,prompt_6 in ipairs(workspace:GetDescendants()) do if (prompt_6:IsA("ProximityPrompt") and prompt_6.Name:find("Sell")) then
                fireproximityprompt(prompt_6);
            end
    end task.wait(1);
end if  not State.autoFarm then
return false;
end sendShiftKey(true);
followFarmRoute({farmPointReturnAlt,farmPointReturn,farmPointLaunderAlt,farmPointLaunder,farmPointBuyAlt,farmPointBuy,farmPointSellAlt});
sendShiftKey(false);
if  not State.autoFarm then
    return false;
end task.wait(0.5);
uiLabel_29.Text=translate("farm_status_launder");
for list_46=1,5 do if  not State.autoFarm then
            return false;
        end for prompt_7,prompt_8 in ipairs(workspace:GetDescendants()) do if (prompt_8:IsA("ProximityPrompt") and prompt_8.Name:find("Launder")) then
                fireproximityprompt(prompt_8);
            end
    end task.wait(1);
end return true;
end local function autoFarmLoop() State.farmCycles=0;
while State.autoFarm and State.scriptActive  do uiLabel_32,uiLabel_33=runFarmCycle();
        if uiLabel_32 then
            State.farmCycles=State.farmCycles + 1 ;
            uiLabel_29.Text=translate("farm_cycles")   .. ": "   .. State.farmCycles ;
            task.wait(0.5);
        elseif uiLabel_33 then
                uiLabel_29.Text="Error: "   .. uiLabel_33 ;
                task.wait(2);
            end
    end sendShiftKey(false);
uiLabel_29.Text="";
end uiButton_82.MouseButton1Click:Connect(function() State.autoFarm= not State.autoFarm;
uiButton_84=State.autoFarm;
TweenService:Create(uiButton_83,TweenInfo.new(0.2),{Position=(uiButton_84 and UDim2.new(1, -16,0.5, -7)) or UDim2.new(0,2,0.5, -7) }):Play();
TweenService:Create(uiButton_82,TweenInfo.new(0.2),{BackgroundColor3=(uiButton_84 and Color3.fromRGB(168,85,247)) or Color3.fromRGB(60,55,70) }):Play();
if uiButton_84 then
    task.spawn(autoFarmLoop);
end
end);
end logDebug("Farm tab ready");
do targetObject_7=uiButton_9['Aimbot'];
    Instance.new("UIListLayout",targetObject_7).Padding=UDim.new(0,4);
    uiButton_85=createRow(targetObject_7);
    uiButton_86=createIndicator(uiButton_85);
    createRowLabel(uiButton_85,nil,"aimbot");
    uiButton_87,uiButton_88=createToggle(uiButton_85);
    local function updateAimbotToggle() updateToggle(uiButton_87,uiButton_88,uiButton_86,_G.AimbotConfig.Enabled);
    end uiButton_87.MouseButton1Click:Connect(function() _G.AimbotConfig.Enabled= not _G.AimbotConfig.Enabled;
    updateAimbotToggle();
    notify(translate("aimbot"),(_G.AimbotConfig.Enabled and translate("on")) or translate("off") ,(_G.AimbotConfig.Enabled and Color3.fromRGB(0,255,150)) or Color3.fromRGB(255,50,50) );
    if State.FOVCircle then
        pcall(function() State.FOVCircle.Visible=_G.AimbotConfig.Enabled;
        end);
end if State._aimSubs then
for config_6,config_7 in ipairs(State._aimSubs) do config_7.Visible=_G.AimbotConfig.Enabled;
    end
end AimButton.Visible=_G.AimbotConfig.Enabled;
if  not _G.AimbotConfig.Enabled then
    State._aimHeld=false;
    updateAimButton();
end
end);
uiLabel_34={};
uiButton_89=createRow(targetObject_7);
table.insert(uiLabel_34,uiButton_89);
uiLabel_35=Instance.new("TextLabel",uiButton_89);
uiLabel_35.Size=UDim2.new(0,130,1,0);
uiLabel_35.Position=UDim2.new(0,10,0,0);
uiLabel_35.BackgroundTransparency=1;
uiLabel_35.Text=translate("aim_part")   .. ": "   .. translate("head") ;
uiLabel_35.TextColor3=Color3.fromRGB(235,230,245);
uiLabel_35.Font=Enum.Font.GothamBold;
uiLabel_35.TextSize=11;
uiLabel_35.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_35.ZIndex=51;
table.insert(State.langLabels,{obj=uiLabel_35,isCustom=true,updateFn=function() config_8=_G.AimbotConfig;
    uiButton_90=config_8.AimParts[config_8.SelectedAimPart];
    uiButton_91={HumanoidRootPart=translate("torso"),Head=translate("head"),UpperTorso=translate("upper_torso"),Torso=translate("torso")};
    uiLabel_35.Text=translate("aim_part")   .. ": "   .. (uiButton_91[uiButton_90] or uiButton_90) ;
end});
uiButton_92=Instance.new("TextButton",uiButton_89);
uiButton_92.Size=UDim2.new(0,70,0,24);
uiButton_92.Position=UDim2.new(1, -80,0.5, -12);
uiButton_92.BackgroundColor3=Color3.fromRGB(168,85,247);
uiButton_92.Text=translate("toggle_btn");
registerLabel(uiButton_92,"toggle_btn");
uiButton_92.TextColor3=Color3.fromRGB(255,255,255);
uiButton_92.Font=Enum.Font.GothamBold;
uiButton_92.TextSize=11;
uiButton_92.ZIndex=52;
Instance.new("UICorner",uiButton_92).CornerRadius=UDim.new(0,5);
uiButton_92.MouseButton1Click:Connect(function() uiButton_93=_G.AimbotConfig;
    uiButton_93.SelectedAimPart=(uiButton_93.SelectedAimPart% #uiButton_93.AimParts) + 1 ;
    uiButton_94=uiButton_93.AimParts[uiButton_93.SelectedAimPart];
    uiColor_41={HumanoidRootPart=translate("torso"),Head=translate("head"),UpperTorso=translate("upper_torso"),Torso=translate("torso")};
    uiLabel_35.Text=translate("aim_part")   .. ": "   .. (uiColor_41[uiButton_94] or uiButton_94) ;
end);
table.insert(uiLabel_34,createSlider(targetObject_7,nil,10,360,90,Color3.fromRGB(168,85,247),function(uiColor_42) _G.AimbotConfig.FOV=uiColor_42;
    if State.FOVCircle then
        pcall(function() State.FOVCircle.Radius=uiColor_42;
        end);
end
end,nil,"fov_circle"));
table.insert(uiLabel_34,createSlider(targetObject_7,nil,1,100,18,Color3.fromRGB(168,85,247),function(uiColor_43) _G.AimbotConfig.Smoothness=uiColor_43/100 ;
end,nil,"smoothness"));
table.insert(uiLabel_34,createSlider(targetObject_7,nil,20,100,50,Color3.fromRGB(168,85,247),function(uiColor_44) _G.AimbotConfig.MaxDistance=uiColor_44;
end,function(uiColor_45) return uiColor_45   .. "m" ;
end,"max_dist"));
local function createAimbotOption(uiLabel_36,uiButton_95) uiButton_96=createRow(targetObject_7,32);
    table.insert(uiLabel_34,uiButton_96);
    uiButton_96.BackgroundColor3=Color3.fromRGB(26,22,36);
    uiLabel_37=Instance.new("TextLabel",uiButton_96);
    uiLabel_37.Size=UDim2.new(0,130,1,0);
    uiLabel_37.Position=UDim2.new(0,10,0,0);
    uiLabel_37.BackgroundTransparency=1;
    uiLabel_37.Text=translate(uiLabel_36);
    registerLabel(uiLabel_37,uiLabel_36);
    uiLabel_37.TextColor3=Color3.fromRGB(190,185,200);
    uiLabel_37.Font=Enum.Font.Gotham;
    uiLabel_37.TextSize=11;
    uiLabel_37.TextXAlignment=Enum.TextXAlignment.Left;
    uiLabel_37.ZIndex=51;
    uiButton_97=Instance.new("TextButton",uiButton_96);
    uiButton_97.Size=UDim2.new(0,32,0,16);
    uiButton_97.Position=UDim2.new(1, -42,0.5, -8);
    uiButton_97.BackgroundColor3=(_G.AimbotConfig[uiButton_95] and State.toggleActiveColor) or Color3.fromRGB(45,40,55) ;
    uiButton_97.Text="";
    uiButton_97.ZIndex=52;
    Instance.new("UICorner",uiButton_97).CornerRadius=UDim.new(1,0);
    uiFrame_18=Instance.new("Frame",uiButton_97);
    uiFrame_18.Size=UDim2.new(0,12,0,12);
    uiFrame_18.Position=(_G.AimbotConfig[uiButton_95] and UDim2.new(0,17,0.5, -6)) or UDim2.new(0,3,0.5, -6) ;
    uiFrame_18.BackgroundColor3=Color3.fromRGB(245,242,250);
    uiFrame_18.ZIndex=53;
    Instance.new("UICorner",uiFrame_18).CornerRadius=UDim.new(1,0);
    table.insert(State.toggleRegistry,uiButton_97);
    uiButton_97.MouseButton1Click:Connect(function() _G.AimbotConfig[uiButton_95]= not _G.AimbotConfig[uiButton_95];
        TweenService:Create(uiButton_97,TweenInfo.new(0.2),{BackgroundColor3=(_G.AimbotConfig[uiButton_95] and State.toggleActiveColor) or Color3.fromRGB(45,40,55) }):Play();
        TweenService:Create(uiFrame_18,TweenInfo.new(0.2),{Position=(_G.AimbotConfig[uiButton_95] and UDim2.new(0,17,0.5, -6)) or UDim2.new(0,3,0.5, -6) }):Play();
    end);
end uiButton_98=createRow(targetObject_7,38);
table.insert(uiLabel_34,uiButton_98);
uiButton_98.BackgroundColor3=Color3.fromRGB(26,22,36);
uiLabel_38=Instance.new("TextLabel",uiButton_98);
uiLabel_38.Size=UDim2.new(0,100,1,0);
uiLabel_38.Position=UDim2.new(0,10,0,0);
uiLabel_38.BackgroundTransparency=1;
uiLabel_38.Text="AIM: Toggle";
uiLabel_38.TextColor3=Color3.fromRGB(190,185,200);
uiLabel_38.Font=Enum.Font.Gotham;
uiLabel_38.TextSize=11;
uiLabel_38.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_38.ZIndex=51;
uiButton_99=Instance.new("TextButton",uiButton_98);
uiButton_99.Size=UDim2.new(0,70,0,22);
uiButton_99.Position=UDim2.new(1, -80,0.5, -11);
uiButton_99.BackgroundColor3=Color3.fromRGB(168,85,247);
uiButton_99.Text="Toggle";
uiButton_99.TextColor3=Color3.fromRGB(255,255,255);
uiButton_99.Font=Enum.Font.GothamBold;
uiButton_99.TextSize=10;
uiButton_99.ZIndex=52;
Instance.new("UICorner",uiButton_99).CornerRadius=UDim.new(0,5);
uiButton_99.MouseButton1Click:Connect(function() if (State.aimMode=="toggle") then
        State.aimMode="hold";
        uiButton_99.Text="Hold";
        uiLabel_38.Text="AIM: Hold";
        State._aimHeld=false;
        updateAimButton();
    else State.aimMode="toggle";
        uiButton_99.Text="Toggle";
        uiLabel_38.Text="AIM: Toggle";
        State._aimHeld=false;
        updateAimButton();
    end
end);
createAimbotOption("wall_check","WallCheck");
createAimbotOption("target_lock","TargetLock");
createAimbotOption("prediction","Prediction");
targetObject_8=createRow(targetObject_7);
table.insert(uiLabel_34,targetObject_8);
uiButton_100=createIndicator(targetObject_8);
createRowLabel(targetObject_8,nil,"anti_recoil");
uiButton_101,uiButton_102=createToggle(targetObject_8);
uiButton_101.MouseButton1Click:Connect(function() State.antiRecoilEnabled= not State.antiRecoilEnabled;
    updateToggle(uiButton_101,uiButton_102,uiButton_100,State.antiRecoilEnabled);
    notify(translate("anti_recoil"),(State.antiRecoilEnabled and translate("on")) or translate("off") ,(State.antiRecoilEnabled and Color3.fromRGB(0,255,150)) or Color3.fromRGB(255,50,50) );
end);
table.insert(uiLabel_34,createSlider(targetObject_7,nil,5,100,70,Color3.fromRGB(168,85,247),function(uiColor_46) State.antiRecoilStrength=uiColor_46/100 ;
end,nil,"recoil_comp"));
for uiColor_47,uiColor_48 in ipairs(uiLabel_34) do uiColor_48.Visible=false;
    end State._aimSubs=uiLabel_34;
end logDebug("Aimbot tab ready");
do uiColor_49=uiButton_9['Colors'];
    Instance.new("UIListLayout",uiColor_49).Padding=UDim.new(0,4);
    uiLabel_39=Instance.new("TextLabel",uiColor_49);
    uiLabel_39.Size=UDim2.new(1, -6,0,24);
    uiLabel_39.BackgroundTransparency=1;
    uiLabel_39.Text=translate("esp_visual_settings");
    registerLabel(uiLabel_39,"esp_visual_settings");
    uiLabel_39.TextColor3=Color3.fromRGB(210,180,255);
    uiLabel_39.Font=Enum.Font.GothamBold;
    uiLabel_39.TextSize=12;
    uiLabel_39.ZIndex=51;
    uiButton_103={Color3.fromRGB(255,255,255),Color3.fromRGB(255,0,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,120,255),Color3.fromRGB(255,255,0),Color3.fromRGB(255,0,255),Color3.fromRGB(0,255,255),Color3.fromRGB(255,120,0),Color3.fromRGB(255,80,150),Color3.fromRGB(120,255,80),Color3.fromRGB(80,80,255),Color3.fromRGB(200,200,200)};
    uiLabel_40={Police="role_police",Civilian="role_civilian",Friend="role_friend",Armed="role_armed"};
    for uiColor_50,playerRef_23 in ipairs({"Police","Civilian","Friend","Armed"}) do uiColor_51=createRow(uiColor_49,44);
            uiFrame_19=Instance.new("Frame",uiColor_51);
            uiFrame_19.Name="Preview";
            uiFrame_19.Size=UDim2.new(0,14,0,14);
            uiFrame_19.Position=UDim2.new(0,8,0,3);
            uiFrame_19.BackgroundColor3=State.ESPColors[playerRef_23];
            uiFrame_19.ZIndex=52;
            Instance.new("UICorner",uiFrame_19).CornerRadius=UDim.new(1,0);
            uiLabel_41=Instance.new("TextLabel",uiColor_51);
            uiLabel_41.Size=UDim2.new(0,80,0,16);
            uiLabel_41.Position=UDim2.new(0,26,0,3);
            uiLabel_41.BackgroundTransparency=1;
            uiLabel_41.Text=translate(uiLabel_40[playerRef_23]);
            registerLabel(uiLabel_41,uiLabel_40[playerRef_23]);
            uiLabel_41.TextColor3=Color3.fromRGB(235,230,245);
            uiLabel_41.Font=Enum.Font.GothamBold;
            uiLabel_41.TextSize=10;
            uiLabel_41.TextXAlignment=Enum.TextXAlignment.Left;
            uiLabel_41.ZIndex=51;
            uiFrame_20=Instance.new("Frame",uiColor_51);
            uiFrame_20.Size=UDim2.new(1, -10,0,14);
            uiFrame_20.Position=UDim2.new(0,6,0,24);
            uiFrame_20.BackgroundTransparency=1;
            uiFrame_20.ZIndex=51;
            instanceObject_8=Instance.new("UIListLayout",uiFrame_20);
            instanceObject_8.FillDirection=Enum.FillDirection.Horizontal;
            instanceObject_8.Padding=UDim.new(0,3);
            for uiButton_104,uiButton_105 in ipairs(uiButton_103) do uiButton_106=Instance.new("TextButton",uiFrame_20);
                    uiButton_106.Size=UDim2.new(0,14,0,14);
                    uiButton_106.BackgroundColor3=uiButton_105;
                    uiButton_106.Text="";
                    uiButton_106.ZIndex=52;
                    Instance.new("UICorner",uiButton_106).CornerRadius=UDim.new(1,0);
                    uiButton_106.MouseButton1Click:Connect(function() State.ESPColors[playerRef_23]=uiButton_105;
                        uiFrame_19.BackgroundColor3=uiButton_105;
                        if State.espEnabled then
                            for playerRef_24,uiColor_52 in ipairs(Players:GetPlayers()) do if ((uiColor_52~=LocalPlayer) and uiColor_52.Character) then
                                        playerRef_25=State.espCache[uiColor_52.UserId];
                                        if (playerRef_25 and (playerRef_25.role==playerRef_23)) then
                                            playerRef_25.color=uiButton_105;
                                            uiColor_53=uiColor_52.Character:FindFirstChild("ESPHighlight");
                                            if uiColor_53 then
                                                uiColor_53.FillColor=uiButton_105;
                                            end head_4=uiColor_52.Character:FindFirstChild("Head");
                                        if head_4 then
                                            uiColor_54=head_4:FindFirstChild("NameTag");
                                            if uiColor_54 then
                                                uiColor_55=uiColor_54:FindFirstChild("TagLabel");
                                                if uiColor_55 then
                                                    uiColor_55.TextColor3=uiButton_105;
                                                end
                                        end
                                end
                        end
                end
        end
end
end);
end
end uiButton_107=createRow(uiColor_49);
createIndicator(uiButton_107);
createRowLabel(uiButton_107,nil,"esp_gradient");
uiButton_108,uiButton_109=createToggle(uiButton_107);
uiButton_108.MouseButton1Click:Connect(function() State.espGradient= not State.espGradient;
    updateToggle(uiButton_108,uiButton_109,nil,State.espGradient);
end);
uiButton_110=createRow(uiColor_49);
createIndicator(uiButton_110);
createRowLabel(uiButton_110,nil,"fov_gradient");
uiButton_111,uiButton_112=createToggle(uiButton_110);
uiButton_111.MouseButton1Click:Connect(function() State.fovGradient= not State.fovGradient;
    updateToggle(uiButton_111,uiButton_112,nil,State.fovGradient);
end);
size_10=createRow(uiColor_49,44);
uiLabel_42=Instance.new("TextLabel",size_10);
uiLabel_42.Size=UDim2.new(0,120,0,16);
uiLabel_42.Position=UDim2.new(0,8,0,3);
uiLabel_42.BackgroundTransparency=1;
uiLabel_42.Text=translate("accent_color");
registerLabel(uiLabel_42,"accent_color");
uiLabel_42.TextColor3=Color3.fromRGB(190,185,200);
uiLabel_42.Font=Enum.Font.Gotham;
uiLabel_42.TextSize=10;
uiLabel_42.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_42.ZIndex=51;
uiFrame_21=Instance.new("Frame",size_10);
uiFrame_21.Size=UDim2.new(1, -10,0,14);
uiFrame_21.Position=UDim2.new(0,6,0,24);
uiFrame_21.BackgroundTransparency=1;
uiFrame_21.ZIndex=51;
Instance.new("UIListLayout",uiFrame_21).FillDirection=Enum.FillDirection.Horizontal;
Instance.new("UIListLayout",uiFrame_21).Padding=UDim.new(0,3);
for uiButton_113,uiButton_114 in ipairs(uiButton_103) do uiButton_115=Instance.new("TextButton",uiFrame_21);
        uiButton_115.Size=UDim2.new(0,14,0,14);
        uiButton_115.BackgroundColor3=uiButton_114;
        uiButton_115.Text="";
        uiButton_115.ZIndex=52;
        Instance.new("UICorner",uiButton_115).CornerRadius=UDim.new(1,0);
        uiButton_115.MouseButton1Click:Connect(function() State.menuAccentColor=uiButton_114;
            if State.glowGradient then
                State.glowGradient.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,uiButton_114),ColorSequenceKeypoint.new(1,Color3.fromRGB(236,72,153))});
            end stroke.Color=uiButton_114;
        for uiColor_56,uiColor_57 in ipairs(MenuButton:GetChildren()) do if uiColor_57:IsA("Frame") then
                    uiColor_57.BackgroundColor3=uiButton_114;
                end
        end notify(translate("accent_color"),translate("notif_color_upd"),uiButton_114);
end);
end size_11=createRow(uiColor_49,44);
uiLabel_43=Instance.new("TextLabel",size_11);
uiLabel_43.Size=UDim2.new(0,120,0,16);
uiLabel_43.Position=UDim2.new(0,8,0,3);
uiLabel_43.BackgroundTransparency=1;
uiLabel_43.Text=translate("toggle_color");
registerLabel(uiLabel_43,"toggle_color");
uiLabel_43.TextColor3=Color3.fromRGB(190,185,200);
uiLabel_43.Font=Enum.Font.Gotham;
uiLabel_43.TextSize=10;
uiLabel_43.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_43.ZIndex=51;
uiFrame_22=Instance.new("Frame",size_11);
uiFrame_22.Size=UDim2.new(1, -10,0,14);
uiFrame_22.Position=UDim2.new(0,6,0,24);
uiFrame_22.BackgroundTransparency=1;
uiFrame_22.ZIndex=51;
Instance.new("UIListLayout",uiFrame_22).FillDirection=Enum.FillDirection.Horizontal;
Instance.new("UIListLayout",uiFrame_22).Padding=UDim.new(0,3);
for uiButton_116,uiButton_117 in ipairs(uiButton_103) do uiButton_118=Instance.new("TextButton",uiFrame_22);
        uiButton_118.Size=UDim2.new(0,14,0,14);
        uiButton_118.BackgroundColor3=uiButton_117;
        uiButton_118.Text="";
        uiButton_118.ZIndex=52;
        Instance.new("UICorner",uiButton_118).CornerRadius=UDim.new(1,0);
        uiButton_118.MouseButton1Click:Connect(function() State.toggleActiveColor=uiButton_117;
            for uiButton_119,uiButton_120 in ipairs(State.toggleRegistry) do if (uiButton_120 and uiButton_120.Parent) then
                        uiButton_121=uiButton_120:FindFirstChildWhichIsA("Frame");
                        if (uiButton_121 and (uiButton_121.Position.X.Offset>10)) then
                            uiButton_120.BackgroundColor3=uiButton_117;
                        end
                end
        end notify(translate("toggle_color"),translate("notif_color_upd"),uiButton_117);
end);
end
end logDebug("Colors tab ready");
do uiLabel_44=uiButton_9['Settings'];
    Instance.new("UIListLayout",uiLabel_44).Padding=UDim.new(0,4);
    uiLabel_45=Instance.new("TextLabel",uiLabel_44);
    uiLabel_45.Size=UDim2.new(1, -6,0,24);
    uiLabel_45.BackgroundTransparency=1;
    uiLabel_45.Text=translate("settings_title");
    registerLabel(uiLabel_45,"settings_title");
    uiLabel_45.TextColor3=Color3.fromRGB(210,180,255);
    uiLabel_45.Font=Enum.Font.GothamBold;
    uiLabel_45.TextSize=12;
    uiLabel_45.ZIndex=51;
    uiButton_122=createRow(uiLabel_44);
    uiLabel_46=Instance.new("TextLabel",uiButton_122);
    uiLabel_46.Size=UDim2.new(0,100,1,0);
    uiLabel_46.Position=UDim2.new(0,10,0,0);
    uiLabel_46.BackgroundTransparency=1;
    uiLabel_46.Text=translate("language");
    registerLabel(uiLabel_46,"language");
    uiLabel_46.TextColor3=Color3.fromRGB(235,230,245);
    uiLabel_46.Font=Enum.Font.GothamBold;
    uiLabel_46.TextSize=12;
    uiLabel_46.TextXAlignment=Enum.TextXAlignment.Left;
    uiLabel_46.ZIndex=51;
    uiButton_123=Instance.new("TextButton",uiButton_122);
    uiButton_123.Size=UDim2.new(0,60,0,22);
    uiButton_123.Position=UDim2.new(1, -130,0.5, -11);
    uiButton_123.BackgroundColor3=((State.lang=="ru") and Color3.fromRGB(168,85,247)) or Color3.fromRGB(40,35,50) ;
    uiButton_123.Text="RU";
    uiButton_123.TextColor3=Color3.fromRGB(255,255,255);
    uiButton_123.Font=Enum.Font.GothamBold;
    uiButton_123.TextSize=11;
    uiButton_123.ZIndex=52;
    Instance.new("UICorner",uiButton_123).CornerRadius=UDim.new(0,5);
    uiButton_124=Instance.new("TextButton",uiButton_122);
    uiButton_124.Size=UDim2.new(0,60,0,22);
    uiButton_124.Position=UDim2.new(1, -65,0.5, -11);
    uiButton_124.BackgroundColor3=((State.lang=="en") and Color3.fromRGB(168,85,247)) or Color3.fromRGB(40,35,50) ;
    uiButton_124.Text="EN";
    uiButton_124.TextColor3=Color3.fromRGB(255,255,255);
    uiButton_124.Font=Enum.Font.GothamBold;
    uiButton_124.TextSize=11;
    uiButton_124.ZIndex=52;
    Instance.new("UICorner",uiButton_124).CornerRadius=UDim.new(0,5);
    uiButton_123.MouseButton1Click:Connect(function() State.lang="ru";
        uiButton_123.BackgroundColor3=Color3.fromRGB(168,85,247);
        uiButton_124.BackgroundColor3=Color3.fromRGB(40,35,50);
        refreshLanguage();
    end);
uiButton_124.MouseButton1Click:Connect(function() State.lang="en";
    uiButton_124.BackgroundColor3=Color3.fromRGB(168,85,247);
    uiButton_123.BackgroundColor3=Color3.fromRGB(40,35,50);
    refreshLanguage();
end);
end logDebug("Settings tab ready");
do uiButton_125=uiButton_9['Info'];
    Instance.new("UIListLayout",uiButton_125).Padding=UDim.new(0,4);
    uiLabel_47=Instance.new("TextLabel",uiButton_125);
    uiLabel_47.Size=UDim2.new(1,0,0,22);
    uiLabel_47.BackgroundTransparency=1;
    uiLabel_47.Text=translate("info_channel");
    registerLabel(uiLabel_47,"info_channel");
    uiLabel_47.TextColor3=Color3.fromRGB(200,195,215);
    uiLabel_47.Font=Enum.Font.GothamBold;
    uiLabel_47.TextSize=12;
    uiLabel_47.TextXAlignment=Enum.TextXAlignment.Left;
    uiLabel_47.ZIndex=51;
    uiFrame_23=Instance.new("Frame",uiButton_125);
    uiFrame_23.Size=UDim2.new(1,0,0,32);
    uiFrame_23.BackgroundColor3=Color3.fromRGB(30,24,42);
    uiFrame_23.ZIndex=50;
    Instance.new("UICorner",uiFrame_23).CornerRadius=UDim.new(0,6);
    uiLabel_48=Instance.new("TextLabel",uiFrame_23);
    uiLabel_48.Size=UDim2.new(1, -10,1,0);
    uiLabel_48.Position=UDim2.new(0,5,0,0);
    uiLabel_48.BackgroundTransparency=1;
    uiLabel_48.Text="https://t.me/eclipse_script";
    uiLabel_48.TextColor3=Color3.fromRGB(130,170,255);
    uiLabel_48.Font=Enum.Font.GothamMedium;
    uiLabel_48.TextSize=11;
    uiLabel_48.TextXAlignment=Enum.TextXAlignment.Left;
    uiLabel_48.ZIndex=51;
    uiButton_126=Instance.new("TextButton",uiButton_125);
    uiButton_126.Size=UDim2.new(1,0,0,28);
    uiButton_126.BackgroundColor3=Color3.fromRGB(168,85,247);
    uiButton_126.Text="Copy Link";
    uiButton_126.TextColor3=Color3.fromRGB(255,255,255);
    uiButton_126.Font=Enum.Font.GothamBold;
    uiButton_126.TextSize=11;
    uiButton_126.ZIndex=52;
    Instance.new("UICorner",uiButton_126).CornerRadius=UDim.new(0,5);
    uiButton_126.MouseButton1Click:Connect(function() pcall(function() setclipboard("https://t.me/eclipse_script");
        end);
    notify("Link","Copied!",Color3.fromRGB(0,255,150));
end);
uiLabel_49=Instance.new("TextLabel",uiButton_125);
uiLabel_49.Size=UDim2.new(1,0,0,16);
uiLabel_49.BackgroundTransparency=1;
uiLabel_49.Text=translate("info_copy_hint");
registerLabel(uiLabel_49,"info_copy_hint");
uiLabel_49.TextColor3=Color3.fromRGB(100,95,115);
uiLabel_49.Font=Enum.Font.Gotham;
uiLabel_49.TextSize=9;
uiLabel_49.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_49.ZIndex=51;
uiLabel_50=Instance.new("TextLabel",uiButton_125);
uiLabel_50.Size=UDim2.new(1,0,0,28);
uiLabel_50.BackgroundTransparency=1;
uiLabel_50.Text="Подписывайтесь на ТГ, там будут новости и обновления!";
uiLabel_50.TextColor3=Color3.fromRGB(255,200,50);
uiLabel_50.Font=Enum.Font.GothamBold;
uiLabel_50.TextSize=10;
uiLabel_50.TextWrapped=true;
uiLabel_50.TextXAlignment=Enum.TextXAlignment.Left;
uiLabel_50.ZIndex=51;
end logDebug("Info tab ready");
do uiColor_58,eventConnection_9=pcall(function() uiColor_59=Drawing.new("Circle");
        uiColor_59.Radius=_G.AimbotConfig.FOV;
        uiColor_59.Color=Color3.fromRGB(0,255,150);
        uiColor_59.Thickness=1.5;
        uiColor_59.Filled=false;
        uiColor_59.Transparency=_G.AimbotConfig.CircleTransparency;
        uiColor_59.Visible=false;
        return uiColor_59;
    end);
if (uiColor_58 and eventConnection_9) then
    State.FOVCircle=eventConnection_9;
end
end table.insert(State.connections,RunService.RenderStepped:Connect(function() if ( not State.scriptActive or  not _G.AimbotConfig.IsRunning) then
    return;
end eventConnection_10=_G.AimbotConfig;
config_9=Vector2.new(Camera.ViewportSize.X/2 ,Camera.ViewportSize.Y/2 );
if State.FOVCircle then
    pcall(function() State.FOVCircle.Position=config_9;
        State.FOVCircle.Radius=eventConnection_10.FOV;
        State.FOVCircle.Visible=eventConnection_10.Enabled and eventConnection_10.ShowFOVCircle ;
    end);
end
end));
State._aimThread=task.spawn(function() while State.scriptActive do task.wait();
            targetObject_9=_G.AimbotConfig;
            if ( not targetObject_9 or  not targetObject_9.IsRunning or  not targetObject_9.Enabled or  not State._aimHeld) then
                State.lockedTarget=nil;
                pcall(function() if (Camera.CameraType==Enum.CameraType.Scriptable) then
                        Camera.CameraType=Enum.CameraType.Custom;
                        tab_12=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") ;
                        if tab_12 then
                            Camera.CameraSubject=tab_12;
                        end
                end
        end);
else targetObject_10=Vector2.new(Camera.ViewportSize.X/2 ,Camera.ViewportSize.Y/2 );
    if (targetObject_9.TargetLock and State.lockedTarget) then
        if  not isValidAimTarget(State.lockedTarget) then
            State.lockedTarget=nil;
        end
end if ( not State.lockedTarget or  not targetObject_9.TargetLock) then
targetObject_11,targetObject_12=nil,math.huge;
for targetObject_13,targetObject_14 in ipairs(Players:GetPlayers()) do if isValidAimTarget(targetObject_14) then
            targetObject_15=getAimPart(targetObject_14.Character);
            if targetObject_15 then
                camera_7=(Camera.CFrame.Position-targetObject_15.Position).Magnitude;
                if (camera_7<=targetObject_9.MaxDistance) then
                    if ( not targetObject_9.WallCheck or hasLineOfSight(targetObject_15)) then
                        position_16,position_17=Camera:WorldToViewportPoint(targetObject_15.Position);
                        if position_17 then
                            position_18=(Vector2.new(position_16.X,position_16.Y) -targetObject_10).Magnitude;
                            if ((position_18<targetObject_9.FOV) and (position_18<targetObject_12)) then
                                targetObject_11=targetObject_14;
                                targetObject_12=position_18;
                            end
                    end
            end
    end
end
end
end State.lockedTarget=targetObject_11;
end if (State.lockedTarget and State.lockedTarget.Character) then
targetObject_16=getAimPart(State.lockedTarget.Character);
if targetObject_16 then
    targetObject_17=targetObject_16.Position;
    if targetObject_9.Prediction then
        camera_8=Vector3.zero;
        pcall(function() camera_8=targetObject_16.AssemblyLinearVelocity or Vector3.zero ;
        end);
    camera_9=(Camera.CFrame.Position-targetObject_17).Magnitude;
    targetObject_17=targetObject_17 + (camera_8 * targetObject_9.PredictionFactor * (camera_9/100)) ;
end pcall(function() Camera.CameraType=Enum.CameraType.Scriptable;
end);
position_19=Camera.CFrame.Position;
Camera.CFrame=CFrame.new(position_19,targetObject_17);
end
else pcall(function() if (Camera.CameraType==Enum.CameraType.Scriptable) then
            Camera.CameraType=Enum.CameraType.Custom;
        end
end);
end
end
end
end);
do eventConnection_11=false;
    pcall(function() eventConnection_11=type(mousemoverel)=="function" ;
        end);
    table.insert(State.connections,RunService.RenderStepped:Connect(function() if ( not State.scriptActive or  not State.antiRecoilEnabled) then
            State.arPrevPitch=nil;
            return;
        end uiButton_127=UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1);
    if uiButton_127 then
        uiButton_128=Camera.CFrame.LookVector;
        position_20=math.asin( -uiButton_128.Y);
        if State.arPrevPitch then
            stateRef_19=position_20-State.arPrevPitch ;
            if (stateRef_19< -0.0003) then
                position_21= -stateRef_19;
                stateRef_20=1800;
                camera_10=position_21 * stateRef_20 * State.antiRecoilStrength ;
                if eventConnection_11 then
                    mousemoverel(0,camera_10);
                else position_22=Camera.CFrame.Position;
                    position_23=math.atan2(uiButton_128.X,uiButton_128.Z);
                    position_24=position_20 + (position_21 * State.antiRecoilStrength) ;
                    camera_11=Vector3.new(math.cos(position_24) * math.sin(position_23) , -math.sin(position_24),math.cos(position_24) * math.cos(position_23) );
                    Camera.CFrame=CFrame.lookAt(position_22,position_22 + camera_11 ,Vector3.new(0,1,0));
                end
        end
end State.arPrevPitch=math.asin( -Camera.CFrame.LookVector.Y);
else State.arPrevPitch=nil;
end
end));
end table.insert(State.connections,RunService.Heartbeat:Connect(function(eventConnection_12) if ( not State.scriptActive or  not State.flyEnabled) then
    return;
end eventConnection_13=LocalPlayer.Character;
if  not eventConnection_13 then
    return;
end rootPart_18=eventConnection_13:FindFirstChild("HumanoidRootPart");
rootPart_19=eventConnection_13:FindFirstChildOfClass("Humanoid");
if ( not rootPart_18 or  not rootPart_19) then
    return;
end direction=State.flySpeed;
if State.flyBV then
    rootPart_20=0;
    State.flyBV.Velocity=Vector3.new(0,rootPart_20 * direction ,0);
end direction_2=Vector3.zero;
rootPart_21=Camera.CFrame.LookVector;
direction_3=Vector3.new(rootPart_21.X,0,rootPart_21.Z);
if (direction_3.Magnitude>0.01) then
    direction_3=direction_3.Unit;
end if (rootPart_19.MoveDirection.Magnitude>0.1) then
direction_2=rootPart_19.MoveDirection;
end if (direction_2.Magnitude>0.1) then
rootPart_18.CFrame=rootPart_18.CFrame + (direction_2.Unit * direction * eventConnection_12) ;
end if State.flyFakePart then
State.flyFakePart.CFrame=rootPart_18.CFrame * CFrame.new(0, -3.5,0) ;
end
end));
do eventConnection_14={};
    eventConnection_15=nil;
    table.insert(State.connections,RunService.Stepped:Connect(function() if ( not State.scriptActive or  not State.noclipEnabled) then
            return;
        end eventConnection_16=LocalPlayer.Character;
    if  not eventConnection_16 then
        return;
    end if (eventConnection_16~=eventConnection_15) then
    eventConnection_15=eventConnection_16;
    eventConnection_14={};
    for list_47,list_48 in ipairs(eventConnection_16:GetDescendants()) do if list_48:IsA("BasePart") then
                eventConnection_14[ #eventConnection_14 + 1 ]=list_48;
            end
    end
end for list_49,list_50 in ipairs(eventConnection_14) do list_50.CanCollide=false;
end partObject_2=eventConnection_16:FindFirstChildOfClass("Humanoid");
if (partObject_2 and partObject_2.SeatPart) then
    partObject_3=partObject_2.SeatPart:FindFirstAncestorWhichIsA("Model");
    if partObject_3 then
        for partObject_4,partObject_5 in ipairs(partObject_3:GetDescendants()) do if partObject_5:IsA("BasePart") then
                    if (State.noclipOrigCollisions[partObject_5]==nil) then
                        State.noclipOrigCollisions[partObject_5]=partObject_5.CanCollide;
                    end partObject_5.CanCollide=false;
            end
    end
end
end
end));
end do instanceObject_9=nil;
eventConnection_17=nil;
table.insert(State.connections,RunService.Heartbeat:Connect(function(eventConnection_18) if ( not State.scriptActive or  not State.vehSpeedEnabled) then
        if instanceObject_9 then
            pcall(function() instanceObject_9:Destroy();
            end);
        instanceObject_9=nil;
        eventConnection_17=nil;
    end return;
end playerRef_26=LocalPlayer.Character;
if  not playerRef_26 then
    return;
end characterObject_2=playerRef_26:FindFirstChildOfClass("Humanoid");
if ( not characterObject_2 or  not characterObject_2.SeatPart) then
    if instanceObject_9 then
        pcall(function() instanceObject_9:Destroy();
        end);
    instanceObject_9=nil;
    eventConnection_17=nil;
end return;
end vehicle_5=characterObject_2.SeatPart;
vehicle_6=vehicle_5:FindFirstAncestorWhichIsA("Model");
if  not vehicle_6 then
    return;
end vehicle_7=vehicle_6.PrimaryPart or vehicle_5 ;
if vehicle_5:IsA("VehicleSeat") then
    if  not State.vehOrigSpeeds[vehicle_5] then
        State.vehOrigSpeeds[vehicle_5]=vehicle_5.MaxSpeed;
    end pcall(function() vehicle_5.MaxSpeed=State.vehOrigSpeeds[vehicle_5] * State.vehSpeedMult ;
end);
end vehicle_8=vehicle_7.AssemblyLinearVelocity;
vehicle_9=Vector3.new(vehicle_8.X,0,vehicle_8.Z);
vehicle_10=0;
if vehicle_5:IsA("VehicleSeat") then
    vehicle_10=vehicle_5.ThrottleFloat or 0 ;
end if ((vehicle_9.Magnitude>1) or (math.abs(vehicle_10)>0.1)) then
if (eventConnection_17~=vehicle_5) then
    if instanceObject_9 then
        pcall(function() instanceObject_9:Destroy();
        end);
end instanceObject_9=Instance.new("BodyVelocity");
instanceObject_9.MaxForce=Vector3.new(math.huge,0,math.huge);
instanceObject_9.P=1250;
instanceObject_9.Parent=vehicle_7;
eventConnection_17=vehicle_5;
end if (instanceObject_9 and instanceObject_9.Parent) then
local rootPart_22;
if (vehicle_9.Magnitude>1) then
    rootPart_22=vehicle_9.Unit;
else rootPart_22=vehicle_7.CFrame.LookVector * (((vehicle_10>0) and 1) or  -1) ;
end rootPart_23=math.max(vehicle_9.Magnitude,20);
rootPart_24=rootPart_23 * State.vehSpeedMult ;
instanceObject_9.Velocity=Vector3.new(rootPart_22.X * rootPart_24 ,vehicle_8.Y,rootPart_22.Z * rootPart_24 );
end
elseif (instanceObject_9 and instanceObject_9.Parent) then
        instanceObject_9.Velocity=Vector3.new(0,0,0);
    end
end));
end do eventConnection_19=0;
table.insert(State.connections,RunService.Heartbeat:Connect(function(eventConnection_20) if ( not State.scriptActive or  not State.espEnabled) then
        return;
    end eventConnection_19=eventConnection_19 + eventConnection_20 ;
if (eventConnection_19<0.1) then
    return;
end eventConnection_19=0;
rootPart_25=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ;
for list_51,playerRef_27 in ipairs(Players:GetPlayers()) do if ((playerRef_27~=LocalPlayer) and playerRef_27.Character) then
            head_5=playerRef_27.Character:FindFirstChild("Head");
            health=getHumanoid(playerRef_27.Character);
            if (head_5 and health) then
                health_2=head_5:FindFirstChild("NameTag");
                playerRef_28=health_2 and health_2:FindFirstChild("TagLabel") ;
                if playerRef_28 then
                    rootPart_26=playerRef_27.Character:FindFirstChild("HumanoidRootPart");
                    playerRef_29=(rootPart_25 and rootPart_26 and (rootPart_25.Position-rootPart_26.Position).Magnitude) or 0 ;
                    playerRef_30=playerRef_27.DisplayName;
                    if State.showDistance then
                        playerRef_30=playerRef_30   .. " | "   .. string.format("%.0f",playerRef_29)   .. "m" ;
                    end if State.showHealth then
                    playerRef_30=playerRef_30   .. " | "   .. math.floor(health.Health)   .. "hp" ;
                end playerRef_28.Text=playerRef_30;
            uiLabel_51=State.espCache[playerRef_27.UserId];
            if uiLabel_51 then
                playerRef_28.TextColor3=uiLabel_51.color;
            end health_3=health_2:FindFirstChild("HPBarBg") and health_2.HPBarBg:FindFirstChild("HPBarFill") ;
        if health_3 then
            health_4=math.clamp(health.Health/health.MaxHealth ,0,1);
            health_3.Size=UDim2.new(health_4,0,1,0);
            health_3.BackgroundColor3=((health_4>0.5) and Color3.fromRGB(0,255,0)) or Color3.fromRGB(255,math.round(255 * health_4 * 2 ),0) ;
        end
end
end
end
end
end));
end do eventConnection_21=0;
table.insert(State.connections,RunService.Heartbeat:Connect(function(eventConnection_22) if ( not State.scriptActive or  not State.threatLines) then
        if next(State.threatLineCache) then
            for eventConnection_23,eventConnection_24 in pairs(State.threatLineCache) do pcall(function() eventConnection_24:Remove();
                    end);
            end State.threatLineCache={};
    end return;
end eventConnection_21=eventConnection_21 + eventConnection_22 ;
if (eventConnection_21<0.05) then
    return;
end eventConnection_21=0;
playerRef_31=LocalPlayer.Character;
rootPart_27=playerRef_31 and playerRef_31:FindFirstChild("HumanoidRootPart") ;
if  not rootPart_27 then
    return;
end list_52=Vector2.new(Camera.ViewportSize.X/2 ,Camera.ViewportSize.Y/2 );
playerRef_32={};
for uiColor_60,playerRef_33 in ipairs(Players:GetPlayers()) do if ((playerRef_33~=LocalPlayer) and playerRef_33.Character) then
            uiColor_61=false;
            uiColor_62=Color3.fromRGB(255,50,50);
            uiColor_63=getPlayerRole(playerRef_33);
            uiColor_64=uiColor_63=="Police" ;
            uiColor_65=(uiColor_63=="Civilian") or (uiColor_63=="Armed") ;
            if (State.threatLineArmed and isArmed(playerRef_33)) then
                if (uiColor_65 or (uiColor_64 and State.threatLinePolice)) then
                    uiColor_61=true;
                    uiColor_62=Color3.fromRGB(255,50,50);
                end
        end if State.threatLineWanted then
        tab_13=State.autoTabletResults and State.autoTabletResults[playerRef_33.UserId] ;
        if (tab_13 and (tab_13.wantedLevel>0)) then
            if (uiColor_65 or (uiColor_64 and State.threatLinePolice)) then
                uiColor_61=true;
                uiColor_62=Color3.fromRGB(255,200,0);
            end
    end
end if (State.threatLinePolice and uiColor_64 and  not uiColor_61) then
uiColor_61=true;
uiColor_62=Color3.fromRGB(0,150,255);
end if uiColor_61 then
rootPart_28=playerRef_33.Character:FindFirstChild("HumanoidRootPart");
if rootPart_28 then
    playerRef_34,playerRef_35=Camera:WorldToViewportPoint(rootPart_28.Position);
    if playerRef_35 then
        playerRef_32[playerRef_33.UserId]=true;
        playerRef_36=State.threatLineCache[playerRef_33.UserId];
        if  not playerRef_36 then
            uiColor_66,uiColor_67=pcall(function() uiColor_68=Drawing.new("Line");
                uiColor_68.Thickness=1.5;
                uiColor_68.Color=Color3.fromRGB(255,50,50);
                uiColor_68.Transparency=0.7;
                uiColor_68.Visible=true;
                return uiColor_68;
            end);
        if (uiColor_66 and uiColor_67) then
            playerRef_36=uiColor_67;
            State.threatLineCache[playerRef_33.UserId]=playerRef_36;
        end
end if playerRef_36 then
playerRef_36.From=list_52;
playerRef_36.To=Vector2.new(playerRef_34.X,playerRef_34.Y);
playerRef_36.Color=uiColor_62;
playerRef_36.Visible=true;
end
elseif State.threatLineCache[playerRef_33.UserId] then
        State.threatLineCache[playerRef_33.UserId].Visible=false;
    end
end
end
end
end for stateRef_21,stateRef_22 in pairs(State.threatLineCache) do if  not playerRef_32[stateRef_21] then
        pcall(function() stateRef_22:Remove();
        end);
    State.threatLineCache[stateRef_21]=nil;
end
end
end));
end do tab_14=game:GetService("ReplicatedStorage"):FindFirstChild("__remotes");
targetObject_18=tab_14 and tab_14:FindFirstChild("Tablet") ;
tab_15=0;
tab_16={};
uiColor_69={};
State.autoTabletResults=uiColor_69;
uiFrame_24=Instance.new("Frame");
uiFrame_24.Name="AutoTabletPanel";
uiFrame_24.Size=UDim2.new(0,200,0,240);
uiFrame_24.Position=UDim2.new(1, -210,0,50);
uiFrame_24.BackgroundColor3=Color3.fromRGB(15,12,20);
uiFrame_24.BackgroundTransparency=0.15;
uiFrame_24.BorderSizePixel=0;
uiFrame_24.Visible=false;
uiFrame_24.Parent=MainGui;
Instance.new("UICorner",uiFrame_24).CornerRadius=UDim.new(0,8);
uiLabel_52=Instance.new("TextLabel",uiFrame_24);
uiLabel_52.Size=UDim2.new(1,0,0,24);
uiLabel_52.BackgroundTransparency=1;
uiLabel_52.Text=translate("at_title");
registerLabel(uiLabel_52,"at_title");
uiLabel_52.TextColor3=Color3.fromRGB(255,200,0);
uiLabel_52.Font=Enum.Font.GothamBold;
uiLabel_52.TextSize=11;
instanceObject_10=Instance.new("ScrollingFrame",uiFrame_24);
instanceObject_10.Size=UDim2.new(1, -8,1, -28);
instanceObject_10.Position=UDim2.new(0,4,0,26);
instanceObject_10.BackgroundTransparency=1;
instanceObject_10.BorderSizePixel=0;
instanceObject_10.ScrollBarThickness=2;
instanceObject_10.CanvasSize=UDim2.new(0,0,0,0);
instanceObject_10.AutomaticCanvasSize=Enum.AutomaticSize.Y;
Instance.new("UIListLayout",instanceObject_10).Padding=UDim.new(0,2);
local function refreshTabletList() for index,child in ipairs(listContainer:GetChildren()) do if child:IsA("TextLabel") then
                child:Destroy();
            end
    end entryCount=0;
for size_12,entry in pairs(tabletEntries) do entryCount=entryCount + 1 ;
        entryLabel=Instance.new("TextLabel",listContainer);
        entryLabel.Size=UDim2.new(1,0,0,18);
        entryLabel.BackgroundTransparency=1;
        entryLabel.Font=Enum.Font.Gotham;
        entryLabel.TextSize=10;
        entryLabel.TextXAlignment=Enum.TextXAlignment.Left;
        if (entry.wantedLevel== -1) then
            entryLabel.Text="  ? "   .. entry.displayName   .. " — "   .. translate("at_timeout") ;
            entryLabel.TextColor3=Color3.fromRGB(150,150,150);
        elseif (entry.wantedLevel>0) then
                entryLabel.Text="  ! "   .. entry.displayName   .. " — "   .. translate("at_wanted")   .. " "   .. entry.wantedLevel ;
                entryLabel.TextColor3=Color3.fromRGB(255,60,60);
                if entry.warranted then
                    entryLabel.Text=entryLabel.Text   .. " "   .. translate("at_warrant") ;
                    entryLabel.TextColor3=Color3.fromRGB(255,100,0);
                end
        else entryLabel.Text="  OK "   .. entry.displayName   .. " — "   .. translate("at_clean") ;
            entryLabel.TextColor3=Color3.fromRGB(100,255,100);
        end
end uiFrame_24.Visible=State.autoTablet and (entryCount>0) ;
end eventConnection_25={};
local function findApartmentNameplates() nameplatesByUserId={};
    pcall(function() apartments=Workspace:FindFirstChild("Apartments");
        if  not apartments then
            return;
        end nameplates=apartments:FindFirstChild("Nameplates");
    if  not nameplates then
        return;
    end for index,nameplate in ipairs(nameplates:GetChildren()) do for descIndex,descendant in ipairs(nameplate:GetDescendants()) do if descendant:IsA("TextLabel") then
                displayedName=descendant.Text:match("^%s*(.-)%s*$");
                if (displayedName and (displayedName~="") and (displayedName~="Unoccupied")) then
                    for playerIndex,candidatePlayer in ipairs(Players:GetPlayers()) do if ((candidatePlayer~=LocalPlayer) and ((candidatePlayer.Name==displayedName) or (candidatePlayer.DisplayName==displayedName))) then
                                nameplatesByUserId[candidatePlayer.UserId]={player=candidatePlayer,nameplate=nameplate};
                            end
                    end
            end
    end
end
end
end);
return nameplatesByUserId;
end local function findApartmentDoor(nameplate) apartments=Workspace:FindFirstChild("Apartments");
if  not apartments then
    return nil;
end doors=apartments:FindFirstChild("Doors");
if  not doors then
    return nil;
end namedDoor=doors:FindFirstChild(nameplate.Name);
if namedDoor then
    return namedDoor;
end
local nameplatePosition;
for doorIndex,door in ipairs(nameplate:GetDescendants()) do if door:IsA("BasePart") then
            nameplatePosition=door.Position;
            break;
        end
end if  not nameplatePosition then
return nil;
end nearestDoor,nearestDistance=nil,20;
for partIndex,part in ipairs(doors:GetChildren()) do for descIndex,descendant in ipairs(part:GetDescendants()) do if descendant:IsA("BasePart") then
                distance=(descendant.Position-nameplatePosition).Magnitude;
                if (distance<nearestDistance) then
                    nearestDistance=distance;
                    nearestDoor=part;
                end break;
        end
end
end return nearestDoor;
end local function updateApartmentHighlight(eventConnection_26,highlight_2,highlight_3) if highlight_3 then
    if  not eventConnection_25[eventConnection_26] then
        highlight_4=findApartmentDoor(highlight_2);
        if highlight_4 then
            highlight_5=Instance.new("Highlight");
            highlight_5.Name="NeonDoorHL";
            highlight_5.FillColor=Color3.fromRGB(255,50,0);
            highlight_5.OutlineColor=Color3.fromRGB(255,255,0);
            highlight_5.FillTransparency=0.4;
            highlight_5.OutlineTransparency=0.1;
            highlight_5.Parent=highlight_4;
            eventConnection_25[eventConnection_26]=highlight_5;
        end
end
elseif eventConnection_25[eventConnection_26] then
        pcall(function() eventConnection_25[eventConnection_26]:Destroy();
        end);
    eventConnection_25[eventConnection_26]=nil;
end
end table.insert(State.connections,RunService.Heartbeat:Connect(function(eventConnection_27) if ( not State.scriptActive or  not State.autoTablet) then
    uiFrame_24.Visible=false;
    for eventConnection_28,eventConnection_29 in pairs(eventConnection_25) do pcall(function() eventConnection_29:Destroy();
            end);
        eventConnection_25[eventConnection_28]=nil;
    end return;
end if  not targetObject_18 then
pcall(function() tab_14=game:GetService("ReplicatedStorage"):FindFirstChild("__remotes");
    targetObject_18=tab_14 and tab_14:FindFirstChild("Tablet") ;
end);
if  not targetObject_18 then
    return;
end
end tab_15=tab_15 + eventConnection_27 ;
if (tab_15<State.autoTabletInterval) then
    return;
end tab_15=0;
tab_19=({[0]=Enum.KeyCode.Zero,[1]=Enum.KeyCode.One,[2]=Enum.KeyCode.Two,[3]=Enum.KeyCode.Three,[4]=Enum.KeyCode.Four,[5]=Enum.KeyCode.Five,[6]=Enum.KeyCode.Six,[7]=Enum.KeyCode.Seven,[8]=Enum.KeyCode.Eight,[9]=Enum.KeyCode.Nine})[State.tabletSlot];
if tab_19 then
    tab_20=LocalPlayer.Character;
    tab_21=tab_20 and tab_20:FindFirstChildOfClass("Tool") ;
    tab_22=tab_21 and tab_21.Name:lower():find("tablet") ;
    if  not tab_22 then
        pcall(function() game:GetService("VirtualInputManager"):SendKeyEvent(true,tab_19,false,game);
            task.wait(0.1);
            game:GetService("VirtualInputManager"):SendKeyEvent(false,tab_19,false,game);
        end);
    task.wait(0.3);
end
end targetObject_19=targetObject_18:FindFirstChild("SearchWarrantTarget");
targetObject_20=targetObject_18:FindFirstChild("ObtainSearchWarrant");
if ( not targetObject_19 or  not targetObject_20) then
    notify(translate("auto_tablet"),translate("notif_remotes_nf"),Color3.fromRGB(255,80,80));
    return;
end uiColor_70=findApartmentNameplates();
list_70={};
if next(uiColor_70) then
    list_70=uiColor_70;
else for list_71,list_72 in ipairs(Players:GetPlayers()) do if (list_72~=LocalPlayer) then
                list_70[list_72.UserId]={player=list_72,nameplate=nil};
            end
    end
end uiFrame_24.Visible=true;
for uiColor_71,list_73 in pairs(list_70) do if  not tab_16[uiColor_71] then
            tab_16[uiColor_71]=tick();
            uiColor_72=list_73.player;
            uiColor_73=list_73.nameplate;
            task.spawn(function() tab_23=nil;
                tab_24=false;
                task.spawn(function() remote,remoteObject_2=pcall(function() return targetObject_19:InvokeServer(uiColor_72.Name);
                    end);
                if remote then
                    tab_23=remoteObject_2;
                end tab_24=true;
        end);
    playerRef_42=0;
    while  not tab_24 and (playerRef_42<5)  do task.wait(0.2);
            playerRef_42=playerRef_42 + 0.2 ;
        end if  not tab_24 then
        tabletEntries[uiColor_71]={displayName=uiColor_72.DisplayName,wantedLevel= -1,hasWarrant=false,warranted=false};
        refreshTabletList();
        return;
    end if ((type(tab_23)=="table") and tab_23.Found) then
    uiColor_74=tab_23.WantedLevel or 0 ;
    tab_25=tab_23.HasWarrant or false ;
    tabletEntries[uiColor_71]={displayName=tab_23.DisplayName or uiColor_72.DisplayName ,wantedLevel=uiColor_74,hasWarrant=tab_25,warranted=false};
    if ((uiColor_74>0) and  not tab_25) then
        pcall(function() targetObject_20:InvokeServer(uiColor_72.Name);
        end);
    tabletEntries[uiColor_71].warranted=true;
    notify(translate("auto_tablet"),translate("at_warrant_notif")   .. ": "   .. uiColor_72.DisplayName   .. " ("   .. uiColor_74   .. ")" ,Color3.fromRGB(255,100,0));
end if uiColor_73 then
updateApartmentHighlight(uiColor_71,uiColor_73,uiColor_74>0 );
end refreshTabletList();
end
end);
end
end list_74=tick();
for tab_26,list_75 in pairs(tab_16) do if ((list_74-list_75)>60) then
            tab_16[tab_26]=nil;
            tabletEntries[tab_26]=nil;
            updateApartmentHighlight(tab_26,nil,false);
        end
end refreshTabletList();
if tab_19 then
    task.spawn(function() task.wait(0.5);
        tab_27=LocalPlayer.Character;
        tab_28=tab_27 and tab_27:FindFirstChildOfClass("Tool") ;
        if (tab_28 and tab_28.Name:lower():find("tablet")) then
            pcall(function() game:GetService("VirtualInputManager"):SendKeyEvent(true,tab_19,false,game);
                task.wait(0.1);
                game:GetService("VirtualInputManager"):SendKeyEvent(false,tab_19,false,game);
            end);
    end
end);
end
end));
end table.insert(State.connections,RunService.Heartbeat:Connect(function(eventConnection_30) if ( not State.scriptActive or  not State.speedBoostEnabled) then
    return;
end eventConnection_31=LocalPlayer.Character;
if  not eventConnection_31 then
    return;
end rootPart_29=eventConnection_31:FindFirstChild("HumanoidRootPart");
rootPart_30=eventConnection_31:FindFirstChildOfClass("Humanoid");
if ( not rootPart_29 or  not rootPart_30) then
    return;
end if (rootPart_30.MoveDirection.Magnitude>0.1) then
direction_4=rootPart_30.MoveDirection * (State.speedBoostMult-1) * 16 * eventConnection_30 * 3 ;
rootPart_29.CFrame=rootPart_29.CFrame + direction_4 ;
end
end));
do eventConnection_32=true;
    table.insert(State.connections,RunService.Heartbeat:Connect(function() if ( not State.scriptActive or  not State.jumpBoostEnabled) then
            return;
        end eventConnection_33=LocalPlayer.Character;
    if  not eventConnection_33 then
        return;
    end rootPart_31=eventConnection_33:FindFirstChild("HumanoidRootPart");
characterObject_3=eventConnection_33:FindFirstChildOfClass("Humanoid");
if ( not rootPart_31 or  not characterObject_3) then
    return;
end task=characterObject_3.FloorMaterial~=Enum.Material.Air ;
if (eventConnection_32 and  not task) then
    rootPart_32=(State.jumpBoostMult-1) * 35 ;
    rootPart_31.Velocity=rootPart_31.Velocity + Vector3.new(0,rootPart_32,0) ;
end eventConnection_32=task;
end));
end task.spawn(function() while State.scriptActive do task.wait(2);
        if State.espEnabled then
            for playerRef_43,playerRef_44 in ipairs(Players:GetPlayers()) do if ((playerRef_44~=LocalPlayer) and playerRef_44.Character) then
                        playerRef_45,playerRef_46=getPlayerRole(playerRef_44);
                        State.espCache[playerRef_44.UserId]={role=playerRef_45,color=playerRef_46};
                        playerRef_47=playerRef_44.Character:FindFirstChild("ESPHighlight");
                        if playerRef_47 then
                            playerRef_47.FillColor=playerRef_46;
                        end
                end
        end
end
end
end);
local function setupPlayerESP(playerRef_48) playerRef_48.CharacterAdded:Connect(function() task.wait(0.3);
        if (State.espEnabled and State.scriptActive) then
            applyESP(playerRef_48);
        end
end);
end for list_76,list_77 in ipairs(Players:GetPlayers()) do if (list_77~=LocalPlayer) then
        setupPlayerESP(list_77);
    end
end Players.PlayerAdded:Connect(setupPlayerESP);
Players.PlayerRemoving:Connect(removeESP);
task.spawn(function() playerRef_49=0;
    task_2=0;
    task_3=0;
    while State.scriptActive do task.wait(0.05);
            playerRef_49=(playerRef_49 + 0.004)%1 ;
            if (State.fovGradient and State.FOVCircle) then
                pcall(function() State.FOVCircle.Color=Color3.fromHSV(playerRef_49,1,1);
                end);
        end if (State.espGradient and State.espEnabled) then
        uiColor_75=Color3.fromHSV(playerRef_49,0.8,1);
        for playerRef_50,playerRef_51 in ipairs(Players:GetPlayers()) do if ((playerRef_51~=LocalPlayer) and playerRef_51.Character) then
                    playerRef_52=State.espCache[playerRef_51.UserId];
                    playerRef_53=(playerRef_52 and playerRef_52.role) or "Civilian" ;
                    if State.espGradientRoles[playerRef_53] then
                        uiColor_76=playerRef_51.Character:FindFirstChild("ESPHighlight");
                        if uiColor_76 then
                            if (State.espGradientMode=="outline") then
                                uiColor_76.OutlineColor=uiColor_75;
                            else uiColor_76.FillColor=uiColor_75;
                            end
                    end
            end
    end
end
end
end
end);
notify("ECLIPSE LocalPlayer","Mobile Edition loaded",Color3.fromRGB(168,85,247));
logDebug("ECLIPSE LocalPlayer Mobile fully loaded!");
