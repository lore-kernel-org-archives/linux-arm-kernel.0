From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Wed, 16 May 2012 12:48:24 +0200
Subject: [PATCH] ASoC: imx-mc13783 cleanup
In-Reply-To: <20120515183035.GG19592@opensource.wolfsonmicro.com>
References: <20120515183035.GG19592@opensource.wolfsonmicro.com>
Message-ID: <1337165304-22686-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 sound/soc/fsl/imx-mc13783.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index a7b7170..f59c349 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -37,14 +37,6 @@ static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_fmt(codec_dai, FMT_SSI);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(cpu_dai, FMT_SSI);
-	if (ret)
-		return ret;
-
 	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xfffffffc, 0xfffffffc,
 					4, 16);
 	if (ret)
@@ -75,6 +67,7 @@ static struct snd_soc_dai_link imx_mc13783_dai_mc13783[] = {
 		.platform_name	 = "imx-pcm-audio.0",
 		.ops		 = &imx_mc13783_hifi_ops,
 		.symmetric_rates = 1,
+		.dai_fmt 	 = FMT_SSI,
 	},
 };
 
-- 
1.7.0.4
