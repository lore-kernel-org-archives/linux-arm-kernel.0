From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 13 May 2013 10:46:34 -0700
Subject: [PATCH v2 0/5] Zynq: revised CCF code
Message-ID: <1368467199-8702-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I rebased this series on v3.10-rc1 eliminating all dependencies and incorporated
Greg's feedback.
I'll push this also to my github repository.
https://github.com/sorenb-xlnx/linux-xlnx/tree/zynq/clkc

v2:
 - dropped the 'sort #includes' patches

	S?ren


Soren Brinkmann (5):
  tty: xuartps: Remove suspend/resume functions
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
 drivers/clocksource/cadence_ttc_timer.c            |  23 +-
 drivers/tty/serial/xilinx_uartps.c                 | 115 +++--
 include/linux/clk/zynq.h                           |   8 +-
 12 files changed, 974 insertions(+), 527 deletions(-)
 delete mode 100644 drivers/clk/clk-zynq.c
 create mode 100644 drivers/clk/zynq/Makefile
 create mode 100644 drivers/clk/zynq/clkc.c
 create mode 100644 drivers/clk/zynq/pll.c

-- 
1.8.2.3
