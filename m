From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 29 Apr 2012 00:02:33 +0800
Subject: [PATCH v2 0/8] common clk support for mxs
Message-ID: <1335628961-1340-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 * Follow imx way to save clk pointer returned by registration in an
   array and ease the error checking and references to these clk
   pointers later.
 * Add global locking to protect register access.

Shawn Guo (8):
  clk: mxs: add mxs specific clocks
  clk: mxs: add clock support for imx23
  clk: mxs: add clock support for imx28
  ARM: mxs: request clock for timer
  ARM: mxs: change the lookup name for fec phy clock
  ARM: mxs: switch to common clk framework
  ARM: mxs: remove old clock support
  ARM: mxs: remove now unused timer_clk argument from mxs_timer_init

 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mxs/Makefile              |    5 +-
 arch/arm/mach-mxs/clock-mx23.c          |  536 ---------------------
 arch/arm/mach-mxs/clock-mx28.c          |  803 -------------------------------
 arch/arm/mach-mxs/clock.c               |  211 --------
 arch/arm/mach-mxs/include/mach/clock.h  |   62 ---
 arch/arm/mach-mxs/include/mach/common.h |    6 +-
 arch/arm/mach-mxs/mach-mx28evk.c        |    2 +-
 arch/arm/mach-mxs/regs-clkctrl-mx23.h   |  331 -------------
 arch/arm/mach-mxs/regs-clkctrl-mx28.h   |  486 -------------------
 arch/arm/mach-mxs/system.c              |   16 -
 arch/arm/mach-mxs/timer.c               |   11 +-
 drivers/clk/Makefile                    |    2 +
 drivers/clk/mxs/Makefile                |    8 +
 drivers/clk/mxs/clk-div.c               |  103 ++++
 drivers/clk/mxs/clk-frac.c              |  132 +++++
 drivers/clk/mxs/clk-imx23.c             |  204 ++++++++
 drivers/clk/mxs/clk-imx28.c             |  328 +++++++++++++
 drivers/clk/mxs/clk-pll.c               |  109 +++++
 drivers/clk/mxs/clk-ref.c               |  147 ++++++
 drivers/clk/mxs/clk.c                   |   28 ++
 drivers/clk/mxs/clk.h                   |   66 +++
 22 files changed, 1141 insertions(+), 2456 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/clock-mx23.c
 delete mode 100644 arch/arm/mach-mxs/clock-mx28.c
 delete mode 100644 arch/arm/mach-mxs/clock.c
 delete mode 100644 arch/arm/mach-mxs/include/mach/clock.h
 delete mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx23.h
 delete mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx28.h
 create mode 100644 drivers/clk/mxs/Makefile
 create mode 100644 drivers/clk/mxs/clk-div.c
 create mode 100644 drivers/clk/mxs/clk-frac.c
 create mode 100644 drivers/clk/mxs/clk-imx23.c
 create mode 100644 drivers/clk/mxs/clk-imx28.c
 create mode 100644 drivers/clk/mxs/clk-pll.c
 create mode 100644 drivers/clk/mxs/clk-ref.c
 create mode 100644 drivers/clk/mxs/clk.c
 create mode 100644 drivers/clk/mxs/clk.h

-- 
1.7.5.4
