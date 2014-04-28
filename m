From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 28 Apr 2014 21:20:04 +0900
Subject: [RESUBMIT RFC PATCH v2 0/3] Add support for Exynos PMU driver
Message-ID: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series moves PMU implementation from "mach-exynos/pmu.c" to
"drivers/mfd/exynos-pmu.c". Patch v1 was posted as RFC [1].

In case of ARM32 we had machine folder such as "mach-exynos" but
moving forward with ARM64 SoC support we can not have any more such
machine folders, keeping that in mind we have planned to move PMU
implementation out of machine folder, so that common piece of code
can be reused.

This patch series is based on kgene for-next and depends on following
patch series
 a) [PATCH v2 0/5] Add PMU node for Exynos SoCs
	https://lkml.org/lkml/2014/4/25/216
 b) [PATCH v2 00/10] ARM: Exynos: PMU cleanup and refactoring for using DT
	https://lkml.org/lkml/2014/4/25/252


1) [RFC PATCH 0/2] Add support for Exynos PMU driver
	https://lkml.org/lkml/2014/4/2/69

Changes since v1:
 - Rebased on Kukjin Kim's for-next (3.15_rc1 tag)
 - Added patch: Move PMU specific definitions from common.h
 - Added patch: Move pmu specific header files under "linux/mfd/samsung"
 - Removed patch: ARM: EXYNOS: remove arch specific PMU implementation
	As suggested breaking down patches into smalled pieces for better review.
	Also modified all changes in pmu.c under mach-exynos itself and then
	prepared patches moving files from mach-exynos to "drivers/mfd"


Pankaj Dubey (2):
  ARM: EXYNOS: Move pmu specific header files under "linux/mfd/samsung"
  drivers: mfd: Add support for Exynos PMU driver

Younggun Jang (1):
  ARM: EXYNOS: Move PMU specific definitions from common.h

 arch/arm/mach-exynos/Kconfig                       |    2 ++
 arch/arm/mach-exynos/Makefile                      |    2 --
 arch/arm/mach-exynos/common.h                      |   17 -----------
 arch/arm/mach-exynos/cpuidle.c                     |    3 +-
 arch/arm/mach-exynos/exynos.c                      |    2 +-
 arch/arm/mach-exynos/hotplug.c                     |    2 +-
 arch/arm/mach-exynos/platsmp.c                     |    2 +-
 arch/arm/mach-exynos/pm.c                          |    3 +-
 drivers/mfd/Kconfig                                |    9 ++++++
 drivers/mfd/Makefile                               |    1 +
 .../mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c  |    5 ++--
 include/linux/mfd/samsung/exynos-pmu.h             |   31 ++++++++++++++++++++
 .../linux/mfd/samsung/exynos-regs-pmu.h            |    0
 13 files changed, 52 insertions(+), 27 deletions(-)
 rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (99%)
 create mode 100644 include/linux/mfd/samsung/exynos-pmu.h
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/mfd/samsung/exynos-regs-pmu.h (100%)

-- 
1.7.10.4
