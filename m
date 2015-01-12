From: xiakaixu@huawei.com (Kaixu Xia)
Date: Mon, 12 Jan 2015 16:32:26 +0800
Subject: [PATCH] coresight: fix the replicator subtype value
Message-ID: <1421051546-60429-1-git-send-email-xiakaixu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the classification, the type of replicator
is link, so the subtype should also be link_subtype.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
---
 drivers/coresight/coresight-replicator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-replicator.c b/drivers/coresight/coresight-replicator.c
index a2dfcf9..cdf0553 100644
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
1.8.5.5
