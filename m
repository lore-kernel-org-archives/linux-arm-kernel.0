From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 20 Nov 2015 16:42:26 +0800
Subject: [PATCH v2 0/6] Add Marvell berlin4ct clk support
Message-ID: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add berlin4ct clk driver. The berlin4ct SoC contains:

two kinds of PLL: normal PLL and AVPLL. The normal PLL support is done.
The AVPLL support is in TODO list.

two kinds of clk: normal clk and gate clk. The normal clk supports changing
divider, selecting clock source, disabling/enabling etc. The gate clk only
supports disabling/enabling. Both are supported in this series.

Since v1:
 - rebased on v4.4-rc1
 - refactor out common code from clk-berlin4ct.c
 - s/lock/berlin4ct_gateclk_lock
 - drop WARN_ON for an allocation failure
 - s/kzalloc/kcalloc
 - add necessary handling in error code path, such as free memory, iounmap etc.
 - initialize init.flags
 - drop vcodiv_berlin[] array


Jisheng Zhang (6):
  clk: berlin: add common pll driver
  clk: berlin: add common clk driver for newer SoCs
  clk: berlin: add common gateclk driver for newer SoCs
  clk: berlin: add clk support for berlin4ct
  dt-bindings: add binding for marvell berlin4ct SoC
  arm64: dts: berlin4ct: add pll and clock nodes

 .../bindings/clock/marvell,berlin4ct.txt           |  38 ++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |  38 ++++
 drivers/clk/berlin/Makefile                        |   1 +
 drivers/clk/berlin/clk-berlin4ct.c                 |  97 ++++++++++
 drivers/clk/berlin/clk.c                           | 203 +++++++++++++++++++++
 drivers/clk/berlin/clk.h                           |  45 +++++
 drivers/clk/berlin/gate.c                          |  73 ++++++++
 drivers/clk/berlin/pll.c                           | 133 ++++++++++++++
 include/dt-bindings/clock/berlin4ct.h              |  56 ++++++
 9 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin4ct.txt
 create mode 100644 drivers/clk/berlin/clk-berlin4ct.c
 create mode 100644 drivers/clk/berlin/clk.c
 create mode 100644 drivers/clk/berlin/clk.h
 create mode 100644 drivers/clk/berlin/gate.c
 create mode 100644 drivers/clk/berlin/pll.c
 create mode 100644 include/dt-bindings/clock/berlin4ct.h

-- 
2.6.2
