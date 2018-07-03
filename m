From: sravanhome@gmail.com (Saravanan Sekar)
Date: Tue,  3 Jul 2018 11:25:19 +0200
Subject: [PATCH v3 0/5] Add clock driver for Actions S700 SoC
Message-ID: <20180703092524.1697111-1-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

This patchset adds clock support for Actions Semi OWL series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (5):
  dt-bindings: clock: Rename document generic to Actions Semi Soc's
  clk: actions: Add S700 SoC clock support
  clk: actions: Add REGMAP as dependency
  arm64: dts: actions: Enable clock controller for S700
  arm64: dts: actions: Set UART clock reference from CMU

 .../{actions,s900-cmu.txt => actions,owl-cmu.txt}  |  20 +-
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |   8 +-
 arch/arm64/boot/dts/actions/s700.dtsi              |  14 +
 drivers/clk/actions/Kconfig                        |  14 +
 drivers/clk/actions/Makefile                       |   1 +
 drivers/clk/actions/owl-s700.c                     | 610 +++++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h       | 128 +++++
 7 files changed, 779 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.14.4
