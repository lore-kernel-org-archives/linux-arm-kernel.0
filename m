From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 27 May 2016 22:26:59 +0200
Subject: [RFC PATCH v2 7/7] ASoC: mioa701_wm9713: convert to new ac97 bus
In-Reply-To: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
References: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1464380819-19075-8-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to the new auto-probing ac97 bus, which changes the device name.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/pxa/mioa701_wm9713.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 5c8f9db50a47..4ed10e6ff5d1 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -149,7 +149,7 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 		.stream_name = "AC97 HiFi",
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9713-hifi",
-		.codec_name = "wm9713-codec",
+		.codec_name = "pxa2xx-ac97:0",
 		.init = mioa701_wm9713_init,
 		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
@@ -159,7 +159,7 @@ static struct snd_soc_dai_link mioa701_dai[] = {
 		.stream_name = "AC97 Aux",
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name ="wm9713-aux",
-		.codec_name = "wm9713-codec",
+		.codec_name = "pxa2xx-ac97:0",
 		.platform_name = "pxa-pcm-audio",
 		.ops = &mioa701_ops,
 	},
-- 
2.1.4
