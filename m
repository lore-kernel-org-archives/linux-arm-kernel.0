From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 28 Aug 2012 13:08:28 +0200
Subject: [PATCH] ARM: EXYNOS: Use non-secure MDMA1
Message-ID: <5886686.Vz6SVkoRWm@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using secure MDMA1 on TrustZone-enabled boards causes early boot crash,
so use non-secure instead.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/dma.c              | 2 +-
 arch/arm/mach-exynos/include/mach/map.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index f60b66d..8858df5 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -261,7 +261,7 @@ static struct dma_pl330_platdata exynos_mdma1_pdata = {
 };
 
 static AMBA_AHB_DEVICE(exynos_mdma1,  "dma-pl330.2", 0x00041330,
-	EXYNOS4_PA_MDMA1, {EXYNOS4_IRQ_MDMA1}, &exynos_mdma1_pdata);
+	EXYNOS4_PA_NS_MDMA1, {EXYNOS4_IRQ_MDMA1}, &exynos_mdma1_pdata);
 
 static int __init exynos_dma_init(void)
 {
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-
exynos/include/mach/map.h
index 51943f2..5df5910 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -89,7 +89,8 @@
 #define EXYNOS4_PA_L2CC			0x10502000
 
 #define EXYNOS4_PA_MDMA0		0x10810000
-#define EXYNOS4_PA_MDMA1		0x12840000
+#define EXYNOS4_PA_S_MDMA1		0x12840000
+#define EXYNOS4_PA_NS_MDMA1		0x12850000
 #define EXYNOS4_PA_PDMA0		0x12680000
 #define EXYNOS4_PA_PDMA1		0x12690000
 #define EXYNOS5_PA_MDMA0		0x10800000
-- 
1.7.12
