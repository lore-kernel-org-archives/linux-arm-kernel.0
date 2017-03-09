From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Mar 2017 18:05:25 +0800
Subject: [PATCH 02/11] drm/sun4i: Fix tcon channel 0 comment about backporch =
 backporch + hsync
In-Reply-To: <20170309100534.14023-1-wens@csie.org>
References: <20170309100534.14023-1-wens@csie.org>
Message-ID: <20170309100534.14023-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The backporch programmed into the tcon registers is actually the
backporch + hsync length from the display timings, as indicated in
the interface timing diagrams found in the user manual of the A31
and A33 SoCs.

The comments for channel 0 mistakenly describe the discrepancy as
TCON backporch = frontporch + hsync.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index ee51d7e77a6a..c52c482c8fd0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -143,7 +143,7 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 
 	/*
 	 * This is called a backporch in the register documentation,
-	 * but it really is the front porch + hsync
+	 * but it really is the back porch + hsync
 	 */
 	bp = mode->crtc_htotal - mode->crtc_hsync_start;
 	DRM_DEBUG_DRIVER("Setting horizontal total %d, backporch %d\n",
@@ -156,7 +156,7 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 
 	/*
 	 * This is called a backporch in the register documentation,
-	 * but it really is the front porch + hsync
+	 * but it really is the back porch + hsync
 	 */
 	bp = mode->crtc_vtotal - mode->crtc_vsync_start;
 	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
-- 
2.11.0
