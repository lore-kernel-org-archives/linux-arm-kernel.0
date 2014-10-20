From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 Oct 2014 00:54:27 +0900
Subject: [GIT PULL 2/3] 1st Round of Samsung PM updates for v3.19
Message-ID: <54453033.6050004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Same, I've just rebased for Samsung PM updates for v3.19.
Please pull.

Thanks,
Kukjin

---

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-pm

for you to fetch changes up to b588aaec6d0d846c88bfa2ba95e76147386a4cd6:

   ARM: EXYNOS: SWRESET is needed to boot secondary CPU on exynos3250 
(2014-10-21 00:06:36 +0900)

----------------------------------------------------------------
Samsung PM updates for v3.19

- Refactor the pm code to use DT based lookup instead of
   using "soc_is_exynosxxxx"

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

Vikas Sajjan (2):
       ARM: EXYNOS: Move Disabling of JPEG USE_RETENTION for exynos5250 
to pmu.c
       ARM: EXYNOS: Refactor the pm code to use DT based lookup

  Documentation/arm/firmware.txt         |  28 +--
  arch/arm/include/asm/firmware.h        |  10 +-
  arch/arm/mach-exynos/Kconfig           |   5 +
  arch/arm/mach-exynos/Makefile          |   6 +-
  arch/arm/mach-exynos/common.h          |  13 ++
  arch/arm/mach-exynos/exynos.c          |   5 +-
  arch/arm/mach-exynos/firmware.c        |  65 +++++-
  arch/arm/mach-exynos/platsmp.c         |  23 +++
  arch/arm/mach-exynos/pm.c              | 310 ++++------------------------
  arch/arm/mach-exynos/pmu.c             |   1 +
  arch/arm/mach-exynos/regs-pmu.h        |   3 +
  arch/arm/mach-exynos/sleep.S           |  28 +++
  arch/arm/mach-exynos/smc.h             |   4 +
  arch/arm/mach-exynos/suspend.c         | 356 
+++++++++++++++++++++++++++++++++
  arch/arm/mach-tegra/cpuidle-tegra114.c |   2 +-
  arch/arm/plat-samsung/Makefile         |   1 +
  16 files changed, 559 insertions(+), 301 deletions(-)
  create mode 100644 arch/arm/mach-exynos/suspend.c
