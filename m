From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  3 Sep 2014 12:52:16 +0200
Subject: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
Message-ID: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset has a bit of a history and some parts of it has been posted
earlier.
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html

The intent is to simplify code for the generic power domain and also some of
the machine specific code that uses the generic power domain.

Do note, there are dependencies through this patchset, especially related to
the ARM SoC changes, thus they all need to be kept together.

Ulf Hansson (15):
  PM / Domains: Remove the pm_genpd_add|remove_callbacks APIs
  PM / Domains: Ignore callbacks for subsys generic_pm_domain_data
  PM / Domains: Remove system PM callbacks from gpd_dev_ops
  ARM: shmobile: Drop dev_irq_safe from r8a7779 genpd config
  ARM: shmobile: Drop dev_irq_safe from R-mobile genpd config
  PM / Domains: Remove dev_irq_safe from genpd config
  PM / Domains: Remove redundant check for CONFIG_PM
  PM / Domains: Remove pm_genpd_syscore_switch() API
  PM / Domains: Remove genpd_queue_power_off_work() API
  PM / Domains: Add late_initcall to disable unused PM domains
  ARM: exynos: Leave disabling of unused PM domains to genpd
  ARM: s3c64xx: Leave disabling of unused PM domains to genpd
  drivers: sh: Leave disabling of unused PM domains to genpd
  PM / Domains: Remove default_stop_ok() API
  PM / Domains: Keep declaration of dev_power_governors together

 arch/arm/mach-exynos/exynos.c         |   1 -
 arch/arm/mach-s3c64xx/common.c        |   5 -
 arch/arm/mach-s3c64xx/common.h        |   7 -
 arch/arm/mach-s3c64xx/mach-anw6410.c  |   1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c |   1 -
 arch/arm/mach-s3c64xx/mach-hmt.c      |   1 -
 arch/arm/mach-s3c64xx/mach-mini6410.c |   1 -
 arch/arm/mach-s3c64xx/mach-ncp.c      |   1 -
 arch/arm/mach-s3c64xx/mach-real6410.c |   1 -
 arch/arm/mach-s3c64xx/mach-smartq5.c  |   1 -
 arch/arm/mach-s3c64xx/mach-smartq7.c  |   1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c |   1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   1 -
 arch/arm/mach-s3c64xx/pm.c            |   7 -
 arch/arm/mach-shmobile/pm-r8a7779.c   |   1 -
 arch/arm/mach-shmobile/pm-rmobile.c   |   1 -
 drivers/base/power/domain.c           | 322 ++++------------------------------
 drivers/base/power/domain_governor.c  |   7 +-
 drivers/sh/pm_runtime.c               |  11 --
 include/linux/pm_domain.h             |  56 +-----
 20 files changed, 40 insertions(+), 388 deletions(-)

-- 
1.9.1
