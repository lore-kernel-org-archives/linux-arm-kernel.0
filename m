From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 04 Nov 2016 17:14:54 +0100
Subject: [PATCH RFC 7/7] ARM: S3C64XX: Drop initialization of unused struct
 s3c_audio_pdata fields
In-Reply-To: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478276094-19135-9-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no drivers using these fields so remove them and remaining
initializations.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c      | 19 -------------------
 include/linux/platform_data/asoc-s3c.h |  5 -----
 2 files changed, 24 deletions(-)

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
diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 15bf56e..2d415f6 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -42,11 +42,6 @@ struct samsung_i2s {
  */
 struct s3c_audio_pdata {
 	int (*cfg_gpio)(struct platform_device *);
-	dma_filter_fn dma_filter;
-	void *dma_playback;
-	void *dma_capture;
-	void *dma_play_sec;
-	void *dma_capture_mic;
 	union {
 		struct samsung_i2s i2s;
 	} type;
-- 
1.9.1
