From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  3 May 2016 11:33:42 -0600
Subject: [PATCH 08/27] coresight: etm4x: add tracer ID for A72 Maia processor.
In-Reply-To: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1462296841-12327-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: lipengcheng <lipengcheng8@huawei.com>

This patch adds a cellID for the ETMv4 tracer found on
HiSillicon's A72 Maia processor.

Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 6396b28993da..462f0dc15757 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -825,6 +825,11 @@ static struct amba_id etm4_ids[] = {
 		.mask	= 0x000fffff,
 		.data	= "ETM 4.0",
 	},
+	{       /* ETM 4.0 - A72, Maia, HiSilicon */
+		.id = 0x000bb95a,
+		.mask = 0x000fffff,
+		.data = "ETM 4.0",
+	},
 	{ 0, 0},
 };
 
-- 
2.5.0
