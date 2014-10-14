From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 15 Oct 2014 08:26:11 +0900
Subject: [GIT PULL 1/2] Samsung fixes for v3.18
Message-ID: <543DB113.1080108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes

for you to fetch changes up to f6f1ae82bd288bceed5a93594a8a081845f11b41:

   ARM: mm: Fix ifdef around cpu_*_do_[suspend, resume] ops (2014-09-24 
02:47:44 +0900)

----------------------------------------------------------------
Samsung fixes for v3.18
- fix ifdef around cpu_*_do_[suspend, resume] ops to check
   CONFIG_ARM_CPU_SUSPEND and not CONFIG_PM_SLEEP
- fix exynos_defconfig build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=n
- fix enabling Samsung PM debug functionality due to recently merged
   patches and previous merge conflicts
- fix pull-up setting in sd4_width8 pin group for exynos4x12

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (2):
       ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=n
       ARM: mm: Fix ifdef around cpu_*_do_[suspend, resume] ops

Tomasz Figa (2):
       ARM: dts: Fix pull setting in sd4_width8 pin group for exynos4x12
       ARM: SAMSUNG: Restore Samsung PM Debug functionality

  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 2 +-
  arch/arm/mach-exynos/exynos.c             | 2 ++
  arch/arm/mm/proc-macros.S                 | 2 +-
  arch/arm/plat-samsung/Kconfig             | 5 +++--
  arch/arm/plat-samsung/pm-debug.c          | 1 +
  5 files changed, 8 insertions(+), 4 deletions(-)
