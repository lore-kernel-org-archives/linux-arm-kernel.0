From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Sep 2014 01:57:23 +0900
Subject: [GIT PULL 3/3] 3rd Round of Exynos-PM-2 Updates for v3.18
Message-ID: <54244973.7090204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c3294253713cbc96df59a7cc6a9a3fc0c4ae5ba7:

   ARM: EXYNOS: Refactor the pm code to use DT based lookup (2014-09-24 
16:45:14 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-pm-2

for you to fetch changes up to cd925eee6acf7c742a896e0d43ad4f4088bb691c:

   ARM: EXYNOS: SWRESET is needed to boot secondary CPU on exynos3250 
(2014-09-25 18:15:13 +0900)

----------------------------------------------------------------
Exynos 2nd PM related updates for v3.18

- Firmware supporting suspend and resume to excute of low
   level operations to enter and leave power mode for exynos
   : introduce suspend() and resume() firmware operations

- Fix AFTR mode on boards with secure firmware enabled and
   allows exynos cpuidle driver usage on exynos4x12 SoCs

- Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y

- SWRESET is needed to boot secondary CPU on exynos3250

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (6):
       ARM: EXYNOS: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
       ARM: firmware: add AFTR mode support to firmware do_idle method
       ARM: EXYNOS: add secure firmware support to AFTR mode code
       ARM: EXYNOS: fix register setup for AFTR mode code
       ARM: EXYNOS: allow driver usage on Exynos4x12 SoCs
       ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y

Krzysztof Kozlowski (1):
       ARM: EXYNOS: SWRESET is needed to boot secondary CPU on exynos3250

Tomasz Figa (2):
       ARM: firmware: Introduce suspend and resume operations
       ARM: EXYNOS: Add support for firmware-assisted suspend/resume

  Documentation/arm/firmware.txt         |  28 +--
  arch/arm/include/asm/firmware.h        |  10 +-
  arch/arm/mach-exynos/Kconfig           |   5 +
  arch/arm/mach-exynos/Makefile          |   6 +-
  arch/arm/mach-exynos/common.h          |  13 ++
  arch/arm/mach-exynos/exynos.c          |   5 +-
  arch/arm/mach-exynos/firmware.c        |  65 +++++-
  arch/arm/mach-exynos/platsmp.c         |  23 ++
  arch/arm/mach-exynos/pm.c              | 388 
++++-----------------------------
  arch/arm/mach-exynos/regs-pmu.h        |   2 +
  arch/arm/mach-exynos/sleep.S           |  28 +++
  arch/arm/mach-exynos/smc.h             |   4 +
  arch/arm/mach-exynos/suspend.c         | 356 
++++++++++++++++++++++++++++++
  arch/arm/mach-tegra/cpuidle-tegra114.c |   2 +-
  arch/arm/plat-samsung/Makefile         |   1 +
  15 files changed, 557 insertions(+), 379 deletions(-)
  create mode 100644 arch/arm/mach-exynos/suspend.c
