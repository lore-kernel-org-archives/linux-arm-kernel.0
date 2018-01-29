From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jan 2018 10:55:31 +0100
Subject: [PATCH] drm/bridge: Rename argument from crtc to bridge
Message-ID: <20180129095531.4557-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why is the argument to ->mode_valid() called "crtc"?
I guess a copy/paste error. Fix it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/drm/drm_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bb7b97dfb93e..3270fec46979 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -91,7 +91,7 @@ struct drm_bridge_funcs {
 	 *
 	 * drm_mode_status Enum
 	 */
-	enum drm_mode_status (*mode_valid)(struct drm_bridge *crtc,
+	enum drm_mode_status (*mode_valid)(struct drm_bridge *bridge,
 					   const struct drm_display_mode *mode);
 
 	/**
-- 
2.14.3
