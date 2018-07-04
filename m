From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jul 2018 10:49:42 +0100
Subject: [PATCH 4/6] ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai
 num_channels
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180704094944.16440-5-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

num_channels for slim dais are aready set int set_channel_map,
do not overwrite them in hw_params.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.16.2
