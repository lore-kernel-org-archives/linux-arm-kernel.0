From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Sep 2014 01:54:01 +0900
Subject: [GIT PULL 1/3] 3rd Round for Samsung-cleanup-2 for v3.18
Message-ID: <542448A9.4000702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6361c6b3880063c2248d4e453331e3dc1efbf83:

   ARM: S3C24XX: remove separate restart code (2014-09-14 02:43:09 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-cleanup-2

for you to fetch changes up to 5a1f0c6d3161a37da3a651f80b18febc2e5d7b75:

   ARM: EXYNOS: Fix CPU idle clock down after CPU off (2014-09-14 
02:49:32 +0900)

----------------------------------------------------------------
Samsung 2nd cleanup for v3.18

- Cleanup SMP/hotplug codes from hotplug.c to platsmp.c

- Remove unneeded __ref annotation for exynos_cpu_die()

- Fix the way to power down CPU on exynos4 and CPUidle
   clock down after power down some CPU

----------------------------------------------------------------
Krzysztof Kozlowski (3):
       ARM: EXYNOS: Move code from hotplug.c to platsmp.c
       ARM: EXYNOS: Remove unneeded __ref annotation for cpu_die function
       ARM: EXYNOS: Fix CPU idle clock down after CPU off

  arch/arm/mach-exynos/Makefile   |   3 --
  arch/arm/mach-exynos/common.h   |   2 -
  arch/arm/mach-exynos/hotplug.c  |  91 --------------------------------
  arch/arm/mach-exynos/platsmp.c  | 113 
++++++++++++++++++++++++++++++++++++++++
  arch/arm/mach-exynos/regs-pmu.h |   3 ++
  5 files changed, 116 insertions(+), 96 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/hotplug.c
