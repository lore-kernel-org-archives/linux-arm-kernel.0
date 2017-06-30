From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 30 Jun 2017 11:41:59 -0600
Subject: [PATCH 5/5] coresight: etm3x: Set synchronisation frequencty to TRM
 default
In-Reply-To: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
References: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1498844519-8845-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register ETMSYNCFR holds the number of by that need to be generated before
periodic synchronisation packets are inserted in the trace stream.  By
zeroing out the config structure, the current code effectively disable
periodic synchronization.

This patch simply initialise the recommended value for this register as
specified in the technical reference manual.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index a51b6b64ecdf..b67122acea7a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -243,6 +243,8 @@ void etm_set_default(struct etm_config *config)
 	}
 
 	config->ctxid_mask = 0x0;
+	/* Setting default to 1024 as per TRM recommendation */
+	config->sync_freq = 0x400;
 }
 
 void etm_config_trace_mode(struct etm_config *config)
-- 
2.7.4
