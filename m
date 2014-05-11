From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 11 May 2014 22:21:48 +0200
Subject: [PATCH v3 0/4] DT support for LaCie 2Big and 5Big Network v2
Message-ID: <1399839712-2416-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
gpio_poweroff -> gpio-poweroff, etc.
Add stdout-path
Remove pinctrl property from spi, set in kirkwood.dtsi.

Andrew Lunn (4):
  ARM: Kirkwood: Add board file for netxbig LEDs
  ARM: Kirkwood: Add DT descriptions for net2big and net5big.
  ARM: mvebu: Add LaCie 2Big and 5Big Network v2
  ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2

 arch/arm/boot/dts/Makefile              |   2 +
 arch/arm/boot/dts/kirkwood-net2big.dts  |  30 +++++
 arch/arm/boot/dts/kirkwood-net5big.dts  |  83 ++++++++++++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi | 166 +++++++++++++++++++++++++++
 arch/arm/configs/multi_v5_defconfig     |   1 +
 arch/arm/configs/mvebu_v5_defconfig     |   1 +
 arch/arm/mach-mvebu/Kconfig             |   7 ++
 arch/arm/mach-mvebu/Makefile            |   1 +
 arch/arm/mach-mvebu/board-netxbig.c     | 191 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/board.h             |   5 +
 arch/arm/mach-mvebu/kirkwood.c          |   3 +
 11 files changed, 490 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
 create mode 100644 arch/arm/mach-mvebu/board-netxbig.c

-- 
2.0.0.rc2
