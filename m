From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 27 Jul 2012 17:08:26 +0900
Subject: [PATCHv2 0/3] Add support to enable ARM PMU for EXYNOS4/5
Message-ID: <1343376509-5881-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes irq numbers of ARM Performance Monitoring unit and enable it
for Perf(Performance Counter) on the exynos 4 and 5. The exynos4 and 5 use 2
more cpu core which has its own pmu. We should define pmu irq numbers according
to the number of cpus.
The pmu irq of exynos4 and 5 uses combiner-irq type.
The exynos4412 especially has 4 extra combined irq groups. We should enable the
groups beacuse two pmu irqs are there. To enable perf, we need also to implement
a set_irq_affinity function about the combiner-irq.
After this patch, we can use the perf for the exynos machine.

Changes from v1:
 - Split arm-pmu init of exynos from plat-samsung
 - Correct combined irqs of exynos4412
 - Use soc_is_xxx function instead of CONFIG_XXX to identify dynamically

Chanho Park (3):
  ARM: EXYNOS: Add set_irq_affinity function for combiner_irq
  ARM: EXYNOS: Correct combined IRQs for exynos4412
  ARM: EXYNOS: Enable PMUs for exynos4/5

 arch/arm/mach-exynos/common.c            |  137 +++++++++++++++++++++++++++---
 arch/arm/mach-exynos/include/mach/irqs.h |   11 ++-
 arch/arm/plat-samsung/devs.c             |    3 +-
 3 files changed, 135 insertions(+), 16 deletions(-)

-- 
1.7.9.5
