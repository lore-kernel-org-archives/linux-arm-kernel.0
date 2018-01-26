From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 26 Jan 2018 16:19:25 +0100
Subject: [PATCH 00/16] IIO-based thermal sensor driver for Allwinner H3 and
 A83T SoC
Message-ID: <20180126151941.12183-1-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwiner H3 and A83T SoCs have a thermal sensor, which is a large refactored
version of the old Allwinner "GPADC" (although it have already only
thermal part left in A33).

This patch tried to add support for the sensor in H3 and A83T based on
the A33 thermal sensor driver by Quentin Schulz, which is already merged.

This Patchseries is based on Icenowy Zhengs v4 patchseries [1]. 
The first 5 patches are reworked patches from the v4 patchseries. 
The rest of the patches add step by step a feature to support multible
sensors, nvmem calibration and interupts. This patchseries should make it
easy also to add other sunxi SoCs, like the H5, A64 and A80.

Patches that adds support for H5, A64 and A80 SoCs are allready prepared,
and will be upstreamed if this patchseries is applied and the testing is done.

I tried to pick up all the feedback from [1]. I hope I didn't miss anything.

Regards,
Philipp 

[1]: https://lkml.org/lkml/2017/9/14/317


Icenowy Zheng (1):
  iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain
    A33

Philipp Rossak (15):
  dt-bindings: update the Allwinner GPADC device tree binding for H3 &
    A83T
  arm: config: sunxi_defconfig: enable SUN4I_GPADC
  iio: adc: sun4i-gpadc-iio: rework: sampling start/end code readout reg
  iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
  iio: adc: sun4i-gpadc-iio: rework: support multible sensors
  iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
  iio: adc: sun4i-gpadc-iio: rework: add interrupt support
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
  arm: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
  arm: dts: sun8i: h3: add support for the thermal sensor in H3
  arm: dts: sun8i: h3: add thermal zone to H3
  arm: dts: sun8i: h3: enable H3 sid controller
  arm: dts: sun8i: a83t: add support for the thermal sensor in A83T
  arm: dts: sun8i: a83t: add thermal zone to A83T

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  50 ++-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  28 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  21 ++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   9 +
 arch/arm/configs/sunxi_defconfig                   |   1 +
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 378 +++++++++++++++++++--
 include/linux/mfd/sun4i-gpadc.h                    |  66 +++-
 7 files changed, 522 insertions(+), 31 deletions(-)

-- 
2.11.0
