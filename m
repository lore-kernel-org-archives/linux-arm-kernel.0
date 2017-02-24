From: songjun.wu@microchip.com (Songjun Wu)
Date: Fri, 24 Feb 2017 15:10:43 +0800
Subject: [PATCH] ASoC: atmel-classd: fix audio clock rate
Message-ID: <20170224071043.25522-1-songjun.wu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the audio clock rate according to the datasheet.

Reported-by: Dushara Jayasinghe <dushara@successful.com.au>
Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
---

 sound/soc/atmel/atmel-classd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 89ac5f5a93eb..7ae46c2647d4 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -349,7 +349,7 @@ static int atmel_classd_codec_dai_digital_mute(struct snd_soc_dai *codec_dai,
 }
 
 #define CLASSD_ACLK_RATE_11M2896_MPY_8 (112896 * 100 * 8)
-#define CLASSD_ACLK_RATE_12M288_MPY_8  (12228 * 1000 * 8)
+#define CLASSD_ACLK_RATE_12M288_MPY_8  (12288 * 1000 * 8)
 
 static struct {
 	int rate;
-- 
2.11.0
