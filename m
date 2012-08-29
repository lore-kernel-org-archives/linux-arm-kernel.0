From: chanho61.park@samsung.com (Chanho Park)
Date: Wed, 29 Aug 2012 10:14:53 +0900
Subject: [PATCH v3 0/4] Add support to enable ARM PMU for EXYNOS
Message-ID: <1346202897-27306-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes irq numbers of ARM Performance Monitoring unit and enable it
for Perf(Performance Counter) on the exynos 4 and 5. The exynos4 and 5 use 2
more cpu cores which has its own pmu.
The exynos uses combiner-irq type for arm-pmu. Especially, the exynos4412 has 4
extra combined irq groups. So, we need to change a max combiner number.
To enable perf, we need also to implement a set_irq_affinity function about the
combiner-irq. After applying this patch, we can use the perf for the exynos
machine.

Changes from v2:
 - Convert to dt binding of exynos5250

Changes from v1:
 - Split arm-pmu init of exynos from plat-samsung
 - Correct combined irqs of exynos4412
 - Use soc_is_xxx function instead of CONFIG_XXX to identify dynamically

Chanho Park (4):
  ARM: EXYNOS: Add set_irq_affinity function for combiner_irq
  ARM: EXYNOS: Correct combined IRQs for exynos4412
  ARM: EXYNOS: Enable PMUs for exynos4
  ARM: EXYNOS: Add arm-pmu DT binding for exynos5250

 arch/arm/boot/dts/exynos5250.dtsi        |    6 ++
 arch/arm/mach-exynos/common.c            |  106 ++++++++++++++++++++++++++----
 arch/arm/mach-exynos/include/mach/irqs.h |   10 ++-
 arch/arm/plat-samsung/devs.c             |    2 +-
 4 files changed, 109 insertions(+), 15 deletions(-)

-- 
1.7.9.5
