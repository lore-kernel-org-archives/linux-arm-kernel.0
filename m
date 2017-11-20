From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 20 Nov 2017 22:54:10 +0800
Subject: [PATCH v2 0/5]  i2c: meson-axg: add I2C controller driver
Message-ID: <20171120145415.6581-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set try to add I2C controller driver for
the Amlogic's Meson-AXG SoC.

Changes since v1 [1]
 - update dt-bindings doc (Neil Armstrong)
 - make meson_i2c_data const (Martin Blumenstingl)
 - DTS: adjust naming, change from the 'i2c_m0' to 'i2c0' style

[1] http://lkml.kernel.org/r/20171117080236.32504-1-yixun.lan at amlogic.com

Jian Hu (5):
  dt-bindings: i2c: update documentation for the Meson-AXG
  i2c: meson: add configurable divider factors
  ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
  ARM64: dts: meson-axg: describe pin DT info for I2C controller
  ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker

 .../devicetree/bindings/i2c/i2c-meson.txt          |   6 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   6 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 123 +++++++++++++++++++++
 drivers/i2c/busses/i2c-meson.c                     |  32 +++++-
 4 files changed, 162 insertions(+), 5 deletions(-)

-- 
2.15.0
