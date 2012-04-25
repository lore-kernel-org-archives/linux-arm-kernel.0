From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:33 +0530
Subject: [PATCH 23/33] ARM: S3C64XX: dev-audio: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-24-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c64xx/dev-audio.c |  120 ++++++------------------------------
 1 files changed, 20 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 93470b1..124fd5d 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -57,21 +57,9 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 }
 
 static struct resource s3c64xx_iis0_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_IIS0,
-		.end   = S3C64XX_PA_IIS0 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S0_OUT,
-		.end   = DMACH_I2S0_OUT,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S0_IN,
-		.end   = DMACH_I2S0_IN,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_IIS0, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S0_OUT),
+	[2] = DEFINE_RES_DMA(DMACH_I2S0_IN),
 };
 
 static struct s3c_audio_pdata i2sv3_pdata = {
@@ -95,21 +83,9 @@ struct platform_device s3c64xx_device_iis0 = {
 EXPORT_SYMBOL(s3c64xx_device_iis0);
 
 static struct resource s3c64xx_iis1_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_IIS1,
-		.end   = S3C64XX_PA_IIS1 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S1_OUT,
-		.end   = DMACH_I2S1_OUT,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S1_IN,
-		.end   = DMACH_I2S1_IN,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_IIS1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S1_OUT),
+	[2] = DEFINE_RES_DMA(DMACH_I2S1_IN),
 };
 
 struct platform_device s3c64xx_device_iis1 = {
@@ -124,21 +100,9 @@ struct platform_device s3c64xx_device_iis1 = {
 EXPORT_SYMBOL(s3c64xx_device_iis1);
 
 static struct resource s3c64xx_iisv4_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_IISV4,
-		.end   = S3C64XX_PA_IISV4 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_HSI_I2SV40_TX,
-		.end   = DMACH_HSI_I2SV40_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_HSI_I2SV40_RX,
-		.end   = DMACH_HSI_I2SV40_RX,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_IISV4, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_HSI_I2SV40_TX),
+	[2] = DEFINE_RES_DMA(DMACH_HSI_I2SV40_RX),
 };
 
 static struct s3c_audio_pdata i2sv4_pdata = {
@@ -187,21 +151,9 @@ static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
 }
 
 static struct resource s3c64xx_pcm0_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_PCM0,
-		.end   = S3C64XX_PA_PCM0 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_PCM0_TX,
-		.end   = DMACH_PCM0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_PCM0_RX,
-		.end   = DMACH_PCM0_RX,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_PCM0, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM0_RX),
 };
 
 static struct s3c_audio_pdata s3c_pcm0_pdata = {
@@ -220,21 +172,9 @@ struct platform_device s3c64xx_device_pcm0 = {
 EXPORT_SYMBOL(s3c64xx_device_pcm0);
 
 static struct resource s3c64xx_pcm1_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_PCM1,
-		.end   = S3C64XX_PA_PCM1 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_PCM1_TX,
-		.end   = DMACH_PCM1_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_PCM1_RX,
-		.end   = DMACH_PCM1_RX,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_PCM1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM1_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM1_RX),
 };
 
 static struct s3c_audio_pdata s3c_pcm1_pdata = {
@@ -265,31 +205,11 @@ static int s3c64xx_ac97_cfg_gpe(struct platform_device *pdev)
 }
 
 static struct resource s3c64xx_ac97_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_AC97,
-		.end   = S3C64XX_PA_AC97 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_AC97_PCMOUT,
-		.end   = DMACH_AC97_PCMOUT,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_AC97_PCMIN,
-		.end   = DMACH_AC97_PCMIN,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.start = DMACH_AC97_MICIN,
-		.end   = DMACH_AC97_MICIN,
-		.flags = IORESOURCE_DMA,
-	},
-	[4] = {
-		.start = IRQ_AC97,
-		.end   = IRQ_AC97,
-		.flags = IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_AC97, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_AC97_PCMOUT),
+	[2] = DEFINE_RES_DMA(DMACH_AC97_PCMIN),
+	[3] = DEFINE_RES_DMA(DMACH_AC97_MICIN),
+	[4] = DEFINE_RES_IRQ(IRQ_AC97),
 };
 
 static struct s3c_audio_pdata s3c_ac97_pdata;
-- 
1.7.4.1
