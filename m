From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun, 18 Nov 2018 14:50:21 +0100
Subject: [PATCH v3 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
Message-ID: <20181118135024.30720-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clocks frequencies.
The precision is determined by stepping into the duration until the counter
overflows.
The debugfs shows a pretty summary and each clock can be measured
individually aswell.

This patchset includes the dt-bindings, driver and the DT node added to the
meson-gx dtsi.

Changes since v2 at [2]:
- Removed all reference to GX
- Added compatibles for meson8/meson8b
- Used Martin's suggestions on the divider naming
- Added Martin's meson8/meson8b clk id table
- Added Martin's fixes to support 32bit SoCs

Changes since v1 at [1]:
- fixed clock names
- added summary in debugfs and moved indivudual clocks into a subdirectory
- added the GX table to the match data

[1] https://lkml.kernel.org/r/1530624110-4687-1-git-send-email-narmstrong at baylibre.com
[2] https://lkml.kernel.org/r/20181114131627.17766-1-narmstrong at baylibre.com

Neil Armstrong (3):
  dt-bindings: amlogic: Add Internal Clock Measurer bindings
  soc: amlogic: Add Meson Clock Measure driver
  ARM64: dts: meson-gx: Add Internal Clock Measurer node

 .../bindings/soc/amlogic/clk-measure.txt      |  18 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   5 +
 drivers/soc/amlogic/Kconfig                   |   8 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-clk-measure.c       | 350 ++++++++++++++++++
 5 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/soc/amlogic/meson-clk-measure.c

-- 
2.19.1
