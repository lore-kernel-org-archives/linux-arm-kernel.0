From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat,  3 Sep 2016 10:22:23 +0200
Subject: [PATCH 0/3] ARM64: amlogic: Add support for GXL SoC Family
Message-ID: <20160903082227.30559-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new Amlogic GXL SoCs (S905X and S905D) are part of the Meson GX family and
share some common features that can be described in a common GX dtsi file used
by the Meson GXBB and Meson GXL Family dtsi.

This patchset introduces the common GX dtsi and switches the GXBB to use
the common GX dtsi.
Then it introduces the GXL S905X SoC with the GXL common dtsi, then the S905D
dtsi and the p212 board dts.
Finally the GXL S905D SoC is introduced with a S905D dtsi using the GXL common
and the p23x Board dtsi for the p231 and p230 development boards.

Changes since RFC v1:
 - Merge GX common and GXBB changes in a single patch
 - Integrate GXL S905X patch
 - Add support for S905D and the p23x boards

Note: This patchset integrates the patch "ARM64: dts: amlogic: Add basic support for Amlogic S905X" [1]
from Carlo Caione.

[1] http://lkml.kernel.org/r/1472382113-10754-1-git-send-email-carlo at caione.org

Carlo Caione (1):
  ARM64: dts: amlogic: Add basic support for Amlogic S905X

Neil Armstrong (2):
  ARM64: dts: amlogic: Add Meson GX dtsi from GXBB
  ARM64: dts: amlogic: Add basic support for Amlogic S905D

 Documentation/devicetree/bindings/arm/amlogic.txt  |   8 +
 arch/arm64/boot/dts/amlogic/Makefile               |   3 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 181 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 320 +++++++--------------
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |  51 ++++
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |  51 ++++
 .../boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi     |  64 +++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi   |  48 ++++
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  70 +++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |  48 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  48 ++++
 11 files changed, 671 insertions(+), 221 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi

-- 
2.7.0
