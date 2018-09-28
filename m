From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 28 Sep 2018 10:39:40 +0000
Subject: [PATCH -next] drm/stm: ltdc: remove set but not used variable 'src_h'
Message-ID: <1538131180-34108-1-git-send-email-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/stm/ltdc.c: In function 'ltdc_plane_atomic_check':
drivers/gpu/drm/stm/ltdc.c:694:13: warning:
 variable 'src_y' set but not used [-Wunused-but-set-variable]
  u32 src_x, src_y, src_w, src_h;
             ^
             ^
drivers/gpu/drm/stm/ltdc.c:694:6: warning:
 variable 'src_x' set but not used [-Wunused-but-set-variable]
  u32 src_x, src_y, src_w, src_h;
      ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/stm/ltdc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661..a91e041 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -691,7 +691,7 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
 				   struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	u32 src_x, src_y, src_w, src_h;
+	u32 src_w, src_h;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -699,8 +699,6 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
 		return 0;
 
 	/* convert src_ from 16:16 format */
-	src_x = state->src_x >> 16;
-	src_y = state->src_y >> 16;
 	src_w = state->src_w >> 16;
 	src_h = state->src_h >> 16;
 
