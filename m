From: marek@goldelico.com (Marek Belisko)
Date: Tue, 10 Mar 2015 22:27:21 +0100
Subject: [PATCH v4 0/6] Convert twl4030_madc_battery to IIO consumer and add
 DT aupport
Message-ID: <1426022847-30912-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches adding support for twl4030_madc_battery to use twl4030_madc iio framework + DT support.
Patches was tested on gta04 board. twl4030_madc_battery driver is converted in
first patch to iio consumer and in next patches is added support for devicetree
+ some small fixes for module autoloading.

Changes from V3:
- added ti prefix for volt-to-capacity-discharging/charging-map properties

Changes from V2:
- fix property names
- add MODULE_DEVICE_TABLE and MODULE_ALIAS

Changes from V1:
- use iio_read_channel_processed instead iio_read_channel_processed
- convert probe to use devm_ as part of adding error handling for iio
- free iio channels on error and on module removal

[1] - https://lkml.org/lkml/2014/2/26/482dd

Marek Belisko (6):
  power: twl4030-madc-battery: Convert to iio consumer.
  power: twl4030_madc_battery: Add device tree support
  Documentation: DT: Document twl4030-madc-battery bindings
  ARM: dts: omap3-gta04: Add battery support
  power: twl4030_madc_battery: Add of_twl4030_madc_match to
    MODULE_DEVICE_TABLE
  power: twl4030_madc_battery: Add missing MODULE_ALIAS

 .../bindings/power_supply/twl4030_madc_battery.txt |  43 +++++
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  30 ++++
 drivers/power/twl4030_madc_battery.c               | 183 +++++++++++++++++----
 3 files changed, 221 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt

-- 
1.9.1
