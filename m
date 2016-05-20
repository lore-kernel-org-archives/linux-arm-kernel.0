From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 10:27:52 +0200
Subject: [PATCH 0/3] Amlogic: GXBB: Add reset controller
Message-ID: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patchset to add and enable the reset controller driver on GXBB platforms.

This reset controller has up to 256 reset lines with reset pulse generation only,
so the assert and deassert calls are not available.

Changes since the RFC at http://lkml.kernel.org/r/1463148012-25988-1-git-send-email-narmstrong at baylibre.com :
- Fix register mapping and bit defines in bindings header
- Remove assert and unassert calls
- Fix missing __iomem

Neil Armstrong (3):
  reset: Add support for the Amlogic Meson GXBB Reset Controller
  dt-bindings: reset: Add bindings for the Meson GXBB Reset Controller
  ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms

 .../bindings/reset/amlogic,meson-gxbb-reset.txt    |  18 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson-gxbb.c                   | 129 +++++++++++++
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   | 199 +++++++++++++++++++++
 6 files changed, 359 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-gxbb-reset.txt
 create mode 100644 drivers/reset/reset-meson-gxbb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h

-- 
2.7.0
