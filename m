From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  8 Feb 2017 02:30:33 +0800
Subject: [PATCH v4 0/9] Allwinner H5 and Orange Pi PC2 support
Message-ID: <20170207183042.62699-1-icenowy@aosc.xyz>
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

Icenowy Zheng (6):
  arm64: allwinner: Kconfig: add essential pinctrl driver for H5
  clk: sunxi-ng: rename sun8i-h3 driver to sunxi-h3-h5
  clk: sunxi-ng: add support for Allwinner H5 SoC
  ARM: dts: sun8i: convert H3 dtsi to use new sunxi-h3-h5 binding header
  dt-bindings: remove transitional headers for Allwinner H3 CCU
  ASoC: sunxi: allow the analog codec driver to be built on ARM64

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 789 ++++-----------------
 .../boot/dts/{sun8i-h3.dtsi => sunxi-h3-h5.dtsi}   |  91 +--
 arch/arm64/Kconfig.platforms                       |   5 +-
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 164 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 139 ++++
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi     |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   6 +-
 drivers/clk/sunxi-ng/Makefile                      |   2 +-
 .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} | 236 +++++-
 .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  15 +-
 .../clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 .../reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 sound/soc/sunxi/Kconfig                            |   2 +-
 15 files changed, 709 insertions(+), 765 deletions(-)
 rewrite arch/arm/boot/dts/sun8i-h3.dtsi (81%)
 copy arch/arm/boot/dts/{sun8i-h3.dtsi => sunxi-h3-h5.dtsi} (88%)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (76%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (82%)
 rename include/dt-bindings/clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (95%)
 rename include/dt-bindings/reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (94%)

-- 
2.11.0
