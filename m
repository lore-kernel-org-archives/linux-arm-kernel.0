From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 30 Apr 2013 16:57:57 -0700
Subject: [PATCH 0/7] Zynq: revised CCF code
Message-ID: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a first shot a revised version of Zynq's CCF code.
This should model the whole clock tree and support clock gating for all
relevant clocks.

This follows Tegra and other ARM SOCs in containing the clock tree
within a single block, which in this case is simply named clock
controller.

The patch is based on the current Linus tree + armsoc/zynq/smp. A
branch for testing is available on github:
https://github.com/sorenb-xlnx/linux-xlnx/tree/zynq/clkc

ps: I hope this thread comes through fine. Corporate email is unwilling
to cooperate and I have to jump through some hoops. My testmail went
through fine though.

	S?ren

Soren Brinkmann (7):
  tty: xuartps: Sort #includes alphabetically
  tty: xuartps: Remove suspend/resume functions
  clocksource/cadence_ttc: Sort #includes alphabetically
  clk: zynq: Factor out PLL driver
  clk: zynq: Add clock controller driver
  arm: zynq: Migrate platform to clock controller
  clk: zynq: Remove deprecated clock code

 .../devicetree/bindings/clock/zynq-7000.txt        | 127 +++--
 arch/arm/boot/dts/zynq-7000.dtsi                   |  71 +--
 arch/arm/boot/dts/zynq-zc702.dts                   |   4 -
 arch/arm/mach-zynq/slcr.c                          |   2 +-
 drivers/clk/Makefile                               |   2 +-
 drivers/clk/clk-zynq.c                             | 378 ---------------
 drivers/clk/zynq/Makefile                          |   3 +
 drivers/clk/zynq/clkc.c                            | 533 +++++++++++++++++++++
 drivers/clk/zynq/pll.c                             | 235 +++++++++
 drivers/clocksource/cadence_ttc_timer.c            |  27 +-
 drivers/tty/serial/xilinx_uartps.c                 | 127 ++---
 include/linux/clk/zynq.h                           |   8 +-
 12 files changed, 982 insertions(+), 535 deletions(-)
 delete mode 100644 drivers/clk/clk-zynq.c
 create mode 100644 drivers/clk/zynq/Makefile
 create mode 100644 drivers/clk/zynq/clkc.c
 create mode 100644 drivers/clk/zynq/pll.c

-- 
1.8.2.2
