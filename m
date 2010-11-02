From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  3 Nov 2010 00:51:53 +0100
Subject: [PATCH 16/17] SND: Tosa: Fix pointer to codec location
In-Reply-To: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1288741914-21328-16-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 sound/soc/pxa/tosa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
-- 
1.7.2.3
