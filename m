From: b38611@freescale.com (Fugang Duan)
Date: Tue, 28 Jul 2015 15:30:38 +0800
Subject: [PATCH v2 0/4] ARM: imx6ul: add fec1 and fec2 support for i.MX6ul
 14x14 evk board
Message-ID: <1438068642-6876-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, upstream kernel support i.MX6ul 14x14 evk board, but don't support ethernet that
bringup some inconvenient for other modules debug and support.

The patch series just add fec1 and fec2 two MACs support for the board.

Patch#1 and #2:
	FEC MAC refrence clock needs extra GPR bit set to select clock source.
	The board install KSZ8081 that also needs extra phyfix.
Patch#3 and #4:
	Add fec support for SOC and evk board in dts file.

Changes:
V2:
 * As Shawn's suggestion:
   Group <linux/*> headers together and have them sort alphabetically
   Remove PHY_ID_KSZ8081 as it is defined in include/linux/micrel_phy.h file.

Fugang Duan (4):
  ARM: imx6ul: add fec bits to GPR syscon definition
  ARM: imx6ul: add fec MAC refrence clock and phy fixup init
  ARM: dts: imx: add fec1 and fec2 nodes for SOC i.MX6UL
  ARM: dts: imx6ul-14x14-evk: add fec1 and fec2 support

 arch/arm/boot/dts/imx6ul-14x14-evk.dts      | 29 +++++++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi               | 37 +++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx6ul.c             | 43 +++++++++++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  8 ++++++
 4 files changed, 117 insertions(+)

-- 
1.9.1
