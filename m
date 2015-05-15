From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:38 +0800
Subject: [PATCH 0/9] ARM: imx: move timer driver into drivers/clocksource
Message-ID: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The series cleans up i.MX timer driver regarding those cpu_is_xxx()
usage by introducing gpt device type, and then moves the driver into
drivers/clocksource.

Shawn Guo (9):
  ARM: imx: move timer resources into a structure
  ARM: imx: define an enum for gpt timer device type
  ARM: imx: initialize gpt device type for DT boot
  ARM: imx: setup tctl register in device specific function
  ARM: imx: set up set_next_event hook in imx_timer_data_init()
  ARM: imx: define gpt register offset per device type
  ARM: imx: provide gpt device specific irq functions
  ARM: imx: remove platform headers from timer driver
  ARM: imx: move timer driver into drivers/clocksource

 arch/arm/mach-imx/Makefile      |   2 +-
 arch/arm/mach-imx/time.c        | 388 -------------------------------
 drivers/clk/imx/clk-imx1.c      |   3 +-
 drivers/clk/imx/clk-imx21.c     |   3 +-
 drivers/clk/imx/clk-imx27.c     |   3 +-
 drivers/clk/imx/clk-imx31.c     |   3 +-
 drivers/clk/imx/clk-imx35.c     |   3 +-
 drivers/clk/imx/clk.h           |   7 -
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/timer-imx.c | 493 ++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/timer.h         |  26 +++
 11 files changed, 531 insertions(+), 401 deletions(-)
 delete mode 100644 arch/arm/mach-imx/time.c
 create mode 100644 drivers/clocksource/timer-imx.c
 create mode 100644 include/soc/imx/timer.h

-- 
1.9.1
