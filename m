From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Mon, 15 May 2017 16:34:59 +0800
Subject: [PATCH 0/3] add clock driver for Spreadtrum platforms
Message-ID: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the last cycle, the patches support Whale2 sc9860 mobile chip have been
merged. This patchset adds clock driver which is used on almost all
Spreadtrum SoCs.

This series also adds Spreadtrum clock bindings and SC9860 clock devicetree
data.

This driver has been validated on Spreadtrum SC9860 mobile phone.

Any comments would be greatly appreciated.

Thanks,
Chunyan


Chunyan Zhang (1):
  Documentation: add sprd clock bindings

Xiaolong Zhang (2):
  arm64: dts: add SC9860 clock tree data
  clk: Add common clock driver for Spreadtrum SoCs

 .../clock/sprd/sprd,adjustable-pll-clock.txt       |   17 +
 .../bindings/clock/sprd/sprd,composite-clock.txt   |   28 +
 .../bindings/clock/sprd/sprd,divider-clock.txt     |   24 +
 .../bindings/clock/sprd/sprd,gates-clock.txt       |   73 +
 .../bindings/clock/sprd/sprd,muxed-clock.txt       |   23 +
 arch/arm64/boot/dts/sprd/sc9860-clocks.dtsi        | 1984 ++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sc9860.dtsi               |    1 +
 arch/arm64/boot/dts/sprd/whale2.dtsi               |    7 -
 drivers/clk/Makefile                               |    1 +
 drivers/clk/sprd/Makefile                          |    3 +
 drivers/clk/sprd/clk-gates.c                       |  366 ++++
 drivers/clk/sprd/composite.c                       |  109 ++
 drivers/clk/sprd/divider.c                         |   79 +
 drivers/clk/sprd/mux.c                             |   77 +
 drivers/clk/sprd/pll.c                             |  359 ++++
 drivers/clk/sprd/pll.h                             |   73 +
 drivers/clk/sprd/pll_cfg.h                         |  390 ++++
 17 files changed, 3607 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,divider-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,muxed-clock.txt
 create mode 100644 arch/arm64/boot/dts/sprd/sc9860-clocks.dtsi
 create mode 100644 drivers/clk/sprd/Makefile
 create mode 100644 drivers/clk/sprd/clk-gates.c
 create mode 100644 drivers/clk/sprd/composite.c
 create mode 100644 drivers/clk/sprd/divider.c
 create mode 100644 drivers/clk/sprd/mux.c
 create mode 100644 drivers/clk/sprd/pll.c
 create mode 100644 drivers/clk/sprd/pll.h
 create mode 100644 drivers/clk/sprd/pll_cfg.h

-- 
2.7.4
