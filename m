From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 13:36:42 +0900
Subject: [PATCH 7/7] ARM: SAMSUNG: use static declaration when it is not used
 in other files
Message-ID: <010f01ccd7f6$4627c580$d2775080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/irq-eint.c    |    2 +-
 arch/arm/plat-s5p/irq-gpioint.c |    2 +-
 arch/arm/plat-samsung/devs.c    |   13 +------------
 arch/arm/plat-samsung/dma-ops.c |    2 +-
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index c496b35..139c050 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -200,7 +200,7 @@ static struct irq_chip s5p_irq_vic_eint = {
 #endif
 };
 
-int __init s5p_init_irq_eint(void)
+static int __init s5p_init_irq_eint(void)
 {
 	int irq;
 
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
index 1fdfaa4..82c7311 100644
--- a/arch/arm/plat-s5p/irq-gpioint.c
+++ b/arch/arm/plat-s5p/irq-gpioint.c
@@ -41,7 +41,7 @@ struct s5p_gpioint_bank {
 	void			(*handler)(unsigned int, struct irq_desc *);
 };
 
-LIST_HEAD(banks);
+static LIST_HEAD(banks);
 
 static int s5p_gpioint_set_type(struct irq_data *d, unsigned int type)
 {
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 32a6e39..eddb0eb 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -742,17 +742,6 @@ struct platform_device s3c_device_iis = {
 };
 #endif /* CONFIG_PLAT_S3C24XX */
 
-#ifdef CONFIG_CPU_S3C2440
-struct platform_device s3c2412_device_iis = {
-	.name		= "s3c2412-iis",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-#endif /* CONFIG_CPU_S3C2440 */
-
 /* IDE CFCON */
 
 #ifdef CONFIG_SAMSUNG_DEV_IDE
@@ -1076,7 +1065,7 @@ static struct resource s5p_pmu_resource[] = {
 	DEFINE_RES_IRQ(IRQ_PMU)
 };
 
-struct platform_device s5p_device_pmu = {
+static struct platform_device s5p_device_pmu = {
 	.name		= "arm-pmu",
 	.id		= ARM_PMU_DEVICE_CPU,
 	.num_resources	= ARRAY_SIZE(s5p_pmu_resource),
diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index 0747c77..301d9c3 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -116,7 +116,7 @@ static inline int samsung_dmadev_flush(unsigned ch)
 	return dmaengine_terminate_all((struct dma_chan *)ch);
 }
 
-struct samsung_dma_ops dmadev_ops = {
+static struct samsung_dma_ops dmadev_ops = {
 	.request	= samsung_dmadev_request,
 	.release	= samsung_dmadev_release,
 	.prepare	= samsung_dmadev_prepare,
-- 
1.7.1
