From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Apr 2017 23:25:05 +0800
Subject: [PATCH 3/3] drm/sun4i: backend: Clarify sun4i_backend_layer_enable
 debug message
In-Reply-To: <20170425152505.6796-1-wens@csie.org>
References: <20170425152505.6796-1-wens@csie.org>
Message-ID: <20170425152505.6796-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_backend_layer_enable can be called to enable or disable a layer.
However the debug message always says "Enable", which is confusing.

This patch makes the debug message vary according to the enable state.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index e9eca057ff35..e53107418add 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -73,7 +73,8 @@ void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 {
 	u32 val;
 
-	DRM_DEBUG_DRIVER("Enabling layer %d\n", layer);
+	DRM_DEBUG_DRIVER("%sabling layer %d\n", enable ? "En" : "Dis",
+			 layer);
 
 	if (enable)
 		val = SUN4I_BACKEND_MODCTL_LAY_EN(layer);
-- 
2.11.0
