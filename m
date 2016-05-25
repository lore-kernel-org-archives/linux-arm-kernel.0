From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 25 May 2016 11:49:14 +0200
Subject: [PATCH v2 0/4] Amlogic: Meson: Add reset controller
Message-ID: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patchset to add and enable the reset controller driver on Meson SoCs platforms.

This reset controller has up to 256 reset lines with reset pulse generation only,
so the assert and deassert calls are not available.

Depends on the patch :
 - "reset: add devm_reset_controller_register API" [1]

Changes since v1 at http://lkml.kernel.org/r/1463732875-23141-1-git-send-email-narmstrong at baylibre.com :
- Remove _gxbb_ in names
- Depends build on ARCH_MESON only
- Add meson8b compatible and bindings
- Re-indent dt-bindings headers
- Switch to devm_ reset controller register
- Remove platform "remove" callback
- Update Dual BSD/GPL file headers

Changes since the RFC at http://lkml.kernel.org/r/1463148012-25988-1-git-send-email-narmstrong at baylibre.com :
- Fix register mapping and bit defines in bindings header
- Remove assert and unassert calls
- Fix missing __iomem

[1] https://patchwork.kernel.org/patch/8988471/

Neil Armstrong (4):
  reset: Add support for the Amlogic Meson SoC Reset Controller
  dt-bindings: reset: Add bindings for the Meson SoC Reset Controller
  ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms
  ARM: dts: amlogic: Enable Reset Controller on Meson8b platforms

 .../bindings/reset/amlogic,meson-reset.txt         |  18 ++
 arch/arm/boot/dts/meson8b.dtsi                     |   7 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson.c                        | 137 ++++++++++++++
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   | 210 +++++++++++++++++++++
 include/dt-bindings/reset/amlogic,meson8b-reset.h  | 175 +++++++++++++++++
 7 files changed, 555 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
 create mode 100644 drivers/reset/reset-meson.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson8b-reset.h

-- 
2.7.0
