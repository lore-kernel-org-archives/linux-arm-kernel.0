From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 23:13:59 +0800
Subject: [PATCH 1/4] drm/sun4i: rgb: Declare RGB encoder and connector as MIPI
 DPI
In-Reply-To: <20160915151402.15992-1-wens@csie.org>
References: <20160915151402.15992-1-wens@csie.org>
Message-ID: <20160915151402.15992-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 18 or 24 bit parallel RGB LCD panel interface found on Allwinner
SoCs matches the description of MIPI DPI. Declare the RGB encoder and
connector as MIPI DPI.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index c3ff10f559cc..8b520d9f5bd9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -240,7 +240,7 @@ int sun4i_rgb_init(struct drm_device *drm)
 	ret = drm_encoder_init(drm,
 			       &rgb->encoder,
 			       &sun4i_rgb_enc_funcs,
-			       DRM_MODE_ENCODER_NONE,
+			       DRM_MODE_ENCODER_DPI,
 			       NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialise the rgb encoder\n");
@@ -255,7 +255,7 @@ int sun4i_rgb_init(struct drm_device *drm)
 					 &sun4i_rgb_con_helper_funcs);
 		ret = drm_connector_init(drm, &rgb->connector,
 					 &sun4i_rgb_con_funcs,
-					 DRM_MODE_CONNECTOR_Unknown);
+					 DRM_MODE_CONNECTOR_DPI);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't initialise the rgb connector\n");
 			goto err_cleanup_connector;
-- 
2.9.3
