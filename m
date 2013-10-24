From: denis@eukrea.com (Denis Carikli)
Date: Thu, 24 Oct 2013 14:13:48 +0200
Subject: [PATCHv7][ 1/5] ASoC: eukrea-tlv320: Use dev_err instead of pr_err.
Message-ID: <1382616832-23593-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It also contains a minor style cleanup.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v6->v7:
- eukrea-tlv320 cleanups are now moved into that patch.
---
 sound/soc/fsl/eukrea-tlv320.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 9a4a0ca..5983740 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -42,7 +42,8 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (ret) {
-		pr_err("%s: failed set cpu dai format\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the cpu dai format.\n");
 		return ret;
 	}
 
@@ -50,14 +51,16 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (ret) {
-		pr_err("%s: failed set codec dai format\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the codec format.\n");
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 				     CODEC_CLOCK, SND_SOC_CLOCK_OUT);
 	if (ret) {
-		pr_err("%s: failed setting codec sysclk\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the codec sysclk.\n");
 		return ret;
 	}
 	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
@@ -65,7 +68,8 @@ static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
 				SND_SOC_CLOCK_IN);
 	if (ret) {
-		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
+		dev_err(cpu_dai->dev,
+			"Can't set the IMX_SSP_SYS_CLK CPU system clock.\n");
 		return ret;
 	}
 
@@ -155,7 +159,8 @@ static struct platform_driver eukrea_tlv320_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = eukrea_tlv320_probe,
-	.remove = eukrea_tlv320_remove,};
+	.remove = eukrea_tlv320_remove,
+};
 
 module_platform_driver(eukrea_tlv320_driver);
 
-- 
1.7.9.5
