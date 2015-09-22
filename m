From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Sep 2015 22:12:31 +0800
Subject: [PATCH 0/5] Add Marvell berlin4ct clk support
Message-ID: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add berlin4ct clk driver. The berlin4ct SoC contains:

two kinds of PLL: normal PLL and AVPLL. The normal PLL support is done.
The AVPLL support is in TODO list.

two kinds of clk: normal clk and gate clk. The normal clk supports changing
divider, selecting clock source, disabling/enabling etc. The gate clk only
supports disabling/enabling. Both are supported in this series.

Jisheng Zhang (5):
  clk: berlin: add common pll driver
  clk: berlin: add common clk driver for newer SoCs
  clk: berlin: add clk support for berlin4ct
  dt-bindings: add binding for marvell berlin4ct SoC
  arm64: dts: berlin4ct: add pll and clock nodes

 .../bindings/clock/marvell,berlin4ct.txt           |  38 +++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |  38 +++++
 drivers/clk/berlin/Makefile                        |   2 +-
 drivers/clk/berlin/clk-berlin4ct.c                 | 164 +++++++++++++++++++++
 drivers/clk/berlin/clk.c                           | 147 ++++++++++++++++++
 drivers/clk/berlin/clk.h                           |  38 +++++
 drivers/clk/berlin/pll.c                           | 119 +++++++++++++++
 include/dt-bindings/clock/berlin4ct.h              |  56 +++++++
 8 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin4ct.txt
 create mode 100644 drivers/clk/berlin/clk-berlin4ct.c
 create mode 100644 drivers/clk/berlin/clk.c
 create mode 100644 drivers/clk/berlin/clk.h
 create mode 100644 drivers/clk/berlin/pll.c
 create mode 100644 include/dt-bindings/clock/berlin4ct.h

-- 
2.5.3
