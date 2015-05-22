From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:47 +0800
Subject: [PATCH v2 00/12] ARM: imx: move timer driver into drivers/clocksource
Message-ID: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 - Use relaxed IO accessor to replace __raw_xxx version
 - Create imx_gpt_data structure to accommodate gpt device specific data
 - Move clock event related variables into imx_timer structure

Daniel,

If the patch series looks good to you, can you please give your ACK on
the last patch, so that I can send the whole series through IMX tree?
Thanks.

Shawn

Shawn Guo (12):
  ARM: imx: use relaxed IO accessor in timer driver
  ARM: imx: move timer resources into a structure
  ARM: imx: define an enum for gpt timer device type
  ARM: imx: initialize gpt device type for DT boot
  ARM: imx: setup tctl register in device specific function
  ARM: imx: set up .set_next_event hook via imx_gpt_data
  ARM: imx: move clock event variables into imx_timer
  ARM: imx: define gpt register offset per device type
  ARM: imx: get rid of variable timer_base
  ARM: imx: provide gpt device specific irq functions
  ARM: imx: remove platform headers from timer driver
  ARM: imx: move timer driver into drivers/clocksource

 arch/arm/mach-imx/Makefile      |   2 +-
 arch/arm/mach-imx/time.c        | 388 -----------------------------
 drivers/clk/imx/clk-imx1.c      |   3 +-
 drivers/clk/imx/clk-imx21.c     |   3 +-
 drivers/clk/imx/clk-imx27.c     |   3 +-
 drivers/clk/imx/clk-imx31.c     |   3 +-
 drivers/clk/imx/clk-imx35.c     |   3 +-
 drivers/clk/imx/clk.h           |   7 -
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/timer-imx.c | 531 ++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/timer.h         |  26 ++
 11 files changed, 569 insertions(+), 401 deletions(-)
 delete mode 100644 arch/arm/mach-imx/time.c
 create mode 100644 drivers/clocksource/timer-imx.c
 create mode 100644 include/soc/imx/timer.h

-- 
1.9.1
