From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 31 Mar 2011 10:52:47 +0200
Subject: [PATCH 0/9] mach-ux500: core SoC updates and new PRCMU API
Message-ID: <1301561567-23543-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This patch series updates a number of core platform register files,
differentiates on-SoC IRQs per SoC family, updates the code to
handle all the latest ASICs and makes a massive update of the
PRCMU (Power/Reset/Control/Managament/Unit) interface. It splits
PM-related stuff into its own subdirectory and updates the cpufreq
driver as part of the PRCMU update, so as not to cause regressions.

Linus Walleij (6):
  mach-ux500: rename PRCMU driver per SoC
  mach-ux500: make PRCMU base address dynamic
  mach-ux500: update the DB8500 register file
  mach-ux500: update the DB5500 register file
  mach-ux500: update ASIC version detection
  mach-ux500: create a PM subdirectory

Mattias Nilsson (2):
  mach-ux500: new DB8500 PRCMU firmware API
  mach-ux500: add DB5500 PRCMU interface

Rabin Vincent (1):
  mach-ux500: update SoC and board IRQ handling

 arch/arm/mach-ux500/Kconfig                        |    1 +
 arch/arm/mach-ux500/Makefile                       |    6 +-
 arch/arm/mach-ux500/cpu-db5500.c                   |    2 +
 arch/arm/mach-ux500/cpu-db8500.c                   |    2 +
 arch/arm/mach-ux500/cpu.c                          |    7 +-
 arch/arm/mach-ux500/cpufreq.c                      |  211 --
 arch/arm/mach-ux500/include/mach/db5500-regs.h     |   20 +-
 arch/arm/mach-ux500/include/mach/db8500-regs.h     |   37 +-
 arch/arm/mach-ux500/include/mach/hardware.h        |    1 +
 arch/arm/mach-ux500/include/mach/id.h              |   20 +
 .../mach-ux500/include/mach/irqs-board-mop500.h    |    5 +
 .../arm/mach-ux500/include/mach/irqs-board-u5500.h |   21 +
 arch/arm/mach-ux500/include/mach/irqs-db5500.h     |   27 +
 arch/arm/mach-ux500/include/mach/irqs-db8500.h     |   54 +
 arch/arm/mach-ux500/include/mach/irqs.h            |   46 +-
 arch/arm/mach-ux500/include/mach/prcmu-db5500.h    |   45 +
 arch/arm/mach-ux500/include/mach/prcmu-defs.h      |   30 -
 arch/arm/mach-ux500/include/mach/prcmu-fw-api.h    |  523 +++++
 .../arm/mach-ux500/include/mach/prcmu-fw-defs_v1.h |  467 +++++
 arch/arm/mach-ux500/include/mach/prcmu-regs.h      |   27 +-
 arch/arm/mach-ux500/include/mach/prcmu.h           |   28 -
 arch/arm/mach-ux500/pm/Kconfig                     |    6 +
 arch/arm/mach-ux500/pm/Makefile                    |    4 +
 arch/arm/mach-ux500/pm/cpufreq.c                   |  171 ++
 arch/arm/mach-ux500/prcmu-db5500.c                 |  449 +++++
 arch/arm/mach-ux500/prcmu-db8500.c                 | 2018 ++++++++++++++++++++
 arch/arm/mach-ux500/prcmu-regs-db8500.h            |  162 ++
 arch/arm/mach-ux500/prcmu.c                        |  394 ----
 drivers/mfd/ab8500-i2c.c                           |    2 +-
 29 files changed, 4081 insertions(+), 705 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/cpufreq.c
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs-board-u5500.h
 create mode 100644 arch/arm/mach-ux500/include/mach/prcmu-db5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/prcmu-defs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/prcmu-fw-api.h
 create mode 100644 arch/arm/mach-ux500/include/mach/prcmu-fw-defs_v1.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/prcmu.h
 create mode 100644 arch/arm/mach-ux500/pm/Kconfig
 create mode 100644 arch/arm/mach-ux500/pm/Makefile
 create mode 100644 arch/arm/mach-ux500/pm/cpufreq.c
 create mode 100644 arch/arm/mach-ux500/prcmu-db5500.c
 create mode 100644 arch/arm/mach-ux500/prcmu-db8500.c
 create mode 100644 arch/arm/mach-ux500/prcmu-regs-db8500.h
 delete mode 100644 arch/arm/mach-ux500/prcmu.c

-- 
1.7.3.2
