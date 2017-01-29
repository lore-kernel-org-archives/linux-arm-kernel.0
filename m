From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 29 Jan 2017 10:33:21 +0800
Subject: [PATCH v3 00/10] Allwinner H5 and Orange Pi PC2 support
Message-ID: <20170129023331.62106-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H5 is a 64-bit SoC with a design like the 32-bit
H3.

This patchset adds support for it, along with the first available
board -- Orange Pi PC2.

Some drivers are also enabled to be built on ARM64 ARCH_SUNXI
platform, in order to make the internal audio codec work.

Andre Przywara (3):
  arm: dts: sun8i: split Allwinner H3 .dtsi
  arm64: dts: allwinner: add Allwinner H5 .dtsi
  arm64: dts: sunxi: add support for the Orange Pi PC 2 board

Icenowy Zheng (7):
  drivers: pinctrl: add driver for Allwinner H5 SoC
  arm64: allwinner: Kconfig: add essential pinctrl driver for H5
  clk: sunxi-ng: rename sun8i-h3 driver to sunxi-h3-h5
  clk: sunxi-ng: add support for Allwinner H5 SoC
  clk: sunxi-ng: remove transitional headers for dt-bindings
  dmaengine: sun6i: allow build on ARM64 platforms (sun50i)
  ASoC: sunxi: allow the analog codec driver to be built on ARM64

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 571 ++-------------------
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 557 ++++++++++++++++++++
 arch/arm64/Kconfig.platforms                       |   5 +-
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 164 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 139 +++++
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi     |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   6 +-
 drivers/clk/sunxi-ng/Makefile                      |   2 +-
 .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} | 179 ++++++-
 .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  15 +-
 drivers/dma/Kconfig                                |   2 +-
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c          | 558 ++++++++++++++++++++
 .../clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 .../reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 sound/soc/sunxi/Kconfig                            |   2 +-
 20 files changed, 1662 insertions(+), 569 deletions(-)
 create mode 100644 arch/arm/boot/dts/sunxi-h3-h5.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (80%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (82%)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c
 rename include/dt-bindings/clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (95%)
 rename include/dt-bindings/reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (94%)

-- 
2.11.0
