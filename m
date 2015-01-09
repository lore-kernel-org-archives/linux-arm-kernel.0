From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:21 -0700
Subject: [PATCH 10/11] coresight: fix comment in of_coresight.c
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

Outports is a member of the struct pdata and should be
a better choice.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/of_coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
index 8bd524e49518..89ebbe29ac97 100644
--- a/drivers/coresight/of_coresight.c
+++ b/drivers/coresight/of_coresight.c
@@ -93,7 +93,7 @@ static int of_coresight_alloc_memory(struct device *dev,
 	if (!pdata->outports)
 		return -ENOMEM;
 
-	/* Children connected to this component via @outport */
+	/* Children connected to this component via @outports */
 	 pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
 					  sizeof(*pdata->child_names),
 					  GFP_KERNEL);
-- 
1.9.1
