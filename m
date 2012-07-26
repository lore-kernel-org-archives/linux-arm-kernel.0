From: chanho61.park@samsung.com (Chanho Park)
Date: Thu, 26 Jul 2012 09:35:00 +0900
Subject: [PATCH 0/2] Add support to enable ARM PMU for EXYNOS4/5
Message-ID: <1343262902-19073-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes irq numbers of ARM Performance Monitoring unit.
We need to seperate arm-pmu(performance measurement unit) and exynos-pmu(power
management unit). The exynos4 and 5 use 2 more cpu core which has its own pmu.
We should define pmu irq numbers according to the number of cpus.
The pmu irq of exynos4 and 5 uses combiner-irq type. To enable perf(performance
counter), we need to implement a set_irq_affinity function about the combiner-irq.

Chanho Park (2):
  ARM: EXYNOS: Fix ARM PMU irq numbers
  ARM: EXYNOS: Add set_irq_affinity function for combiner_irq

 arch/arm/mach-exynos/common.c            |   30 +++++++++++++++++++++++++-----
 arch/arm/mach-exynos/include/mach/irqs.h |   18 ++++++++++++++++--
 arch/arm/plat-samsung/devs.c             |    9 ++++++++-
 3 files changed, 49 insertions(+), 8 deletions(-)

-- 
1.7.9.5
