From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 16:02:54 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Fix PMU IRQs for EXYNOS4 CPU's Performance
 Monitor Unit
Message-ID: <018f01cce88b$2d34e080$879ea180$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/mach-exynos/include/mach/irqs.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 874e224..f82d2cc 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -120,7 +120,7 @@
 #define IRQ_ADC1		IRQ_SPI(107)
 #define IRQ_PEN1		IRQ_SPI(108)
 #define IRQ_KEYPAD		IRQ_SPI(109)
-#define IRQ_PMU			IRQ_SPI(110)
+
 #define IRQ_GPS			IRQ_SPI(111)
 #define IRQ_INTFEEDCTRL_SSS	IRQ_SPI(112)
 #define IRQ_SLIMBUS		IRQ_SPI(113)
@@ -132,6 +132,10 @@
 #define COMBINER_GROUP(x)	((x) * MAX_IRQ_IN_COMBINER + IRQ_SPI(128))
 #define COMBINER_IRQ(x, y)	(COMBINER_GROUP(x) + y)
 
+#define IRQ_PMU_CPU0		COMBINER_IRQ(2, 2)
+#define IRQ_PMU			IRQ_PMU_CPU0
+#define IRQ_PMU_CPU1		COMBINER_IRQ(3, 2)
+
 #define IRQ_SYSMMU_MDMA0_0	COMBINER_IRQ(4, 0)
 #define IRQ_SYSMMU_SSS_0	COMBINER_IRQ(4, 1)
 #define IRQ_SYSMMU_FIMC0_0	COMBINER_IRQ(4, 2)
@@ -154,6 +158,9 @@
 #define IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
 #define IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
 
+#define IRQ_PMU_CPU2		COMBINER_IRQ(18, 2)
+#define IRQ_PMU_CPU3		COMBINER_IRQ(19, 2)
+
 #define MAX_COMBINER_NR		16
 
 #define IRQ_ADC			IRQ_ADC0
-- 
1.7.1
