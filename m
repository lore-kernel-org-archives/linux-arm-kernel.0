From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Nov 2016 16:17:55 +0100
Subject: [PATCH 7/8] ARM: s3c64xx: Drop initialization of unused struct
 s3c_audio_pdata fields
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478791076-19528-8-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove initialization of dma_{filter, playback, capture, capture_mic}
fields where it is not used any more.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index b577833..a3f39dd 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -58,9 +58,6 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 
 static struct s3c_audio_pdata i2s0_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
-	.dma_filter = pl08x_filter_id,
-	.dma_playback = DMACH_I2S0_OUT,
-	.dma_capture = DMACH_I2S0_IN,
 };
 
 struct platform_device s3c64xx_device_iis0 = {
@@ -80,9 +77,6 @@ struct platform_device s3c64xx_device_iis0 = {
 
 static struct s3c_audio_pdata i2s1_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
-	.dma_filter = pl08x_filter_id,
-	.dma_playback = DMACH_I2S1_OUT,
-	.dma_capture = DMACH_I2S1_IN,
 };
 
 struct platform_device s3c64xx_device_iis1 = {
@@ -102,9 +96,6 @@ struct platform_device s3c64xx_device_iis1 = {
 
 static struct s3c_audio_pdata i2sv4_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
-	.dma_filter = pl08x_filter_id,
-	.dma_playback = DMACH_HSI_I2SV40_TX,
-	.dma_capture = DMACH_HSI_I2SV40_RX,
 	.type = {
 		.i2s = {
 			.quirks = QUIRK_PRI_6CHAN,
@@ -153,9 +144,6 @@ static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
 
 static struct s3c_audio_pdata s3c_pcm0_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
-	.dma_filter = pl08x_filter_id,
-	.dma_capture = DMACH_PCM0_RX,
-	.dma_playback = DMACH_PCM0_TX,
 };
 
 struct platform_device s3c64xx_device_pcm0 = {
@@ -175,9 +163,6 @@ struct platform_device s3c64xx_device_pcm0 = {
 
 static struct s3c_audio_pdata s3c_pcm1_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
-	.dma_filter = pl08x_filter_id,
-	.dma_playback = DMACH_PCM1_TX,
-	.dma_capture = DMACH_PCM1_RX,
 };
 
 struct platform_device s3c64xx_device_pcm1 = {
@@ -209,10 +194,6 @@ static int s3c64xx_ac97_cfg_gpe(struct platform_device *pdev)
 };
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
-	.dma_playback = DMACH_AC97_PCMOUT,
-	.dma_filter = pl08x_filter_id,
-	.dma_capture = DMACH_AC97_PCMIN,
-	.dma_capture_mic = DMACH_AC97_MICIN,
 };
 
 static u64 s3c64xx_ac97_dmamask = DMA_BIT_MASK(32);
-- 
1.9.1
