-- Script: Payback² | The Battle Sandbox
-- Version: 2.106.16
-- Launcher: GameGuardian
-- Autor: @AlohYT
-- Have Fun, Your Choice ;)





-- Edit at pleasure
local jumpMultiplier = 4.5
local hideAlert = false -- true (hide) | false (show)
-- Edit at pleasure





-- Simple Function to Find Range.
-- Note: Don't edit if you don't
-- know what you're doing.
local Game = gg.getTargetInfo()
local is64 = Game.x64 and true or false
local dbg = is64 and 0x320 or 0x44F48
local alt = is64 and 0x6C8 or 0x680
gg.setVisible(false)

function debug.getRange(obj)
	gg.setRanges(obj)
	gg.searchNumber(343343205, gg.TYPE_DWORD)
	local a, b = gg.getResults(1)
	if #a == 0 then
		b = false
	end
	b = true
	gg.clearResults()
	return b
end

local ranges = {
	gg.REGION_C_BSS,
	gg.REGION_ANONYMOUS,
	gg.REGION_OTHER,
}

for i, v in ipairs(ranges) do
	local test = debug.getRange(v)
	if test == true then
		range = v -- Finds Your Range
		break
	end
end


-- Main Logic --
gg.clearResults()
gg.setRanges(range)
gg.searchNumber(2683118434169847807, gg.TYPE_QWORD)
local addr = gg.getResults(1)
if #addr == 0 then
	gg.alert("Main Value Not Found!")
	os.exit()
end
addr = addr[1].address -- Saving the "key" value.
gg.clearResults()


::Back::
gg.setVisible(false)
gg.clearResults()
gg.setRanges(range)
gg.toast("PISTOL")
gg.sleep(1750)
gg.searchNumber(0xD, 4)
gg.toast("KNIFE")
gg.sleep(1750)
gg.refineNumber(0x0, 4)
gg.toast("PISTOL")
gg.sleep(1750)
gg.refineNumber(0xD, 4)
local q = {}
q[1] = {}
w = gg.getResults(1, 1) -- Skips 1 Result

if #w == 0 then
	gg.alert("Failed! Try Again", "")
	gg.toast("Wait!")
	gg.sleep(2000)
	goto Back
end

main = w[1].address
gg.clearResults()
gg.setVisible(false)

if not hideAlert then
	gg.alert("Hit Horn Button to Jump\n\nHit the GG Icon to exit Script")
end

gg.toast("Horn Jump!")



repeat
	-- Conditions --
	local isGG = gg.isVisible(true)
	if isGG then break end

	local claxon = gg.getValues({ {
		address = addr - 0x500 + dbg,
		flags = gg.TYPE_DWORD
	} })[1].value

	if claxon == 1 then
		local altitude = gg.getValues({ {
			address = w[1].address - alt,
			flags = gg.TYPE_FLOAT
		} })[1].value
		q[1].address = main - alt
		q[1].flags = gg.TYPE_FLOAT
		q[1].value = altitude + (math.floor(jumpMultiplier) / 1000)
		gg.setValues(q)
	end
until false
