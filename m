From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 10:41:29 +0100
Subject: [PATCH] drm: tilcdc: fix a DT property parsing
Message-ID: <1479807689-23804-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT binding for tildc is not consistent with the driver code - the
option in the binding is called 'max-width' while the code expects
'ti,max-width'.

Make the driver code consistent with the binding.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index a7c91f7..4d3adf8e 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -302,7 +302,7 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 
 	DBG("Maximum Bandwidth Value %d", priv->max_bandwidth);
 
-	if (of_property_read_u32(node, "ti,max-width", &priv->max_width))
+	if (of_property_read_u32(node, "max-width", &priv->max_width))
 		priv->max_width = TILCDC_DEFAULT_MAX_WIDTH;
 
 	DBG("Maximum Horizontal Pixel Width Value %dpixels", priv->max_width);
-- 
2.9.3
