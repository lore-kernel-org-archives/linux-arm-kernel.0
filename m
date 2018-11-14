From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Nov 2018 14:16:24 +0100
Subject: [PATCH v2 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
Message-ID: <20181114131627.17766-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clocks frequencyies.
The precision is determined by stepping into the divider until the counter
overflows.
The debugfs slows a pretty summary and each clock can be measured
individually aswell.

Thsi patchset includes the dt-bindings, driver and the DT node added to the
meson-gx dtsi.

Changes since v1 at [1]:
- fixed clock names
- added summary in debugfs and moved indivudual clocks into a subdirectory
- added the GX table to the match data

Neil Armstrong (3):
  dt-bindings: amlogic: Add Internal Clock Measurer bindings
  soc: amlogic: Add Meson GX Clock Measure driver
  ARM64: dts: meson-gx: Add Internal Clock Measurer node

 .../bindings/soc/amlogic/clk-measure.txt      |  15 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   5 +
 drivers/soc/amlogic/Kconfig                   |   8 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-gx-clk-measure.c    | 293 ++++++++++++++++++
 5 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c

-- 
2.19.1
