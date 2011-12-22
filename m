From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 22 Dec 2011 15:56:34 +0100
Subject: [PATCH v4 00/12] OMAP4: Add DT support for i2c and twl6030
Message-ID: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony and Rob,

Here is the updated version of the i2c + twl DT adaptation series.

This update, compared to v3 [1], is fixing the twl-core build for non-OMAP
platform.
Per Olof's suggestion, adding the of.h include in the i2c driver to avoid
problem in case on non-DT build.

Patches are based on for_3.3/2_dt_irq, to get the latest GIC binding,
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.3/3_omap_dt_i2c_twl

Tested on Beagle and sdp4430. Build tested for x86.

Comments are welcome.

Regards,
Benoit

[1] http://www.spinics.net/lists/linux-omap/msg62127.html

Benoit Cousson (12):
  ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
  i2c: OMAP: Add DT support for i2c controller
  mfd: twl-core: Add initial DT support for twl4030/twl6030
  rtc: rtc-twl: Add DT support for RTC inside twl4030/twl6030
  arm/dts: OMAP4: Add i2c controller nodes
  arm/dts: OMAP3: Add i2c controller nodes
  arm/dts: twl6030: Add DTS file for twl6030 PMIC
  arm/dts: twl4030: Add DTS file for twl4030 PM + Audio IC
  arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
  arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
  arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
  ARM: OMAP2+: board-generic: Remove i2c static init

 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++
 .../devicetree/bindings/mfd/twl-familly.txt        |   47 +++++++++
 Documentation/devicetree/bindings/rtc/twl-rtc.txt  |   12 +++
 arch/arm/boot/dts/omap3-beagle.dts                 |   29 ++++++
 arch/arm/boot/dts/omap3.dtsi                       |   21 ++++
 arch/arm/boot/dts/omap4-panda.dts                  |   34 +++++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   53 ++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   28 ++++++
 arch/arm/boot/dts/twl4030.dtsi                     |   21 ++++
 arch/arm/boot/dts/twl6030.dtsi                     |   22 ++++
 arch/arm/mach-omap2/board-generic.c                |   48 +---------
 arch/arm/mach-omap2/pm.c                           |    8 ++
 drivers/i2c/busses/i2c-omap.c                      |  102 +++++++++++++-------
 drivers/mfd/Kconfig                                |    1 +
 drivers/mfd/twl-core.c                             |   51 ++++++++++-
 drivers/rtc/rtc-twl.c                              |   10 ++-
 16 files changed, 433 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/twl-familly.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
 create mode 100644 arch/arm/boot/dts/twl4030.dtsi
 create mode 100644 arch/arm/boot/dts/twl6030.dtsi
