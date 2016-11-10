From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Nov 2016 16:17:56 +0100
Subject: [PATCH 8/8] ARM: s3c24xx: Drop unused struct s3c_audio_pdata entries
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478791076-19528-9-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c24xx-iis driver is now converted to use the dma_slave_map API
and the samsung-ac97 driver got removed from the tree so remove
the unused platform data structure instances.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/plat-samsung/devs.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index cf7b95f..03fac12 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -77,15 +77,6 @@
 	[1] = DEFINE_RES_IRQ(IRQ_S3C244X_AC97),
 };
 
-static struct s3c_audio_pdata s3c_ac97_pdata = {
-#ifdef CONFIG_S3C24XX_DMAC
-	.dma_filter = s3c24xx_dma_filter,
-#endif
-	.dma_playback = (void *)DMACH_PCM_OUT,
-	.dma_capture = (void *)DMACH_PCM_IN,
-	.dma_capture_mic = (void *)DMACH_MIC_IN,
-};
-
 struct platform_device s3c_device_ac97 = {
 	.name		= "samsung-ac97",
 	.id		= -1,
@@ -94,7 +85,6 @@ struct platform_device s3c_device_ac97 = {
 	.dev		= {
 		.dma_mask		= &samsung_device_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &s3c_ac97_pdata,
 	}
 };
 #endif /* CONFIG_CPU_S3C2440 */
@@ -574,14 +564,6 @@ void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
 	[0] = DEFINE_RES_MEM(S3C24XX_PA_IIS, S3C24XX_SZ_IIS),
 };
 
-static struct s3c_audio_pdata s3c_iis_platdata = {
-#ifdef CONFIG_S3C24XX_DMAC
-	.dma_filter = s3c24xx_dma_filter,
-#endif
-	.dma_playback = (void *)DMACH_I2S_OUT,
-	.dma_capture = (void *)DMACH_I2S_IN,
-};
-
 struct platform_device s3c_device_iis = {
 	.name		= "s3c24xx-iis",
 	.id		= -1,
@@ -590,7 +572,6 @@ struct platform_device s3c_device_iis = {
 	.dev		= {
 		.dma_mask		= &samsung_device_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &s3c_iis_platdata,
 	}
 };
 #endif /* CONFIG_PLAT_S3C24XX */
-- 
1.9.1
