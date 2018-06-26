From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 26 Jun 2018 10:20:15 +0100
Subject: [PATCH v2 11/12] ASoC: qdsp6: q6routing: add proper error check
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180626092016.9296-12-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

q6adm_open can return error pointer or a null in error cases.
Fix the return handling.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index ab696bf8d1d3..c80fdbc2442e 100644
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
