From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Jul 2018 15:41:55 +0100
Subject: Applied "ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai
 num_channels" to the asoc tree
In-Reply-To: <20180704094944.16440-5-srinivas.kandagatla@linaro.org>
Message-ID: <E1faiyh-0003wX-4A@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai num_channels

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f1478a1476d45c5d7b070c726f46a7b581d3103c Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:42 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai
 num_channels

num_channels for slim dais are aready set int set_channel_map,
do not overwrite them in hw_params.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 8dd3683eb367..074582afda85 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -81,7 +81,6 @@ static int q6slim_hw_params(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct q6afe_slim_cfg *slim = &dai_data->port_config[dai->id].slim;
 
-	slim->num_channels = params_channels(params);
 	slim->sample_rate = params_rate(params);
 
 	switch (params_format(params)) {
-- 
2.18.0.rc2
