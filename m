From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 19 Nov 2017 13:44:45 +0100
Subject: [PATCH 2/2] ASoC: rockchip: Delete an unnecessary variable
 initialisation in rk_aif1_hw_params()
In-Reply-To: <255fa488-a5f1-2ea3-dd48-b10ad8b2c18c@users.sourceforge.net>
References: <255fa488-a5f1-2ea3-dd48-b10ad8b2c18c@users.sourceforge.net>
Message-ID: <ad5a1eaa-cc97-6d53-f71c-17f43cbd5b25@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 13:26:06 +0100

The variable "ret" will eventually be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/rockchip/rockchip_max98090.c | 2 +-
 sound/soc/rockchip/rockchip_rt5645.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 419fa6ef14bb..6d661a93588f 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -76,7 +76,7 @@ static const struct snd_kcontrol_new rk_mc_controls[] = {
 static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
-	int ret = 0;
+	int ret;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 7f763d0963d3..d032d8bd15b9 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -70,7 +70,7 @@ static const struct snd_kcontrol_new rk_mc_controls[] = {
 static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
-	int ret = 0;
+	int ret;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-- 
2.15.0
