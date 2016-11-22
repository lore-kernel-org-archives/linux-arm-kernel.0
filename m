From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 22 Nov 2016 11:00:44 +0100
Subject: [PATCH v2 0/2] ARM64: dts: Add support for Meson GXM
Message-ID: <20161122100046.25899-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new Amlogic GXM SoC (S912) is part of the Meson GX family and is nearly
identical to GXM but with a second Quad-A53 core cluster.

The GXM dtsi includes the GXL dtsi and the p20x dtsi is refactored in a
common p20x/q20x to support the GXM Q200 and Q201 board that uses the exact
same board layout since the S905D and S912 are pinout compatible.

The last patch adds support for the Nexbox A1 Set-Top-Box based on the S912.

Changes since v1 at [1] :
 - Remove bad p200/p201 changes
 - Fix cpu-map

Changes since RFC :
 - Refactor the p20x/q20x dtsi into a single common file
 - Add support for Nexbox A1

[1] http://lkml.kernel.org/r/20161121162905.14285-1-narmstrong at baylibre.com

Neil Armstrong (2):
  ARM64: dts: Add support for Meson GXM
  ARM64: dts: meson-gxm: Add support for the Nexbox A1

 Documentation/devicetree/bindings/arm/amlogic.txt  |   7 +
 arch/arm64/boot/dts/amlogic/Makefile               |   3 +
 ...gxl-s905d-p23x.dtsi => meson-gx-p23x-q20x.dtsi} |   4 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |   3 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |   3 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 169 +++++++++++++++++++++
 .../arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts |  77 ++++++++++
 .../arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts |  58 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         | 114 ++++++++++++++
 9 files changed, 435 insertions(+), 3 deletions(-)
 rename arch/arm64/boot/dts/amlogic/{meson-gxl-s905d-p23x.dtsi => meson-gx-p23x-q20x.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi

-- 
2.7.0
