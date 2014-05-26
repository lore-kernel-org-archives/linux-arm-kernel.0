From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 26 May 2014 21:29:47 +0200
Subject: [PATCHv4 0/4] DT support for LaCie 2Big and 5Big Network v2
Message-ID: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:
Rename board-netxbig.c to netxbig.c
Add _v2 to compatible string for devices
Fix SoC version
tabification
Add Fan controller and clock
Enable fan controller in _defconfig files

Andrew Lunn (4):
  ARM: Kirkwood: Add setup file for netxbig LEDs
  ARM: Kirkwood: Add DT descriptions for net2big and net5big.
  ARM: mvebu: Add LaCie 2Big and 5Big Network v2
  ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2

 arch/arm/boot/dts/Makefile              |   2 +
 arch/arm/boot/dts/kirkwood-net2big.dts  |  30 +++++
 arch/arm/boot/dts/kirkwood-net5big.dts  |  83 ++++++++++++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi | 180 ++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v5_defconfig     |   2 +
 arch/arm/configs/mvebu_v5_defconfig     |   2 +
 arch/arm/mach-mvebu/Kconfig             |   7 ++
 arch/arm/mach-mvebu/Makefile            |   1 +
 arch/arm/mach-mvebu/board.h             |   5 +
 arch/arm/mach-mvebu/kirkwood.c          |   3 +
 arch/arm/mach-mvebu/netxbig.c           | 191 ++++++++++++++++++++++++++++++++
 11 files changed, 506 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
 create mode 100644 arch/arm/mach-mvebu/netxbig.c

-- 
2.0.0.rc2
