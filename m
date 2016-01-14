From: john@metanate.com (John Keeping)
Date: Thu, 14 Jan 2016 14:39:42 +0000
Subject: [PATCH 3/3] drm/rockchip: explain why we can't wait_for_vblanks
In-Reply-To: <cover.1452782114.git.john@metanate.com>
References: <cover.1452782114.git.john@metanate.com>
Message-ID: <107bbc36a316ed0ddc7b5a8bcd9b6db6cbc71d4f.1452782114.git.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 679d23a..b267ce4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -177,6 +177,12 @@ static void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
 		crtc_funcs->wait_for_update(crtc);
 }
 
+/*
+ * We can't use drm_atomic_helper_wait_for_vblanks() because rk3288 and rk3066
+ * have hardware counters for neither vblanks nor scanlines.  This function is
+ * equivalent but uses rockchip_crtc_wait_for_update() instead of waiting for
+ * vblank_count to change.
+ */
 static void
 rockchip_atomic_wait_for_complete(struct drm_device *dev, struct drm_atomic_state *old_state)
 {
-- 
2.7.0.226.gfe986fe
