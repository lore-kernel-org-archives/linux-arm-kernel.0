From: b38611@freescale.com (Fugang Duan)
Date: Mon, 7 Sep 2015 10:54:58 +0800
Subject: [PATCH v3 0/4] Add fec1 and fec2 support for i.MX7d sdb board
Message-ID: <1441594502-19236-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series is to add fec support for i.MX7d sdb board. Since i.MX7d fec ip is
the same as i.MX6SX, so there have no change for driver itself.

Patch#1: add new iomux-gpr file to define iomux-gpr register and field for i.MX7d.
Patch#2: i.MX7d sdb board install bcm54220 phy, i.MX7d arm2 board install AR8031 phy.
         For the two phys, there needs extra phy setting, so package the setting to fixup.
Patch#3~4: Add fec dts node and pinmux setting in dts file.


Since the patch series drop i.MX7d pinfunc patch, and also depend on the pinfunc patch. So
pls apply the patch series after Adrian's patch: http://article.gmane.org/gmane.linux.kernel.gpio/10398/match=

Change:
V3:
	* Drop patch "ARM: dts: imx: pinfunc: add GPIO1 pin define for i.MX7d" that was also submitted by
	  Adrian: http://article.gmane.org/gmane.linux.kernel.gpio/10398/match=
	* Modify some slice as Shawn's comments.
V2:
        * Remove patch#1 in V1 patch series. Move the sigle BCM54220 PHY ID define to machine file.
        * The current BCM54220 switch phy still use generic phy driver since broadcom phy driver don't
          support the switch phy, there need effort to add the switch phy support. Once broadcom phy driver
          will support the bcm54220 switch phy, we can add the special config to imx_v6_v7_defconfig.


Fugang Duan (4):
  ARM: imx7d: add imx7d iomux-gpr field define
  ARM: imx: add enet init for i.MX7D platform
  ARM: dts: imx7d: add fec1 and fec2 support for i.MX7d soc
  ARM: dts: imx7d-sdb: add fec1 and fec2 support

 arch/arm/boot/dts/imx7d-sdb.dts            | 76 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx7d.dtsi               | 36 ++++++++++++++
 arch/arm/mach-imx/mach-imx7d.c             | 74 +++++++++++++++++++++++++++++
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h | 47 ++++++++++++++++++
 4 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/mfd/syscon/imx7-iomuxc-gpr.h

-- 
1.9.1
