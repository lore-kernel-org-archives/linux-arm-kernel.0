From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 13:35:59 +0900
Subject: [PATCH 1/7] ARM: EXYNOS: use static declaration when it is not used in
 other files
Message-ID: <010901ccd7f6$2c71e490$8555adb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos4210.c    |    2 +-
 arch/arm/mach-exynos/clock-exynos4212.c    |    2 +-
 arch/arm/mach-exynos/clock.c               |    2 +-
 arch/arm/mach-exynos/common.c              |    2 +-
 arch/arm/mach-exynos/dma.c                 |   12 ++++++------
 arch/arm/mach-exynos/mach-origen.c         |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4210.c b/arch/arm/mach-exynos/clock-exynos4210.c
index a5823a7..25ea400 100644
--- a/arch/arm/mach-exynos/clock-exynos4210.c
+++ b/arch/arm/mach-exynos/clock-exynos4210.c
@@ -115,7 +115,7 @@ static void exynos4210_clock_resume(void)
 #define exynos4210_clock_resume NULL
 #endif
 
-struct syscore_ops exynos4210_clock_syscore_ops = {
+static struct syscore_ops exynos4210_clock_syscore_ops = {
 	.suspend	= exynos4210_clock_suspend,
 	.resume		= exynos4210_clock_resume,
 };
diff --git a/arch/arm/mach-exynos/clock-exynos4212.c b/arch/arm/mach-exynos/clock-exynos4212.c
index 26a668b..b133f86 100644
--- a/arch/arm/mach-exynos/clock-exynos4212.c
+++ b/arch/arm/mach-exynos/clock-exynos4212.c
@@ -87,7 +87,7 @@ static void exynos4212_clock_resume(void)
 #define exynos4212_clock_resume NULL
 #endif
 
-struct syscore_ops exynos4212_clock_syscore_ops = {
+static struct syscore_ops exynos4212_clock_syscore_ops = {
 	.suspend	= exynos4212_clock_suspend,
 	.resume		= exynos4212_clock_resume,
 };
diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
index 5a8c42e..c07c6d4 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@ -1524,7 +1524,7 @@ static void exynos4_clock_resume(void)
 #define exynos4_clock_resume NULL
 #endif
 
-struct syscore_ops exynos4_clock_syscore_ops = {
+static struct syscore_ops exynos4_clock_syscore_ops = {
 	.suspend	= exynos4_clock_suspend,
 	.resume		= exynos4_clock_resume,
 };
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index c59e188..b7f4b59 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -673,7 +673,7 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-int __init exynos4_init_irq_eint(void)
+static int __init exynos4_init_irq_eint(void)
 {
 	int irq;
 
diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index b10fcd2..8dec3db 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -36,7 +36,7 @@
 
 static u64 dma_dmamask = DMA_BIT_MASK(32);
 
-u8 pdma0_peri[] = {
+static u8 pdma0_peri[] = {
 	DMACH_PCM0_RX,
 	DMACH_PCM0_TX,
 	DMACH_PCM2_RX,
@@ -69,12 +69,12 @@ u8 pdma0_peri[] = {
 	DMACH_AC97_PCMOUT,
 };
 
-struct dma_pl330_platdata exynos4_pdma0_pdata = {
+static struct dma_pl330_platdata exynos4_pdma0_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
 	.peri_id = pdma0_peri,
 };
 
-struct amba_device exynos4_device_pdma0 = {
+static struct amba_device exynos4_device_pdma0 = {
 	.dev = {
 		.init_name = "dma-pl330.0",
 		.dma_mask = &dma_dmamask,
@@ -90,7 +90,7 @@ struct amba_device exynos4_device_pdma0 = {
 	.periphid = 0x00041330,
 };
 
-u8 pdma1_peri[] = {
+static u8 pdma1_peri[] = {
 	DMACH_PCM0_RX,
 	DMACH_PCM0_TX,
 	DMACH_PCM1_RX,
@@ -118,12 +118,12 @@ u8 pdma1_peri[] = {
 	DMACH_SLIMBUS5_TX,
 };
 
-struct dma_pl330_platdata exynos4_pdma1_pdata = {
+static struct dma_pl330_platdata exynos4_pdma1_pdata = {
 	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
 	.peri_id = pdma1_peri,
 };
 
-struct amba_device exynos4_device_pdma1 = {
+static struct amba_device exynos4_device_pdma1 = {
 	.dev = {
 		.init_name = "dma-pl330.1",
 		.dma_mask = &dma_dmamask,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 0679b8a..3ec3ccf 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -412,7 +412,7 @@ static struct max8997_regulator_data __initdata origen_max8997_regulators[] = {
 	{ MAX8997_BUCK7,	&max8997_buck7_data },
 };
 
-struct max8997_platform_data __initdata origen_max8997_pdata = {
+static struct max8997_platform_data __initdata origen_max8997_pdata = {
 	.num_regulators = ARRAY_SIZE(origen_max8997_regulators),
 	.regulators	= origen_max8997_regulators,
 
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 37ac93e..29c8e18 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -997,7 +997,7 @@ static void __init universal_map_io(void)
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
 }
 
-void s5p_tv_setup(void)
+static void s5p_tv_setup(void)
 {
 	/* direct HPD to HDMI chip */
 	gpio_request_one(EXYNOS4_GPX3(7), GPIOF_IN, "hpd-plug");
-- 
1.7.1
