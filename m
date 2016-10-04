From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  4 Oct 2016 17:37:07 +0200
Subject: [RESEND PATCH v2 -next 0/3] ARM64: amlogic: Add support for GXL SoC
 Family
Message-ID: <1475595430-30075-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend rebased on linux-next-20161004 tag.

The new Amlogic GXL SoCs (S905X and S905D) are part of the Meson GX family and
share some common features that can be described in a common GX dtsi file used
by the Meson GXBB and Meson GXL Family dtsi.

This patchset introduces the common GX dtsi and switches the GXBB to use
the common GX dtsi.
Then it introduces the GXL S905X SoC with the GXL common dtsi, then the S905D
dtsi and the p212 board dts.
Finally the GXL S905D SoC is introduced with a S905D dtsi using the GXL common
and the p23x Board dtsi for the p231 and p230 development boards.

Changes since v1 at http://lkml.kernel.org/r/20160903082227.30559-1-narmstrong at baylibre.com :
 - Add missing copyrigh in gx dtsi
 - Rename gxl SoCs compatibles to amlogic,s905x and amlogic,s905d

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

 Documentation/devicetree/bindings/arm/amlogic.txt  |  11 +
 arch/arm64/boot/dts/amlogic/Makefile               |   3 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 200 +++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 895 +++++++++------------
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |  51 ++
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |  51 ++
 .../boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi     |  63 ++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi   |  48 ++
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  69 ++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |  48 ++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  48 ++
 11 files changed, 971 insertions(+), 516 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi

-- 
1.9.1
