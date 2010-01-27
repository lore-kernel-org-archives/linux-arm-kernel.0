From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Wed, 27 Jan 2010 15:02:04 +0900
Subject: [PATCHv2 09/10] ASoC: AC97: LN2440SBC: Switch to s3c-ac97.c
Message-ID: <1264572124-24790-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Switch to use s3c-ac97.c AC97 controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig            |    7 +++----
 sound/soc/s3c24xx/ln2440sbc_alc650.c |    4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 8b62798..69d143e 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -29,9 +29,6 @@ config SND_S3C_SOC_PCM
 
 config SND_S3C2443_SOC_AC97
 	tristate
-	select S3C2410_DMA
-	select AC97_BUS
-	select SND_SOC_AC97_BUS
 
 config SND_S3C_SOC_AC97
 	tristate
@@ -86,8 +83,10 @@ config SND_S3C24XX_SOC_SMDK2443_WM9710
 config SND_S3C24XX_SOC_LN2440SBC_ALC650
 	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
 	depends on SND_S3C24XX_SOC && ARCH_S3C2410
-	select SND_S3C2443_SOC_AC97
+	select S3C2410_DMA
+	select AC97_BUS
 	select SND_SOC_AC97_CODEC
+	select SND_S3C_SOC_AC97
 	help
 	  Say Y if you want to add support for SoC audio on ln2440sbc
 	  with the ALC650.
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index d00d359..ffa954f 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -25,7 +25,7 @@
 
 #include "../codecs/ac97.h"
 #include "s3c-dma.h"
-#include "s3c24xx-ac97.h"
+#include "s3c-ac97.h"
 
 static struct snd_soc_card ln2440sbc;
 
@@ -33,7 +33,7 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
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
