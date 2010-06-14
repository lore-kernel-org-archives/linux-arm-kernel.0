From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 14 Jun 2010 17:39:09 +0900
Subject: [PATCH 0/6] S5PV210 PM Support (suspend-to-mem)
Message-ID: <1276504755-24741-1-git-send-email-MyungJoo.Ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set supports S5PV210/S5PC110 PM (suspend-to-mem).

MyungJoo Ham (8):
  S5PV210 Add IRQ/EINT register information for the CPU.
  S5PV210 add clock registers for the CPU.
  S5PV210 added register mappings
  S5PV210 GPIO relataed registers are added.
  S5PV210 added EINT-GPIO register mappings
  S5PV210 PM Support (suspend-to-mem)

 arch/arm/mach-s5pv210/Makefile                  |    4 +
 arch/arm/mach-s5pv210/include/mach/irqs.h       |    9 +
 arch/arm/mach-s5pv210/include/mach/map.h        |   45 +++
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |  467 ++++++++++++++++++++++-
 arch/arm/mach-s5pv210/include/mach/regs-gpio.h  |  121 ++++++
 arch/arm/mach-s5pv210/include/mach/regs-irq.h   |    6 +
 arch/arm/plat-s5p/Makefile                      |    3 +
 arch/arm/plat-s5p/include/plat/gpio-ext.h       |   44 +++
 arch/arm/plat-s5p/include/plat/map-s5p.h        |    1 +
 arch/arm/plat-s5p/sleep.S                       |  248 ++++++++++++
 arch/arm/plat-samsung/include/plat/pm-core.h    |   53 +++
 arch/arm/plat-samsung/include/plat/pm.h         |   13 +
 arch/arm/plat-samsung/pm-gpio.c                 |    4 +-
 arch/arm/plat-samsung/pm.c                      |   75 ++++-
 14 files changed, 1082 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/plat-s5p/include/plat/gpio-ext.h
 create mode 100644 arch/arm/plat-s5p/sleep.S
 create mode 100644 arch/arm/plat-samsung/include/plat/pm-core.h
