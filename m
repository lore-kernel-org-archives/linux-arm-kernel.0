From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 28 Nov 2016 12:37:23 +0100
Subject: [PATCH v2] drm: tilcdc: fix parsing of some DT properties
Message-ID: <1480333043-1292-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT binding for tildc is not consistent with the driver code: there
are two options - 'max-width' and 'max-pixelclock' specified in the
documentation which are parsed as 'ti,max-width' and
'ti'max-pixelclock' respectively.

Make the driver code consistent with the binding.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- fix max-pixelclock too

 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 5efb369..bd0a3bd 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -296,12 +296,12 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 
 	DBG("Maximum Bandwidth Value %d", priv->max_bandwidth);
 
-	if (of_property_read_u32(node, "ti,max-width", &priv->max_width))
+	if (of_property_read_u32(node, "max-width", &priv->max_width))
 		priv->max_width = TILCDC_DEFAULT_MAX_WIDTH;
 
 	DBG("Maximum Horizontal Pixel Width Value %dpixels", priv->max_width);
 
-	if (of_property_read_u32(node, "ti,max-pixelclock",
+	if (of_property_read_u32(node, "max-pixelclock",
 					&priv->max_pixelclock))
 		priv->max_pixelclock = TILCDC_DEFAULT_MAX_PIXELCLOCK;
 
-- 
2.9.3
