From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Apr 2017 23:25:03 +0800
Subject: [PATCH 1/3] drm/sun4i: Drop unused tcon pointer
In-Reply-To: <20170425152505.6796-1-wens@csie.org>
References: <20170425152505.6796-1-wens@csie.org>
Message-ID: <20170425152505.6796-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i DRM driver now uses 2 lists to track backends and tcons.
During the switch, the original tcon pointer was not removed.

As it is now unused, remove it, so other new drivers can't accidentally
use it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

As mentioned in the cover letter, please squash this into the patch

    drm/sun4i: Use lists to track registered display backends and TCONs

---
 drivers/gpu/drm/sun4i/sun4i_drv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
index 835bdb5cc0c2..250c29017ef5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.h
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
@@ -20,7 +20,6 @@
 struct sun4i_drv {
 	struct list_head	backend_list;
 	struct list_head	tcon_list;
-	struct sun4i_tcon	*tcon;
 
 	struct drm_fbdev_cma	*fbdev;
 };
-- 
2.11.0
