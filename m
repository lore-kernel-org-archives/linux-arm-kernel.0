From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 24 Jun 2014 17:49:12 +0530
Subject: [PATCH 0/4] hwmon: ntc_thermistor: prepose vendor prefix change
Message-ID: <1403612356-23685-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Murata is the manufacturer of the NTC (Negative Temperature coefficient)
based Thermistors. ntc_thermistor driver extensively used the prefix "ntc".
But, vendor-prefix should be "murata" instead of "ntc".

This patchset
1. Updates the vendor-prefix, DT bindings and Documentation,
   where ever necessary.
2. Adds thermistor nodes to Exynos5420 and Exynos5800 based boards.

Patches:
1/4. devicetree: bindings: Document murata vendor prefix
     Adds the vendor prefix "murata" to vendor-prefixes.txt.
2/4. hwmon: ntc_thermistor: Use the manufacturer name properly
     Updates the driver, Kconfig, device tree bindings and Documentation
     with the Manufacturer/vendor information.
3/4. ARM: DTS: use new compatible string as per the documentation
     Updates the device node in Exynos4412 based Trats2 board
     with the new device tree bindings.
4/4. ARM: DTS: Add NTC thermistor nodes as child nodes to ADC
     Adds Thermistor nodes to Exynos5420 and Exynos5800 based boards.

This patchset
Naveen Krishna Chatradhi (4):
  devicetree: bindings: Document murata vendor prefix
  hwmon: ntc_thermistor: Use the manufacturer name properly
  ARM: DTS: Add NTC thermistor nodes as child nodes to ADC
  ARM: DTS: use new compatible string as per the documentation

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |    2 +-
 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |   12 ++++----
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 Documentation/hwmon/ntc_thermistor                 |    8 ++---
 arch/arm/boot/dts/exynos4412-trats2.dts            |    4 +--
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   32 ++++++++++++++++++++
 drivers/hwmon/Kconfig                              |    5 +--
 drivers/hwmon/ntc_thermistor.c                     |   12 ++++----
 8 files changed, 55 insertions(+), 21 deletions(-)

-- 
1.7.9.5
