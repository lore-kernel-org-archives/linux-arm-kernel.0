From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 26 Jan 2015 09:22:17 -0700
Subject: [PATCH 1/9] coresight: fix the replicator subtype value
In-Reply-To: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422289345-2084-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

According to the classification, the type of replicator
is link, so the subtype should also be link_subtype.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-replicator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-replicator.c b/drivers/coresight/coresight-replicator.c
index a2dfcf903551..cdf05537d574 100644
--- a/drivers/coresight/coresight-replicator.c
+++ b/drivers/coresight/coresight-replicator.c
@@ -87,7 +87,7 @@ static int replicator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	desc->type = CORESIGHT_DEV_TYPE_LINK;
-	desc->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
+	desc->subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc->ops = &replicator_cs_ops;
 	desc->pdata = pdev->dev.platform_data;
 	desc->dev = &pdev->dev;
-- 
1.9.1
