From: b38611@freescale.com (Fugang Duan)
Date: Wed, 19 Aug 2015 13:33:58 +0800
Subject: [PATCH v1 0/6] Add fec1 and fec2 support for i.MX7d sdb board
Message-ID: <1439962444-27486-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series is to add fec support for i.MX7d sdb board. Since i.MX7d fec ip is
the same as i.MX6SX, so there have no change for driver itself.

Patch#1: add bcm54220 PHY ID entry into brcmphy.h file.
Patch#2: add new iomux-gpr file to define iomux-gpr register and field for i.MX7d.
Patch#3: i.MX7d sdb board install bcm54220 phy, i.MX7d arm2 board install AR8031 phy.
	 For the two phys, there needs extra phy setting, so package the setting to fixup.
Patch#4~6: Add fec dts node and pinmux setting in dts file.


Fugang Duan (6):
  net: phy: broadcom: add bcm54220 phy ID
  ARM: imx7d: add imx7d iomux-gpr field define
  ARM: imx: add enet init for i.MX7D platform
  ARM: dts: imx: pinfunc: add GPIO1 pin define for i.MX7d
  ARM: dts: imx7d: add fec1 and fec2 support for i.MX7d soc
  ARM: dts: imx7d-sdb: add fec1 and fec2 support

 arch/arm/boot/dts/imx7d-pinfunc.h          | 115 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-sdb.dts            |  76 ++++++++++++++++++-
 arch/arm/boot/dts/imx7d.dtsi               |  36 +++++++++
 arch/arm/mach-imx/mach-imx7d.c             |  75 ++++++++++++++++++-
 include/linux/brcmphy.h                    |   1 +
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h |  49 ++++++++++++
 6 files changed, 349 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/mfd/syscon/imx7-iomuxc-gpr.h

-- 
1.9.1
