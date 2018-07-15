From: sravanhome@gmail.com (Saravanan Sekar)
Date: Sun, 15 Jul 2018 22:01:46 +0200
Subject: [PATCH v5 0/5] Add clock driver for Actions S700 SoC
Message-ID: <20180715200151.10416-1-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds clock support for Actions Semi Owl series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Changelog v5:
- Commit message corrections
- Removed MMC_OWL_CLK_NANDPLL option, as no active consumer
- Device tree clock label name correction

Changelog v4:
- dt-bindings use absolute numbering for clocks
- Patch re-oredering

Changelog v3:
- Splitted uart clock DTS changes into separate patch
- Splitted REGMAP Kconfig selection into separate patch
- General naming convention as "Actions Semi" in dt-binding documentation
- Patch re-oredering
- Cleanup and fixed review findings

Changelog v2:
Fixed 0 day compilation warning
Modified existing dts Actions S900 clock bindings common to Actions
Soc family


Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (5):
  clk: actions: Fix the missing REGMAP_MMIO dependency
  dt-bindings: clock: Add S700 support for Actions Semi Soc's
  clk: actions: Add S700 SoC clock support
  arm64: dts: actions: Add Clock Management Unit for S700
  arm64: dts: actions: Set UART clock reference from CMU

 ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +-
 .../boot/dts/actions/s700-cubieboard7.dts     |   8 +-
 arch/arm64/boot/dts/actions/s700.dtsi         |  14 +
 drivers/clk/actions/Kconfig                   |   7 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 606 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++
 7 files changed, 758 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (68%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0
