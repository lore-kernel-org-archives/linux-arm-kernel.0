From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 22 Dec 2013 03:23:30 +0900
Subject: [GIT PULL 2nd 2/5] Samsung cleanup for v3.14
Message-ID: <52B5DCA2.6080107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7c394e7be4d267c02eaaac8fa197a7c1b023c99b:

   ARM: EXYNOS: Constify clksrc immutable register restore tables 
(2013-12-12 07:09:33 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-cleanup-2

for you to fetch changes up to 1fd3cbccaf47aefbe3bfb026d310cd2f5d0685c6:

   ARM: EXYNOS: Kill exynos_pm_late_initcall() (2013-12-21 06:40:44 +0900)

----------------------------------------------------------------
Samsung cleanup 2nd for v3.14
- remove <mach/regs-clock.h> for exynos
- remove <mach/regs-irq.h> for exynos
- local <mach/regs-pmu.h> into mach-exynos
- select PM_GENERIC_DOMAINS for ARCH_EXYNOS4
   instead of each SOC_EXYNOS4XXX in Kconfig
- call pm_genpd_poweroff_unused() instead of via
   exynos_pm_late_initcall() because no need to
   handle whether CONFIG_PM_GENERIC_DOMAINS is enalbed

----------------------------------------------------------------
Kukjin Kim (11):
       ARM: EXYNOS: cleanup <mach/regs-pmu.h>
       ARM: EXYNOS: remove inclusion <mach/regs-pmu.h> into another headers
       ARM: EXYNOS: local regs-pmu.h header file
       ARM: EXYNOS: cleanup <mach/regs-irq.h>
       ARM: EXYNOS: cleanup <mach/regs-clock.h>
       PM / devfreq: move definitions for exynos4_bus into drivers/devfreq
       ARM: EXYNOS: local definitions for pm.c into mach-exynos dir
       cpufreq: exynos: move definitions for exynos-cpufreq into 
drivers/cpufreq/
       ARM: EXYNOS: local definitions for cpuidle.c into mach-exynos dir
       ARM: EXYNOS: remove <mach/regs-clock.h> for exynos
       PM / devfreq: use inclusion <mach/map.h> instead of <plat/map-s5p.h>

Sylwester Nawrocki (2):
       ARM: EXYNOS: Consolidate selection of PM_GENERIC_DOMAINS for Exynos4
       ARM: EXYNOS: Kill exynos_pm_late_initcall()

  arch/arm/mach-exynos/Kconfig                       |   4 +-
  arch/arm/mach-exynos/common.c                      |   8 +-
  arch/arm/mach-exynos/common.h                      |   6 -
  arch/arm/mach-exynos/cpuidle.c                     |  25 +-
  arch/arm/mach-exynos/hotplug.c                     |   2 +-
  arch/arm/mach-exynos/include/mach/pm-core.h        |   5 +-
  arch/arm/mach-exynos/include/mach/regs-clock.h     | 372 
---------------------
  arch/arm/mach-exynos/include/mach/regs-irq.h       |  19 --
  arch/arm/mach-exynos/mach-exynos5-dt.c             |   2 +-
  arch/arm/mach-exynos/platsmp.c                     |   3 +-
  arch/arm/mach-exynos/pm.c                          |  29 +-
  arch/arm/mach-exynos/pm_domains.c                  |   9 +-
  arch/arm/mach-exynos/pmu.c                         |   3 +-
  arch/arm/mach-exynos/{include/mach => }/regs-pmu.h |  53 ---
  arch/arm/plat-samsung/pm.c                         |   2 +
  arch/arm/plat-samsung/s5p-irq-pm.c                 |   3 +
  drivers/cpufreq/exynos-cpufreq.h                   |  22 ++
  drivers/cpufreq/exynos4210-cpufreq.c               |   2 -
  drivers/cpufreq/exynos4x12-cpufreq.c               |   2 -
  drivers/cpufreq/exynos5250-cpufreq.c               |   1 -
  drivers/devfreq/exynos/exynos4_bus.c               |   4 +-
  drivers/devfreq/exynos/exynos4_bus.h               | 110 ++++++
  22 files changed, 204 insertions(+), 482 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-clock.h
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-irq.h
  rename arch/arm/mach-exynos/{include/mach => }/regs-pmu.h (88%)
  create mode 100644 drivers/devfreq/exynos/exynos4_bus.h
