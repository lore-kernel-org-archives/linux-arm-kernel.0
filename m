From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:40 +0530
Subject: [PATCH 30/33] ARM: S5P64X0: dev-audio: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-31-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s5p64x0/dev-audio.c |   72 ++++++------------------------------
 1 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
index 35f1f22..91113dd 100644
--- a/arch/arm/mach-s5p64x0/dev-audio.c
+++ b/arch/arm/mach-s5p64x0/dev-audio.c
@@ -51,21 +51,9 @@ static struct s3c_audio_pdata s5p6440_i2s_pdata = {
 };
 
 static struct resource s5p64x0_i2s0_resource[] = {
-	[0] = {
-		.start	= S5P64X0_PA_I2S,
-		.end	= S5P64X0_PA_I2S + 0x100 - 1,
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
+	[0] = DEFINE_RES_MEM(S5P64X0_PA_I2S, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S0_RX),
 };
 
 struct platform_device s5p6440_device_iis = {
@@ -130,21 +118,9 @@ static struct s3c_audio_pdata s5p6450_i2s_pdata = {
 };
 
 static struct resource s5p6450_i2s1_resource[] = {
-	[0] = {
-		.start	= S5P6450_PA_I2S1,
-		.end	= S5P6450_PA_I2S1 + 0x100 - 1,
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
+	[0] = DEFINE_RES_MEM(S5P6450_PA_I2S1, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S1_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S1_RX),
 };
 
 struct platform_device s5p6450_device_iis1 = {
@@ -158,21 +134,9 @@ struct platform_device s5p6450_device_iis1 = {
 };
 
 static struct resource s5p6450_i2s2_resource[] = {
-	[0] = {
-		.start	= S5P6450_PA_I2S2,
-		.end	= S5P6450_PA_I2S2 + 0x100 - 1,
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
+	[0] = DEFINE_RES_MEM(S5P6450_PA_I2S2, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_I2S2_TX),
+	[2] = DEFINE_RES_DMA(DMACH_I2S2_RX),
 };
 
 struct platform_device s5p6450_device_iis2 = {
@@ -208,21 +172,9 @@ static struct s3c_audio_pdata s5p6440_pcm_pdata = {
 };
 
 static struct resource s5p6440_pcm0_resource[] = {
-	[0] = {
-		.start	= S5P64X0_PA_PCM,
-		.end	= S5P64X0_PA_PCM + 0x100 - 1,
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
+	[0] = DEFINE_RES_MEM(S5P64X0_PA_PCM, SZ_256),
+	[1] = DEFINE_RES_DMA(DMACH_PCM0_TX),
+	[2] = DEFINE_RES_DMA(DMACH_PCM0_RX),
 };
 
 struct platform_device s5p6440_device_pcm = {
-- 
1.7.4.1
