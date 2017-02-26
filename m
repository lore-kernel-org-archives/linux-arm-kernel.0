From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 26 Feb 2017 09:19:49 +0800
Subject: [PATCH v5 0/7] Allwinner H5 and Orange Pi PC2 support
Message-ID: <20170226011956.53581-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H5 is a 64-bit SoC with a design like the 32-bit
H3.

This patchset adds support for it, along with the first available
board -- Orange Pi PC2.

Andre Przywara (3):
  arm: dts: sun8i: split Allwinner H3 .dtsi
  arm64: dts: allwinner: add Allwinner H5 .dtsi
  arm64: dts: sunxi: add support for the Orange Pi PC 2 board

Icenowy Zheng (4):
  arm64: allwinner: Kconfig: add essential pinctrl driver for H5
  clk: sunxi-ng: rename sun8i-h3 driver to sunxi-h3-h5
  clk: sunxi-ng: add support for Allwinner H5 SoC
  ARM: dts: sun8i: convert H3 dtsi to use new sunxi-h3-h5 binding header

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 589 ++-------------------
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 575 ++++++++++++++++++++
 arch/arm64/Kconfig.platforms                       |   5 +-
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 164 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 139 +++++
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi     |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   6 +-
 drivers/clk/sunxi-ng/Makefile                      |   2 +-
 .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} | 339 +++++++++++-
 .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  13 +-
 .../clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 .../reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 14 files changed, 1277 insertions(+), 580 deletions(-)
 create mode 100644 arch/arm/boot/dts/sunxi-h3-h5.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (71%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (83%)
 rename include/dt-bindings/clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (95%)
 rename include/dt-bindings/reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (94%)

-- 
2.11.1
