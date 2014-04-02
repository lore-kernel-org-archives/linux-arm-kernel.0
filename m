From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 02 Apr 2014 16:50:51 +0900
Subject: [PATCH 0/7] ARM: Exynos: PMU cleanup and refactoring for using DT
Message-ID: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series, does some minor cleanup and modifies Exynos PMU related
code for mapping Exynos Power Management Unit (PMU) base address from device
tree. Since PMU offsets are used across many files under mach-exynos, it
introduces one helper function to get PMU base address in exynos.c.

This patch series is preparation for moving PMU related code out of machine
folder and converting into a driver.

This patch requires change in Exynos4210, Exynos4212 and Exynos4412 dtsi files,
which I will post shortly as separate patch series.

These patches are created on top of kgene for-next branch.
We have tested these patches for System boot and PMU initialization of
Exynos5250 and Exynos5260 (with some internal patches).
For rest Exynos SoC it has been only compile tested.

Pankaj Dubey (4):
  ARM: EXYNOS: Cleanup  "mach-exynos/common.h" file
  ARM: EXYNOS: Correct file path in comment message
  ARM: EXYNOS: Move "regs-pmu" header inclusion in common.h
  ARM: EXYNOS: Refactored code for PMU register mapping via DT

Young-Gun Jang (3):
  ARM: EXYNOS: Move SYSREG definition into sys-reg specific file
  ARM: EXYNOS: Remove regs-pmu.h file dependency from pm_domain
  ARM: EXYNOS: Add support for mapping PMU base address via DT

 arch/arm/mach-exynos/common.h           |   10 +-
 arch/arm/mach-exynos/cpuidle.c          |   29 +-
 arch/arm/mach-exynos/exynos.c           |   58 +++-
 arch/arm/mach-exynos/hotplug.c          |    5 +-
 arch/arm/mach-exynos/include/mach/map.h |    3 -
 arch/arm/mach-exynos/platsmp.c          |   15 +-
 arch/arm/mach-exynos/pm.c               |   55 ++--
 arch/arm/mach-exynos/pm_domains.c       |    2 +-
 arch/arm/mach-exynos/pmu.c              |   35 +--
 arch/arm/mach-exynos/regs-pmu.h         |  510 +++++++++++++++----------------
 arch/arm/mach-exynos/regs-sys.h         |   22 ++
 11 files changed, 405 insertions(+), 339 deletions(-)
 create mode 100644 arch/arm/mach-exynos/regs-sys.h

-- 
1.7.10.4
