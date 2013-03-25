From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Mar 2013 23:17:26 +0800
Subject: [PATCH 0/6] ARM: mxs: timer code cleanup
Message-ID: <1364224652-28332-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series cleans up mxs timer driver and then moves it into
drivers/clocksource.  It moves mxs platform one step toward
multiplatform support.

It's based on arm-soc/clksrc/cleanup.

Shawn Guo (6):
  ARM: mxs: use CLKSRC_OF helper to initialize timer
  ARM: mxs: look up timrot clock from device tree
  ARM: mxs: get timrot base address from device tree
  ARM: mxs: remove cpu_is_mx23() call from timer code
  ARM: mxs: select STMP_DEVICE and use it for timer code
  ARM: mxs: move timer driver into drivers/clocksource

 arch/arm/Kconfig                                   |    2 ++
 arch/arm/boot/dts/imx23.dtsi                       |    1 +
 arch/arm/boot/dts/imx28.dtsi                       |    1 +
 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/include/mach/common.h            |    1 -
 arch/arm/mach-mxs/mach-mxs.c                       |    3 ++
 drivers/clk/mxs/clk-imx23.c                        |    4 ---
 drivers/clk/mxs/clk-imx28.c                        |    3 --
 drivers/clocksource/Makefile                       |    1 +
 .../timer.c => drivers/clocksource/mxs_timer.c     |   36 +++++++++-----------
 10 files changed, 26 insertions(+), 28 deletions(-)
 rename arch/arm/mach-mxs/timer.c => drivers/clocksource/mxs_timer.c (91%)

-- 
1.7.9.5
