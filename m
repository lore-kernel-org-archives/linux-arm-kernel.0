From: boyko.lee@samsung.com (Jongpill Lee)
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.135.1316074182.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.139.1316181028.20020.linux-arm-kernel@lists.infradead.org>

- General tidy-up after Thomas' review. I've kept the config option
  for the time being until we can sort out the anonymous union
  problem.

Marc Zyngier (3):
  genirq: add support for per-cpu dev_id interrupts
  ARM: gic: consolidate PPI handling
  ARM: gic, local timers: use the request_percpu_irq() interface

 arch/arm/common/Kconfig                           |    1 +
 arch/arm/common/gic.c                             |   38 +++-
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   19 +--
 arch/arm/include/asm/hardware/gic.h               |    1 -
 arch/arm/include/asm/localtimer.h                 |   19 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   33 +---
 arch/arm/kernel/smp_twd.c                         |   47 +++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |    6 +-
 arch/arm/mach-exynos4/mct.c                       |    5 -
 arch/arm/mach-msm/board-msm8x60.c                 |   11 -
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-------
 arch/arm/mach-msm/timer.c                         |   69 ++++---
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 include/linux/interrupt.h                         |   40 +++-
 include/linux/irq.h                               |   16 ++-
 include/linux/irqdesc.h                           |    1 +
 kernel/irq/Kconfig                                |    4 +
 kernel/irq/chip.c                                 |   54 ++++++
 kernel/irq/internals.h                            |    2 +
 kernel/irq/irqdesc.c                              |   25 +++
 kernel/irq/manage.c                               |  209 +++++++++++++++++=
+++-
 kernel/irq/settings.h                             |    7 +
 29 files changed, 471 insertions(+), 249 deletions(-)
