From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Wed, 27 Jan 2010 15:01:03 +0900
Subject: [PATCHv2 07/10] ASoC: AC97: SMDK2443: Switch to s3c-ac97.c
Message-ID: <1264572063-24722-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Switch to use s3c-ac97.c AC97 controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig           |    4 +++-
 sound/soc/s3c24xx/smdk2443_wm9710.c |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index d1c6f93..8b62798 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -75,8 +75,10 @@ config SND_S3C64XX_SOC_WM8580
 config SND_S3C24XX_SOC_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
 	depends on SND_S3C24XX_SOC && MACH_SMDK2443
-	select SND_S3C2443_SOC_AC97
+	select S3C2410_DMA
+	select AC97_BUS
 	select SND_SOC_AC97_CODEC
+	select SND_S3C_SOC_AC97
 	help
 	  Say Y if you want to add support for SoC audio on smdk2443
 	  with the WM9710.
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 12b783b..3622588 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -21,7 +21,7 @@
 
 #include "../codecs/ac97.h"
 #include "s3c-dma.h"
-#include "s3c24xx-ac97.h"
+#include "s3c-ac97.h"
 
 static struct snd_soc_card smdk2443;
 
@@ -29,7 +29,7 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai = &s3c2443_ac97_dai[0],
+	.cpu_dai = &s3c_ac97_dai[S3C_AC97_DAI_PCM],
 	.codec_dai = &ac97_dai,
 },
 };
-- 
1.6.2.5
