From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:41 +0530
Subject: [PATCH 31/33] ARM: S5PC100: dev-audio: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-32-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s5pc100/dev-audio.c |  138 ++++++------------------------------
 1 files changed, 23 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index ab2d271..9d4bde3 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -56,26 +56,10 @@ static struct s3c_audio_pdata i2sv5_pdata = {
 };
 
 static struct resource s5pc100_iis0_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_I2S0,
-		.end   = S5PC100_PA_I2S0 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S0_TX,
-		.end   = DMACH_I2S0_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S0_RX,
-		.end   = DMACH_I2S0_RX,
-		.flags = IORESOURCE_DMA,
-	},
-	[3] = {
-		.start = DMACH_I2S0S_TX,
-		.end = DMACH_I2S0S_TX,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S5PC100_PA_I2S0, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S0_RX),
+	[3] = DEFINE_RES_DMA(DMACH_I2S0S_TX),
 };
 
 struct platform_device s5pc100_device_iis0 = {
@@ -103,21 +87,9 @@ static struct s3c_audio_pdata i2sv3_pdata = {
 };
 
 static struct resource s5pc100_iis1_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_I2S1,
-		.end   = S5PC100_PA_I2S1 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S1_TX,
-		.end   = DMACH_I2S1_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S1_RX,
-		.end   = DMACH_I2S1_RX,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S5PC100_PA_I2S1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S1_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S1_RX),
 };
 
 struct platform_device s5pc100_device_iis1 = {
@@ -131,21 +103,9 @@ struct platform_device s5pc100_device_iis1 = {
 };
 
 static struct resource s5pc100_iis2_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_I2S2,
-		.end   = S5PC100_PA_I2S2 + 0x100 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = DMACH_I2S2_TX,
-		.end   = DMACH_I2S2_TX,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = DMACH_I2S2_RX,
-		.end   = DMACH_I2S2_RX,
-		.flags = IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S5PC100_PA_I2S2, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S2_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S2_RX),
 };
 
 struct platform_device s5pc100_device_iis2 = {
@@ -184,21 +144,9 @@ static struct s3c_audio_pdata s3c_pcm_pdata = {
 };
 
 static struct resource s5pc100_pcm0_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_PCM0,
-		.end   = S5PC100_PA_PCM0 + 0x100 - 1,
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
+	[0] = DEFINE_RES_MEM(S5PC100_PA_PCM0, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM0_RX),
 };
 
 struct platform_device s5pc100_device_pcm0 = {
@@ -212,21 +160,9 @@ struct platform_device s5pc100_device_pcm0 = {
 };
 
 static struct resource s5pc100_pcm1_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_PCM1,
-		.end   = S5PC100_PA_PCM1 + 0x100 - 1,
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
+	[0] = DEFINE_RES_MEM(S5PC100_PA_PCM1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM1_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM1_RX),
 };
 
 struct platform_device s5pc100_device_pcm1 = {
@@ -247,31 +183,11 @@ static int s5pc100_ac97_cfg_gpio(struct platform_device *pdev)
 }
 
 static struct resource s5pc100_ac97_resource[] = {
-	[0] = {
-		.start = S5PC100_PA_AC97,
-		.end   = S5PC100_PA_AC97 + 0x100 - 1,
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
+	[0] = DEFINE_RES_MEM(S5PC100_PA_AC97, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_AC97_PCMOUT),
+	[2] = DEFINE_RES_DMA(DMACH_AC97_PCMIN),
+	[3] = DEFINE_RES_DMA(DMACH_AC97_MICIN),
+	[4] = DEFINE_RES_IRQ(IRQ_AC97),
 };
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
@@ -308,16 +224,8 @@ static int s5pc100_spdif_cfg_gpg3(struct platform_device *pdev)
 }
 
 static struct resource s5pc100_spdif_resource[] = {
-	[0] = {
-		.start	= S5PC100_PA_SPDIF,
-		.end	= S5PC100_PA_SPDIF + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMACH_SPDIF,
-		.end	= DMACH_SPDIF,
-		.flags	= IORESOURCE_DMA,
-	},
+	[0] = DEFINE_RES_MEM(S5PC100_PA_SPDIF, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_SPDIF),
 };
 
 static struct s3c_audio_pdata s5p_spdif_pdata = {
-- 
1.7.4.1
