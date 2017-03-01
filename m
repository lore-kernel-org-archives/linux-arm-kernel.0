From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu,  2 Mar 2017 04:13:38 +0800
Subject: [PATCH v6 0/4] Allwinner H5 and Orange Pi PC2 support
Message-ID: <20170301201342.47583-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H5 is a 64-bit SoC with a design like the 32-bit
H3, and it's pin-to-pin compatible with H3.

This patchset adds support for it, along with the first available
board -- Orange Pi PC2.

Several H5 boards by Sinovoip Banana Pi and FriendlyARM Nano Pi
are coming, so we should get ready for them.

The rename of sun8i-h3-ccu driver is dropped in this version,
according to the recommendation by Maxime Ripard.

This patchset depends on patchset [1] to finally take effect. At
least the patch 1 of that patchset is needed if you want to test
the kernel image -- without it the pinctrl driver won't be built
and the kernel will become unusable without pinctrl.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/490780.html

Andre Przywara (3):
  arm: dts: sun8i: split Allwinner H3 .dtsi
  arm64: dts: allwinner: add Allwinner H5 .dtsi
  arm64: dts: sunxi: add support for the Orange Pi PC 2 board

Icenowy Zheng (1):
  clk: sunxi-ng: add Allwinner H5 CCU support for H3 CCU driver

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 602 ++-------------------
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 586 ++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 163 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 124 +++++
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi     |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                | 327 ++++++++++-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |   3 +-
 include/dt-bindings/clock/sun8i-h3-ccu.h           |   5 +-
 include/dt-bindings/reset/sun8i-h3-ccu.h           |   5 +-
 12 files changed, 1247 insertions(+), 573 deletions(-)
 create mode 100644 arch/arm/boot/dts/sunxi-h3-h5.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi

-- 
2.11.1
