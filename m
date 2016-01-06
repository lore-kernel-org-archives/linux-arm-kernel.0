From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  6 Jan 2016 11:19:24 +0100
Subject: [PATCH 3/8] drm: atmel-hlcdc: fix connector and encoder types
In-Reply-To: <1452075569-8545-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1452075569-8545-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1452075569-8545-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hlcdc IP keep the pixel stream in raw RGB mode, and does not provide
any specific connector. Since DRM_MODE_CONNECTOR_RAW_RGB does not exist,
use DRM_MODE_CONNECTOR_Unknown.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 0f7ec01..49494e9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -256,7 +256,7 @@ static int atmel_hlcdc_create_panel_output(struct drm_device *dev,
 			       &atmel_hlcdc_panel_encoder_helper_funcs);
 	ret = drm_encoder_init(dev, &panel->base.encoder,
 			       &atmel_hlcdc_panel_encoder_funcs,
-			       DRM_MODE_ENCODER_LVDS, NULL);
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
@@ -266,7 +266,7 @@ static int atmel_hlcdc_create_panel_output(struct drm_device *dev,
 				 &atmel_hlcdc_panel_connector_helper_funcs);
 	ret = drm_connector_init(dev, &panel->base.connector,
 				 &atmel_hlcdc_panel_connector_funcs,
-				 DRM_MODE_CONNECTOR_LVDS);
+				 DRM_MODE_CONNECTOR_Unknown);
 	if (ret)
 		goto err_encoder_cleanup;
 
-- 
2.1.4
