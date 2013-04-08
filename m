From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 17:00:18 +0800
Subject: [GIT PULL 1/4] ARM: mxs: cleanup for 3.10
Message-ID: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the mxs cleanup material for 3.10.  It's based on clksrc/cleanup
branch in arm-soc tree.  Please pull, thanks.

Shawn

The following changes since commit 3ed628a8122112ee796cd643e2478c4a6def234c:

  Merge remote-tracking branch 'arm-soc/clksrc/cleanup' into mxs/cleanup (2013-04-01 16:29:56 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-cleanup-3.10

for you to fetch changes up to e933a1a12a02f42e0013cda87bba37ccb59efc47:

  clocksource: mxs_timer: Add semicolon at end of line (2013-04-03 10:30:08 +0800)

----------------------------------------------------------------
The mxs cleanup for 3.10:

* Clean up timer code and move it into drivers/clocksource
* Clean up icoll code and move it into drivers/irqchip
* Clean up clock code to not include <mach/*> headers
* Clean up rtc-stmp3xxx, mxs-lradc and mxs-saif to not include <mach/*>
  headers
* Clean up mach-mxs code to get it prepared for multiplatform support

----------------------------------------------------------------
Fabio Estevam (1):
      clocksource: mxs_timer: Add semicolon at end of line

Shawn Guo (25):
      ARM: mxs: use CLKSRC_OF helper to initialize timer
      ARM: mxs: look up timrot clock from device tree
      ARM: mxs: get timrot base address from device tree
      ARM: mxs: remove cpu_is_mx23() call from timer code
      ARM: mxs: select STMP_DEVICE and use it for timer code
      ARM: mxs: move timer driver into drivers/clocksource
      ARM: mxs: get icoll base address from device tree
      ARM: mxs: call stmp_reset_block() in icoll
      ARM: mxs: move icoll driver into drivers/irqchip
      ARM: mxs: remove unneeded mach-types.h inclusion
      clk: mxs: get base address from device tree
      clk: mxs: remove the use of mach level IO accessor
      rtc: stmp3xxx: use stmp_reset_block() instead
      iio: mxs-lradc: remove unneeded mach header inclusion
      ASoC: mxs-saif: remove mach header inclusion
      ARM: mxs: remove empty hardware.h
      ARM: mxs: get reset address from device tree
      ARM: mxs: remove system.c
      ARM: mxs: get ocotp base address from device tree
      ARM: mxs: use debug_ll_io_init for low-level debug
      ARM: mxs: remove mm.c
      ARM: mxs: move mxs_get_ocotp() into mach-mxs.c
      ARM: mxs: remove common.h
      ARM: mxs: merge imx23 and imx28 into one machine_desc
      ARM: mxs: remove unused headers

 arch/arm/Kconfig                                   |    2 +
 arch/arm/boot/dts/imx23.dtsi                       |    5 +-
 arch/arm/boot/dts/imx28.dtsi                       |    5 +-
 arch/arm/mach-mxs/Makefile                         |    4 -
 arch/arm/mach-mxs/include/mach/common.h            |   29 ---
 arch/arm/mach-mxs/include/mach/debug-macro.S       |    9 +-
 arch/arm/mach-mxs/include/mach/digctl.h            |   22 --
 arch/arm/mach-mxs/include/mach/hardware.h          |   23 --
 arch/arm/mach-mxs/include/mach/mx23.h              |  169 ---------------
 arch/arm/mach-mxs/include/mach/mx28.h              |  225 --------------------
 arch/arm/mach-mxs/include/mach/mxs.h               |  117 ----------
 arch/arm/mach-mxs/mach-mxs.c                       |  185 +++++++++++++---
 arch/arm/mach-mxs/mm.c                             |   52 -----
 arch/arm/mach-mxs/ocotp.c                          |   93 --------
 arch/arm/mach-mxs/system.c                         |  139 ------------
 drivers/clk/mxs/clk-imx23.c                        |   42 ++--
 drivers/clk/mxs/clk-imx28.c                        |   42 ++--
 drivers/clocksource/Makefile                       |    1 +
 .../timer.c => drivers/clocksource/mxs_timer.c     |   36 ++--
 drivers/irqchip/Makefile                           |    1 +
 .../mach-mxs/icoll.c => drivers/irqchip/irq-mxs.c  |   24 +--
 drivers/rtc/rtc-stmp3xxx.c                         |    6 +-
 drivers/staging/iio/adc/mxs-lradc.c                |    3 -
 include/linux/clk/mxs.h                            |   16 ++
 include/linux/irqchip/mxs.h                        |   14 ++
 sound/soc/mxs/mxs-saif.c                           |    5 +-
 26 files changed, 279 insertions(+), 990 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/common.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mx23.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mx28.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mxs.h
 delete mode 100644 arch/arm/mach-mxs/mm.c
 delete mode 100644 arch/arm/mach-mxs/ocotp.c
 delete mode 100644 arch/arm/mach-mxs/system.c
 rename arch/arm/mach-mxs/timer.c => drivers/clocksource/mxs_timer.c (91%)
 rename arch/arm/mach-mxs/icoll.c => drivers/irqchip/irq-mxs.c (89%)
 create mode 100644 include/linux/clk/mxs.h
 create mode 100644 include/linux/irqchip/mxs.h
