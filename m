From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 22 Jan 2018 12:42:59 -0500
Subject: [PATCH] drm/sun4i: Fix build warnings in sunxi_engine.h
Message-ID: <20180122174306.231609-1-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following build warnings:
In file included from ../drivers/gpu/drm/sun4i/sun8i_mixer.h:18:0,
                 from ../drivers/gpu/drm/sun4i/sun8i_vi_scaler.h:13,
                 from ../drivers/gpu/drm/sun4i/sun8i_vi_scaler.c:12:
../drivers/gpu/drm/sun4i/sunxi_engine.h:36:16: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
         struct drm_crtc_state *old_state);
                ^~~~~~~~~~~~~~
../drivers/gpu/drm/sun4i/sunxi_engine.h:53:15: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
        struct drm_crtc_state *state);
               ^~~~~~~~~~~~~~
In file included from ../drivers/gpu/drm/sun4i/sun8i_mixer.h:18:0,
                 from ../drivers/gpu/drm/sun4i/sun8i_ui_scaler.h:12,
                 from ../drivers/gpu/drm/sun4i/sun8i_ui_scaler.c:12:
../drivers/gpu/drm/sun4i/sunxi_engine.h:36:16: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
         struct drm_crtc_state *old_state);
                ^~~~~~~~~~~~~~
../drivers/gpu/drm/sun4i/sunxi_engine.h:53:15: warning: ?struct drm_crtc_state? declared inside parameter list will not be visible outside of this definition or declaration
        struct drm_crtc_state *state);
               ^~~~~~~~~~~~~~

Fixes: 6b8562c86e24 ("drm/sun4i: engine: Create an atomic_begin
callback")
Fixes: 656e5f654903 ("drm/sun4i: engine: Add a custom crtc
atomic_check")
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/sun4i/sunxi_engine.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index baa7a1f95300..d317ea04b8aa 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -12,6 +12,7 @@
 
 struct drm_plane;
 struct drm_device;
+struct drm_crtc_state;
 
 struct sunxi_engine;
 
-- 
2.16.0.rc1.238.g530d649a79-goog
