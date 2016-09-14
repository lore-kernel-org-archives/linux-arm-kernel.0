From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 14 Sep 2016 12:06:04 +0200
Subject: [PATCH 0/4] ARM: amlogic: add i2c support to Amlogic's gxbb family
Message-ID: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the meson i2c controller found on the gxbb SoC family
This patchset adds 1 i2c in the AO domain and 3 in the EE domain (A,B,C).
There is 1 last i2c in the EE domain (D) but it is actually not connected
to the pad of the SoC, so there is no point in adding it here.

Patches for the i2c [0] driver and pinctrl [1] have been sent in
dedicated series

[0]: http://lkml.kernel.org/r/1473846557-18123-1-git-send-email-jbrunet at baylibre.com
[1]: http://lkml.kernel.org/r/1473846328-17339-1-git-send-email-jbrunet at baylibre.com

Jerome Brunet (3):
  clk: gxbb: expose i2c clocks
  ARM64: dts: meson-gxbb: add pins for I2C
  ARM64: dts: gxbb: add i2c bus

Neil Armstrong (1):
  ARM64: dts: meson-gxbb: add I2C nodes

 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  6 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |  6 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 72 ++++++++++++++++++++++
 drivers/clk/meson/gxbb.h                           |  4 +-
 include/dt-bindings/clock/gxbb-clkc.h              |  2 +
 5 files changed, 88 insertions(+), 2 deletions(-)

-- 
2.7.4
