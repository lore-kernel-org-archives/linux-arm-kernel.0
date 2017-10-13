From: dlan@gentoo.org (Yixun Lan)
Date: Sat, 14 Oct 2017 07:13:11 +0800
Subject: [PATCH 0/2] Introduce new DT files for Meson-AXG SoC
Message-ID: <20171013231313.22850-1-dlan@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This attempt will try to add new DT files to support Meson-AXG SoC.
Due to the AXG series has new memory layout, we decide to start a new
DT structure without sharing with previous meson-gx.dtsi

1) in the first patch, we try to document the new Meson-AXG bindings
2) in the second patch, we try to bring up a minimal serial console,
so it's capable of running a minimal system (in ramdisk).


Yixun Lan (2):
  dt-bindings: arm: amlogic: Add Meson AXG binding
  arm64: dts: meson-axg: add initial A113D SoC DT support

 Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
 arch/arm64/boot/dts/amlogic/Makefile              |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts    |  22 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 204 ++++++++++++++++++++++
 4 files changed, 233 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg.dtsi

-- 
2.14.1
