From: peda@axentia.se (Peter Rosin)
Date: Wed,  2 May 2018 09:40:25 +0200
Subject: [PATCH 3/3] drm/exynos: hdmi: avoid duplicating drm_bridge_attach
In-Reply-To: <20180502074025.12421-1-peda@axentia.se>
References: <20180502074025.12421-1-peda@axentia.se>
Message-ID: <20180502074025.12421-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_bridge_attach takes care of these assignments, so there is no need
to open-code them a second time.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index abd84cbcf1c2..09c4bc0b1859 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -954,8 +954,6 @@ static int hdmi_create_connector(struct drm_encoder *encoder)
 	drm_mode_connector_attach_encoder(connector, encoder);
 
 	if (hdata->bridge) {
-		encoder->bridge = hdata->bridge;
-		hdata->bridge->encoder = encoder;
 		ret = drm_bridge_attach(encoder, hdata->bridge, NULL);
 		if (ret)
 			DRM_ERROR("Failed to attach bridge\n");
-- 
2.11.0
