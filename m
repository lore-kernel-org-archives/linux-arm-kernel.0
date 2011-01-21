From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 21 Jan 2011 22:14:17 +0300
Subject: [PATCH] ASoC: correct link specifications for corgi, poodle and spitz
Message-ID: <1295637257-28299-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASoC DAI link descriptions for Corgi, Poodle and Spitz platforms
contained incorrect names for cpu_dai and codec, which effectievly disabled sound
on theese platforms. Fix that errors.

Cc: stable at vger.kernel.org
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/corgi.c  |    4 ++--
 sound/soc/pxa/poodle.c |    2 +-
 sound/soc/pxa/spitz.c  |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index f451acd..135d903 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -305,10 +305,10 @@ static int corgi_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link corgi_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731",
-	.cpu_dai_name = "pxa-is2-dai",
+	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8731-codec-0.001a",
+	.codec_name = "wm8731-codec-0.001b",
 	.init = corgi_wm8731_init,
 	.ops = &corgi_ops,
 };
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 84edd03..0eebe11 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -274,7 +274,7 @@ static struct snd_soc_dai_link poodle_dai = {
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8731-codec.0-001a",
+	.codec_name = "wm8731-codec.0-001b",
 	.init = poodle_wm8731_init,
 	.ops = &poodle_ops,
 };
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 0b30d7d..7604471 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -313,10 +313,10 @@ static int spitz_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link spitz_dai = {
 	.name = "wm8750",
 	.stream_name = "WM8750",
-	.cpu_dai_name = "pxa-is2",
+	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8750-codec.0-001a",
+	.codec_name = "wm8750-codec.0-001b",
 	.init = spitz_wm8750_init,
 	.ops = &spitz_ops,
 };
-- 
1.7.2.3
