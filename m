From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun,  2 Apr 2017 21:33:00 +0800
Subject: [RFC PATCH v2 0/4] IIO-based thermal sensor driver for Allwinner H3
 SoC
Message-ID: <20170402133304.56824-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwiner H3 SoC has a thermal sensor, which is a large refactored version of
the old Allwinner "GPADC" (although it have already only thermal part left
in A33).

This patch tried to add support for the sensor in H3 based on the A33
thermal sensor patchset by Quentin Schulz at [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/495505.html

Icenowy Zheng (4):
  dt-bindings: update the Allwinner GPADC device tree binding for H3
  iio: adc: sun4i-gpadc-iio: rename A23/A33-specified registers to
    contain A23
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  ARM: sun8i: h3: add support for the thermal sensor in H3

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  23 ++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  26 +++
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 215 +++++++++++++++++----
 include/linux/mfd/sun4i-gpadc.h                    |  36 +++-
 4 files changed, 254 insertions(+), 46 deletions(-)

-- 
2.12.2
