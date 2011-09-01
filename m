From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:25:05 +0200
Subject: [PATCH 0/7] OMAP3: Add basic DT support + i2c + twl
Message-ID: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Tony,

This is second part of the rework of the original series done by Manju:
http://www.spinics.net/lists/linux-omap/msg55827.html

It introduces the OMAP3 DT support incrementaly like it was done for OMAP4.

Patches are based on for_3.2/5_omap_dt_i2c_twl + devicetree/test
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/6_omap3_dt_base

Tested on Beagle XM.

Comments are welcome.

Regards,
Benoit


Benoit Cousson (7):
  arm/dts: Add initial device-tree support for OMAP3 SoC
  arm/dts: OMAP3: Add mpu and iva nodes
  arm/dts: OMAP3: Add i2c controllers nodes
  arm/dts: omap3-beagle: Include the generic omap3.dtsi
  arm/dts: omap3-beagle: Add twl4030 and EEPROM i2c devices
  OMAP3: board-dt: Add generic board file for DT support
  OMAP3: beagleboard: Remove DT support from regular board

 arch/arm/boot/dts/omap3-beagle.dts      |   68 +++++++++++++++++++++-
 arch/arm/boot/dts/omap3.dtsi            |   95 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig             |   10 +++
 arch/arm/mach-omap2/Makefile            |    1 +
 arch/arm/mach-omap2/board-omap3-dt.c    |   74 ++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c |   13 ----
 arch/arm/mach-omap2/pm.c                |    6 +-
 7 files changed, 250 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3.dtsi
 create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
