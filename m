From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Oct 2011 11:23:17 +0100
Subject: [GIT PULL] genirq support for GIC PPIs
Message-ID: <4E9FF695.10604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the following branch to get the genirq support for the GIC
PPIs.

Thanks,

	M.

The following changes since commit 5a567d78c437e3be1c512734cdfe64b4ae6b82d7:
  Jamie Iles (1):
        ARM: 7115/4: move __exception and friends to asm/exception.h

are available in the git repository at:

  git://github.com/mzyngier/arm-platforms.git ppi-for-rmk

Marc Zyngier (4):
      genirq: Add support for per-cpu dev_id interrupts
      genirq: percpu: allow interrupt type to be set at enable time
      ARM: gic: consolidate PPI handling
      ARM: gic, local timers: use the request_percpu_irq() interface

Thomas Gleixner (1):
      genirq: Fix fatfinered fixup really

 arch/arm/common/gic.c                             |   43 +++-
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   19 +--
 arch/arm/include/asm/hardware/gic.h               |    1 -
 arch/arm/include/asm/localtimer.h                 |   23 +--
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/irq.c                             |    3 -
 arch/arm/kernel/smp.c                             |   38 +----
 arch/arm/kernel/smp_twd.c                         |   47 +++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |    7 +-
 arch/arm/mach-exynos4/mct.c                       |    7 +-
 arch/arm/mach-msm/board-msm8x60.c                 |   11 -
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +-------
 arch/arm/mach-msm/timer.c                         |   69 ++++---
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 include/linux/interrupt.h                         |   38 +++-
 include/linux/irq.h                               |   16 ++-
 include/linux/irqdesc.h                           |    1 +
 kernel/irq/chip.c                                 |   64 ++++++-
 kernel/irq/internals.h                            |   19 ++-
 kernel/irq/irqdesc.c                              |   32 +++-
 kernel/irq/manage.c                               |  215 ++++++++++++++++++++-
 kernel/irq/settings.h                             |    7 +
 27 files changed, 496 insertions(+), 274 deletions(-)

-- 
Jazz is not dead. It just smells funny...
