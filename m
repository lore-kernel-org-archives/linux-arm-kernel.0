From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 02 Apr 2014 17:24:43 +0900
Subject: [RFC PATCH 0/2] Add support for Exynos PMU driver
Message-ID: <1396427085-4696-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series tries to remove machine specific implementation
of Power Management Unit from "mach-exynos" to driver form.
In case of ARM32 we had machine folder such as "mach-exynos" but
moving forward with ARM64 SoC support we can not have any more such
machine folders, keeping that in mind we have planned to move PMU
implementation out of machine folder and give it driver form.
Since PMU binding already exist as "samsung, exynosxxx-pmu, syscon"
and Syscon driver is located under "drivers/mfd" we are moving 
Exynos PMU driver under "drivers/mfd", but suggestions are welcome.

This patch series is based on kgene for-next and depends on following
patch series
1) ARM: Exynos: PMU cleanup and refactoring for using DT
   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg27875.html

We have tested this driver for System boot and PMU initialization on Exynos5250
and Exynos5260 (with support of some internal patches).

Pankaj Dubey (1):
  ARM: EXYNOS: remove arch specific PMU implementation

Younggun Jang (1):
  drivers: mfd: Add support of exynos-pmu driver

 arch/arm/mach-exynos/Kconfig                |    2 +
 arch/arm/mach-exynos/Makefile               |    2 -
 arch/arm/mach-exynos/common.h               |   22 +-
 arch/arm/mach-exynos/pmu.c                  |  426 ---------------------
 arch/arm/mach-exynos/regs-pmu.h             |  310 ----------------
 drivers/mfd/Kconfig                         |    9 +
 drivers/mfd/Makefile                        |    2 +
 drivers/mfd/exynos-pmu.c                    |  534 +++++++++++++++++++++++++++
 include/linux/mfd/samsung/exynos-pmu.h      |   31 ++
 include/linux/mfd/samsung/exynos-regs-pmu.h |  308 +++++++++++++++
 10 files changed, 890 insertions(+), 756 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 delete mode 100644 arch/arm/mach-exynos/regs-pmu.h
 create mode 100644 drivers/mfd/exynos-pmu.c
 create mode 100644 include/linux/mfd/samsung/exynos-pmu.h
 create mode 100644 include/linux/mfd/samsung/exynos-regs-pmu.h

-- 
1.7.10.4
