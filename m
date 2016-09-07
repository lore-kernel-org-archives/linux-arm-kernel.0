From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  7 Sep 2016 17:13:36 +0200
Subject: [PATCH 0/7] ARM: amlogic: Add spifc support to Amlogic's GXBB family
Message-ID: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the necessary pins, clocks and device tree nodes to
enable the spifc controller on the GXBB family. I had to add the nand pins
in pintctrl as the pinmux setting left by u-boot was conflicting with the
spifc pinmux during my test on the P200.

Jerome Brunet (4):
  pinctrl: amlogic: gxbb: add spifc pins
  pinctrl: amlogic: gxbb: add nand pins
  clk: gxbb: expose spifc clock
  ARM64: dts: amlogic: add pins for spifc

Neil Armstrong (3):
  spi: meson: Add GXBB compatible
  dt-bindings: spi-meson: Add GXBB Compatible string
  ARM64: dts: meson-gxbb: Add SPIFC node

 .../devicetree/bindings/spi/spi-meson.txt          |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 19 +++++++++++
 drivers/clk/meson/gxbb.h                           |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         | 37 ++++++++++++++++++++++
 drivers/spi/spi-meson-spifc.c                      |  1 +
 include/dt-bindings/clock/gxbb-clkc.h              |  1 +
 6 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.7.4
