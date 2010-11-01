From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 2 Nov 2010 05:10:07 +0800
Subject: ASoC: fix the building issue of missing codec field in 'struct
	snd_soc_card'
Message-ID: <AANLkTikc09UxEB+ZwGSF-guyTV_5FU2t9yXeagUAQoQ7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index a3bfb2e..73d0edd 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -79,7 +79,7 @@ static void tosa_ext_control(struct snd_soc_codec *codec)
 static int tosa_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;

 	/* check the jack status at stream startup */
 	tosa_ext_control(codec);
