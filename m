From: rogerq@ti.com (Roger Quadros)
Date: Tue, 8 Oct 2013 13:06:33 +0300
Subject: [PATCH v2 0/6] Add USB Host support for OMAP5 uevm for 3.13
Message-ID: <1381226799-29158-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series provide USB host support for the OMAP5 uEVM board.
As ethernet port is over USB, it brings up ethernet as well.

Series depends on the OMAP clock tree DT data series by Tero Kristo [1]

Tested on OMAP5 uEVM and OMAP4 Panda.

cheers,
-roger

[1] - 	OMAP Clock DT conversion
	http://www.spinics.net/lists/arm-kernel/msg275311.html

Roger Quadros (6):
  ARM: OMAP5: hwmod data: Add USB Host and TLL modules
  ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
  ARM: dts: omap4-panda: Provide USB PHY clock
  ARM: dts: omap5-uevm: Provide USB PHY clock
  Revert "ARM: OMAP2+: Provide alias to USB PHY clock"
  mfd: omap-usb: prepare/unprepare clock while enable/disable

 arch/arm/boot/dts/omap4-panda-common.dtsi  |    8 +--
 arch/arm/boot/dts/omap5-uevm.dts           |    8 +--
 arch/arm/boot/dts/omap5.dtsi               |    2 +
 arch/arm/mach-omap2/board-generic.c        |   23 +-----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  135 ++++++++++++++++++++++++++++
 drivers/mfd/omap-usb-host.c                |   16 ++--
 drivers/mfd/omap-usb-tll.c                 |    4 +-
 7 files changed, 152 insertions(+), 44 deletions(-)

-- 
1.7.4.1
