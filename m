From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  2 Jan 2017 23:03:41 +0000
Subject: [PATCH 0/5] arm64: sunxi: A64: enable MMC support
Message-ID: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far the Allwinner A64/Pine64 DT was missing MMC support, because we
observed issues with that. Those have now been fixed (patch 1 and 2),
so we can enable the MMC IP block in the SoC .dtsi and the Pine64 .dts.
As this gives access to the SD card (as the only mass storage device on
most boards), this makes the kernel support actually useful.
The A64 MMC controller has more up its sleeves, but for now this level
of support is good enough.
Thanks a lot to Maxime for investigating the eMMC failure and coming up
with a nice fix for that.
Maxime: I picked that patch from some pastebin drop of yours, please holler
if there's something wrong with that (patch 2/5).

I send the BananaPi M64 .dts patch along with that series, as the eMMC on
that board now makes some difference.

Cheers,
Andre.

Andre Przywara (4):
  drivers: mmc: sunxi: fix A64 calibration routine
  arm64: dts: sun50i: add MMC nodes
  arm64: dts: Pine64: add MMC support
  arm64: dts: add BananaPi-M64 support

Maxime Ripard (1):
  drivers: mmc: sunxi: limit A64 MMC2 to 8K DMA buffer

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 125 +++++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  18 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  77 +++++++++++++
 drivers/mmc/host/sunxi-mmc.c                       |  37 ++++--
 6 files changed, 247 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts

-- 
2.8.2
