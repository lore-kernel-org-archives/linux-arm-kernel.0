From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 18 Mar 2011 12:47:33 +0100
Subject: [PATCH] sound/soc/pxa/zylonite.c: set .codec_dai_name in initializer
Message-ID: <1300448853-15651-1-git-send-email-ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the initialization of .codec_dai_name in zylonite_dai initializer,
do not mix it with the initialization of .codec_name which is set
already a few lines above.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Hi,

I didn't test that because I don't have the hardware, I just noticed it by 
reading the code from 2.6.38 and thought this may be the right fix.

Is there any mechanism to spot out when the same field in a struct initializer 
is set more than once?

Regards,
   Antonio Ospite
   http://ao2.it

 sound/soc/pxa/zylonite.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 25bba10..5e96f7e 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -167,7 +167,7 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.codec_name = "wm9713-codec",
 	.platform_name = "pxa-pcm-audio",
 	.cpu_dai_name = "pxa2xx-ac97",
-	.codec_name = "wm9713-hifi",
+	.codec_dai_name = "wm9713-hifi",
 	.init = zylonite_wm9713_init,
 },
 {
@@ -176,7 +176,7 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.codec_name = "wm9713-codec",
 	.platform_name = "pxa-pcm-audio",
 	.cpu_dai_name = "pxa2xx-ac97-aux",
-	.codec_name = "wm9713-aux",
+	.codec_dai_name = "wm9713-aux",
 },
 {
 	.name = "WM9713 Voice",
@@ -184,7 +184,7 @@ static struct snd_soc_dai_link zylonite_dai[] = {
 	.codec_name = "wm9713-codec",
 	.platform_name = "pxa-pcm-audio",
 	.cpu_dai_name = "pxa-ssp-dai.2",
-	.codec_name = "wm9713-voice",
+	.codec_dai_name = "wm9713-voice",
 	.ops = &zylonite_voice_ops,
 },
 };
-- 
1.7.4.1
