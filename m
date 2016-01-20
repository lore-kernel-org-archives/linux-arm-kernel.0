From: eric.long@linaro.org (Eric Long)
Date: Wed, 20 Jan 2016 14:39:13 +0800
Subject: [RESEND PATCH 2/2] coresight: Remove the mistakes detected by smatch
 tool
In-Reply-To: <cover.1453271738.git.eric.long@linaro.org>
References: <cover.1453271738.git.eric.long@linaro.org>
Message-ID: <a9a6dbebe9fa624b3049c9de0b64462e4e1f1a80.1453271739.git.eric.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an unnecessary space at the front of the code.

The smatch tool output logs as the following:
of_coresight.c:89 of_coresight_alloc_memory() warn:
inconsistent indenting

Signed-off-by: Eric Long <eric.long@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index b097361..3cc57c1 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -86,7 +86,7 @@ static int of_coresight_alloc_memory(struct device *dev,
 		return -ENOMEM;
 
 	/* Children connected to this component via @outports */
-	 pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
+	pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
 					  sizeof(*pdata->child_names),
 					  GFP_KERNEL);
 	if (!pdata->child_names)
-- 
1.7.9.5
