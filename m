From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 25 Jun 2018 15:31:15 +0100
Subject: [PATCH 11/11] ASoC: qdsp6: q6routing: add proper error check
In-Reply-To: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180625143115.8346-12-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

q6adm_open can return error pointer or a null in error cases.
Fix this check this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index caf2f847a886..c18f808c7730 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -310,7 +310,7 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
 			      session->channels, topology, perf_mode,
 			      session->bits_per_sample, 0, 0);
 
-	if (!copp) {
+	if (IS_ERR_OR_NULL(copp)) {
 		mutex_unlock(&routing_data->lock);
 		return -EINVAL;
 	}
-- 
2.16.2
