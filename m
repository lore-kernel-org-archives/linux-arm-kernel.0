From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 27 Apr 2017 21:47:38 +0200
Subject: [PATCH 2/2] of_coresight: Use devm_kcalloc() in
 of_coresight_alloc_memory()
In-Reply-To: <52619d05-65c4-149d-f355-cf9c037a0c9b@users.sourceforge.net>
References: <52619d05-65c4-149d-f355-cf9c037a0c9b@users.sourceforge.net>
Message-ID: <f053b2f8-9c35-a5fc-5260-dfee273faf53@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 27 Apr 2017 21:29:12 +0200

Multiplications for the size determination of memory allocations
indicated that array data structures should be processed.
Thus use the corresponding function "devm_kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hwtracing/coresight/of_coresight.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 09142e99e915..1e622912cd0f 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -78,21 +78,21 @@ static int of_coresight_alloc_memory(struct device *dev,
 			struct coresight_platform_data *pdata)
 {
 	/* List of output port on this component */
-	pdata->outports = devm_kzalloc(dev, pdata->nr_outport *
+	pdata->outports = devm_kcalloc(dev, pdata->nr_outport,
 				       sizeof(*pdata->outports),
 				       GFP_KERNEL);
 	if (!pdata->outports)
 		return -ENOMEM;
 
 	/* Children connected to this component via @outports */
-	pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
+	pdata->child_names = devm_kcalloc(dev, pdata->nr_outport,
 					  sizeof(*pdata->child_names),
 					  GFP_KERNEL);
 	if (!pdata->child_names)
 		return -ENOMEM;
 
 	/* Port number on the child this component is connected to */
-	pdata->child_ports = devm_kzalloc(dev, pdata->nr_outport *
+	pdata->child_ports = devm_kcalloc(dev, pdata->nr_outport,
 					  sizeof(*pdata->child_ports),
 					  GFP_KERNEL);
 	if (!pdata->child_ports)
-- 
2.12.2
