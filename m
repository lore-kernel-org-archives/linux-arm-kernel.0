From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 20 Sep 2017 23:18:07 +0800
Subject: [RFC PATCH 0/7] AXP803 AC/Battery support
Message-ID: <20170920151814.22461-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP803 PMIC, used by most Allwinner A64 boards, features 3 power inputs:
AC, USB and Battery.

This patchset adds support for the AC and Battery supplies, which is useful
for the boards from Pine64 (Pine64, SoPine w/ baseboard model A, Pinebook).

The USB supply is not yet supported in this patchset because it's not
present on Pine series boards.

In order to enable battery monitoring the ADC for battery is also enabled
for AXs.

In order to enable battery monitoring the ADC for battery is also enabled
for AXP803.

Icenowy Zheng (7):
  dt-bindings: add compatibles for AXP803 Battery/USB power supplies
  iio: adc: axp20x-adc: allow to skip ADC rate setup now
  iio: adc: axp20x-adc: add support for AXP803
  power: supply: axp20x-battery: support AXP803
  mfd: axp20x: add cells for AXP803 ADC/AC Power/Battery
  arm64: allwinner: a64: add power supply nodes in AXP803 DTSI
  arm64: allwinner: a64: enable AC and Battery for Pine64

 .../bindings/power/supply/axp20x_battery.txt       |   1 +
 .../bindings/power/supply/axp20x_usb_power.txt     |   1 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi          |  15 +++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   8 ++
 drivers/iio/adc/axp20x_adc.c                       | 114 ++++++++++++++++++++-
 drivers/mfd/axp20x.c                               |  11 ++
 drivers/power/supply/axp20x_battery.c              |  88 ++++++++++++++--
 7 files changed, 226 insertions(+), 12 deletions(-)

-- 
2.13.5
