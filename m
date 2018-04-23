From: peda@axentia.se (Peter Rosin)
Date: Mon, 23 Apr 2018 09:22:57 +0200
Subject: [PATCH v4 4/8] drm/i2c: tda998x: find the drm_device via the
 drm_connector
In-Reply-To: <20180423072301.11962-1-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
Message-ID: <20180423072301.11962-5-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares for being a drm_bridge which will not register the
encoder. That makes the connector the better choice.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index cd3f0873bbdd..8f6e013f2b87 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -630,7 +630,7 @@ static void tda998x_detect_work(struct work_struct *work)
 {
 	struct tda998x_priv *priv =
 		container_of(work, struct tda998x_priv, detect_work);
-	struct drm_device *dev = priv->encoder.dev;
+	struct drm_device *dev = priv->connector.dev;
 
 	if (dev)
 		drm_kms_helper_hotplug_event(dev);
-- 
2.11.0
