From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 21 Mar 2013 12:49:07 +0100
Subject: [PATCH 0/6] ARM: ux500: first multiplatform series
Message-ID: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is the first set in my ux500 multiplatform series.
As you can see it starts out by getting rid of three
files in <mach/*>. It's enough stuff to discuss already,
and relates to my recent question of whether the mailbox
subsystem can be merged into the ARM SoC tree.

Linus Walleij (6):
  ARM: ux500: move debugmacro to debug includes
  clk: ux500: pass clock base adresses in init call
  mfd: prcmu: pass a base and size with the early initcall
  mfd: db8500-prcmu: get base address from resource
  ARM: ux500: move PRCMU functions into the CPUidle driver
  ARM: ux500: get rid of <mach/[hardware|db8500-regs].h>

 arch/arm/Kconfig.debug                         |   8 +
 arch/arm/include/debug/ux500.S                 |  48 ++++++
 arch/arm/mach-ux500/board-mop500-audio.c       |   1 -
 arch/arm/mach-ux500/board-mop500-pins.c        |   2 -
 arch/arm/mach-ux500/board-mop500-sdi.c         |   2 +-
 arch/arm/mach-ux500/board-mop500-uib.c         |   1 -
 arch/arm/mach-ux500/board-mop500.c             |   2 +-
 arch/arm/mach-ux500/cache-l2x0.c               |   2 +-
 arch/arm/mach-ux500/cpu-db8500.c               |   6 +-
 arch/arm/mach-ux500/cpu.c                      |  25 +--
 arch/arm/mach-ux500/cpuidle.c                  | 148 +++++++++++++++++-
 arch/arm/mach-ux500/db8500-regs.h              | 201 ++++++++++++++++++++++++
 arch/arm/mach-ux500/devices-common.c           |   1 -
 arch/arm/mach-ux500/devices-db8500.c           |   8 +-
 arch/arm/mach-ux500/devices-db8500.h           |   1 +
 arch/arm/mach-ux500/devices.c                  |   3 +-
 arch/arm/mach-ux500/id.c                       |   2 +-
 arch/arm/mach-ux500/include/mach/db8500-regs.h | 173 ---------------------
 arch/arm/mach-ux500/include/mach/debug-macro.S |  39 -----
 arch/arm/mach-ux500/include/mach/hardware.h    |  47 ------
 arch/arm/mach-ux500/include/mach/irqs.h        |   2 -
 arch/arm/mach-ux500/include/mach/uncompress.h  |   3 +-
 arch/arm/mach-ux500/platsmp.c                  |   2 +-
 arch/arm/mach-ux500/timer.c                    |   2 +-
 arch/arm/mach-ux500/usb.c                      |   2 +-
 drivers/clk/ux500/clk-prcc.c                   |   1 -
 drivers/clk/ux500/u8500_clk.c                  | 142 ++++++++---------
 drivers/clocksource/clksrc-dbx500-prcmu.c      |   1 -
 drivers/mfd/db8500-prcmu.c                     | 176 +++++----------------
 drivers/mfd/dbx500-prcmu-regs.h                | 204 +++++++++++--------------
 include/linux/mfd/db8500-prcmu.h               |  10 +-
 include/linux/mfd/dbx500-prcmu.h               |  36 +----
 include/linux/platform_data/clk-ux500.h        |   3 +-
 33 files changed, 647 insertions(+), 657 deletions(-)
 create mode 100644 arch/arm/include/debug/ux500.S
 create mode 100644 arch/arm/mach-ux500/db8500-regs.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/db8500-regs.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-ux500/include/mach/hardware.h

-- 
1.7.11.3
