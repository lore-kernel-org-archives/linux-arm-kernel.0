From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:13 +0530
Subject: [PATCH 03/33] ARM: EXYNOS: dev-audio: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-4-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/dev-audio.c |  156 ++++++-------------------------------
 1 files changed, 26 insertions(+), 130 deletions(-)

diff --git a/arch/arm/mach-exynos/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
index 7199e1a..b33a5b6 100644
--- a/arch/arm/mach-exynos/dev-audio.c
+++ b/arch/arm/mach-exynos/dev-audio.c
@@ -62,26 +62,10 @@ static struct s3c_audio_pdata i2sv5_pdata = {
 };
 
 static struct resource exynos4_i2s0_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_I2S0,
-		.end	= EXYNOS4_PA_I2S0 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_I2S0_TX,
-		.end	= DMACH_I2S0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_I2S0_RX,
-		.end	= DMACH_I2S0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DMACH_I2S0S_TX,
-		.end	= DMACH_I2S0S_TX,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_I2S0, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S0_RX),
+	[3] = DEFINE_RES_DMA(DMACH_I2S0S_TX),
 };
 
 struct platform_device exynos4_device_i2s0 = {
@@ -110,21 +94,9 @@ static struct s3c_audio_pdata i2sv3_pdata = {
 };
 
 static struct resource exynos4_i2s1_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_I2S1,
-		.end	= EXYNOS4_PA_I2S1 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_I2S1_TX,
-		.end	= DMACH_I2S1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_I2S1_RX,
-		.end	= DMACH_I2S1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_I2S1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S1_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S1_RX),
 };
 
 struct platform_device exynos4_device_i2s1 = {
@@ -138,21 +110,9 @@ struct platform_device exynos4_device_i2s1 = {
 };
 
 static struct resource exynos4_i2s2_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_I2S2,
-		.end	= EXYNOS4_PA_I2S2 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_I2S2_TX,
-		.end	= DMACH_I2S2_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_I2S2_RX,
-		.end	= DMACH_I2S2_RX,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_I2S2, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S2_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S2_RX),
 };
 
 struct platform_device exynos4_device_i2s2 = {
@@ -192,21 +152,9 @@ static struct s3c_audio_pdata s3c_pcm_pdata = {
 };
 
 static struct resource exynos4_pcm0_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_PCM0,
-		.end	= EXYNOS4_PA_PCM0 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_PCM0_TX,
-		.end	= DMACH_PCM0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_PCM0_RX,
-		.end	= DMACH_PCM0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_PCM0, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM0_RX),
 };
 
 struct platform_device exynos4_device_pcm0 = {
@@ -220,21 +168,9 @@ struct platform_device exynos4_device_pcm0 = {
 };
 
 static struct resource exynos4_pcm1_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_PCM1,
-		.end	= EXYNOS4_PA_PCM1 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_PCM1_TX,
-		.end	= DMACH_PCM1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_PCM1_RX,
-		.end	= DMACH_PCM1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_PCM1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM1_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM1_RX),
 };
 
 struct platform_device exynos4_device_pcm1 = {
@@ -248,21 +184,9 @@ struct platform_device exynos4_device_pcm1 = {
 };
 
 static struct resource exynos4_pcm2_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_PCM2,
-		.end	= EXYNOS4_PA_PCM2 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_PCM2_TX,
-		.end	= DMACH_PCM2_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_PCM2_RX,
-		.end	= DMACH_PCM2_RX,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_PCM2, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM2_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM2_RX),
 };
 
 struct platform_device exynos4_device_pcm2 = {
@@ -283,31 +207,11 @@ static int exynos4_ac97_cfg_gpio(struct platform_device *pdev)
 }
 
 static struct resource exynos4_ac97_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_AC97,
-		.end	= EXYNOS4_PA_AC97 + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_AC97_PCMOUT,
-		.end	= DMACH_AC97_PCMOUT,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMACH_AC97_PCMIN,
-		.end	= DMACH_AC97_PCMIN,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DMACH_AC97_MICIN,
-		.end	= DMACH_AC97_MICIN,
-		.flags	= IORESOURCE_DMA,
-	},
-	[4] = {
-		.start	= EXYNOS4_IRQ_AC97,
-		.end	= EXYNOS4_IRQ_AC97,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_AC97, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_AC97_PCMOUT),
+	[2] = DEFINE_RES_DMA(DMACH_AC97_PCMIN),
+	[3] = DEFINE_RES_DMA(DMACH_AC97_MICIN),
+	[4] = DEFINE_RES_IRQ(EXYNOS4_IRQ_AC97),
 };
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
@@ -338,16 +242,8 @@ static int exynos4_spdif_cfg_gpio(struct platform_device *pdev)
 }
 
 static struct resource exynos4_spdif_resource[] = {
-	[0] = {
-		.start	= EXYNOS4_PA_SPDIF,
-		.end	= EXYNOS4_PA_SPDIF + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_SPDIF,
-		.end	= DMACH_SPDIF,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_SPDIF, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_SPDIF),
 };
 
 static struct s3c_audio_pdata samsung_spdif_pdata = {
-- 
1.7.4.1
