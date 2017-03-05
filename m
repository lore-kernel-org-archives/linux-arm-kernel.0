From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon,  6 Mar 2017 07:31:32 +0800
Subject: [PATCH v7 0/6] Allwinner H5 and Orange Pi PC2 support
Message-ID: <20170305233138.64574-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H5 is a 64-bit SoC with a design like the 32-bit
H3, and it's pin-to-pin compatible with H3.

This patchset adds support for it, along with the first available
board -- Orange Pi PC2.

Several H5 boards by Sinovoip Banana Pi and FriendlyARM Nano Pi
are coming, so we should get ready for them.

CCU changes are already said to be merged by Maxime Ripard, so
this patchset now contains only device tree patches.

Some cleanups applied to H3 DTSI is extracted to separated commits,
according to the suggestion of Maxime.

This patchset depends on patchset [1] to finally take effect. At
least the patch 1 of that patchset is needed if you want to test
the kernel image -- without it the pinctrl driver won't be built
and the kernel will become unusable without pinctrl.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/490780.html

Andre Przywara (3):
  arm: dts: sun8i: split Allwinner H3 .dtsi
  arm64: dts: allwinner: add Allwinner H5 .dtsi
  arm64: dts: sunxi: add support for the Orange Pi PC 2 board

Icenowy Zheng (3):
  ARM: dts: sun8i: drop skeleton.dtsi inclusion in H3 DTSI
  ARM: dts: sun8i: drop pinctrl-a10.h inclusion for H3 DTSI
  ARM: dts: sun8i: correct the GIC compatible in H3 to gic-400

 arch/arm/boot/dts/sun8i-h3.dtsi                    | 602 ++-------------------
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 586 ++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 163 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 124 +++++
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi     |   1 +
 6 files changed, 915 insertions(+), 562 deletions(-)
 create mode 100644 arch/arm/boot/dts/sunxi-h3-h5.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi

-- 
2.11.1
