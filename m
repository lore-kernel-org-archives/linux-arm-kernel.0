From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 13 Feb 2015 16:36:25 +0100
Subject: [PATCH] drm: atmel-hlcdc: remove useless pm_runtime_put_sync in probe
Message-ID: <1423841785-23105-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove a useless pm_runtime_put_sync leading to unbalanced
usage_count.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 7320a6c..c1cb174 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -311,8 +311,6 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 
 	pm_runtime_enable(dev->dev);
 
-	pm_runtime_put_sync(dev->dev);
-
 	ret = atmel_hlcdc_dc_modeset_init(dev);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize mode setting\n");
-- 
1.9.1
