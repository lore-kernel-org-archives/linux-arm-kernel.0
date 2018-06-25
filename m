From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 25 Jun 2018 15:31:11 +0100
Subject: [PATCH 07/11] ASoC: qdsp6: q6afe-dai: support dt based module loading
In-Reply-To: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180625143115.8346-8-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses new compatible string to make DT based module loading work.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 5002dd05bf27..7fbf762a45ac 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1290,9 +1290,17 @@ static int q6afe_dai_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id q6afe_dai_device_id[]  = {
+	{ .compatible = "qcom,q6afe-dais" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, q6afe_dai_device_id);
+
 static struct platform_driver q6afe_dai_platform_driver = {
 	.driver = {
 		.name = "q6afe-dai",
+		.of_match_table = of_match_ptr(q6afe_dai_device_id),
 	},
 	.probe = q6afe_dai_dev_probe,
 	.remove = q6afe_dai_dev_remove,
-- 
2.16.2
