From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 17 Aug 2017 14:55:04 +0300
Subject: [PATCH] staging: fsl-mc: be consistent when checking strcmp() returns
Message-ID: <20170817115504.4308-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Throughout the driver we use == 0 / != 0 to check strcmp() returns except
this place, so fix it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dprc-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index 485abad..06df528 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -29,7 +29,7 @@ static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
 				struct fsl_mc_obj_desc *obj_desc)
 {
 	return mc_dev->obj_desc.id == obj_desc->id &&
-	       !strcmp(mc_dev->obj_desc.type, obj_desc->type);
+	       strcmp(mc_dev->obj_desc.type, obj_desc->type) == 0;
 
 }
 
-- 
2.9.4
