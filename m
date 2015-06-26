From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 26 Jun 2015 18:07:28 +0800
Subject: [PATCH v2 4/5] drm/rockchip: vop: switch cursor plane to window 3
In-Reply-To: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1435313249-4549-5-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Window 1 support scale and yuv format, it's waste use it for a
cursor, use window 3 is enough.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f6ef634..40107bb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -342,13 +342,14 @@ static const struct vop_reg_data vop_init_reg_table[] = {
 /*
  * Note: rk3288 has a dedicated 'cursor' window, however, that window requires
  * special support to get alpha blending working.  For now, just use overlay
- * window 1 for the drm cursor.
+ * window 3 for the drm cursor.
+ *
  */
 static const struct vop_win_data rk3288_vop_win_data[] = {
 	{ .base = 0x00, .phy = &win01_data, .type = DRM_PLANE_TYPE_PRIMARY },
-	{ .base = 0x40, .phy = &win01_data, .type = DRM_PLANE_TYPE_CURSOR },
+	{ .base = 0x40, .phy = &win01_data, .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x00, .phy = &win23_data, .type = DRM_PLANE_TYPE_OVERLAY },
-	{ .base = 0x50, .phy = &win23_data, .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x50, .phy = &win23_data, .type = DRM_PLANE_TYPE_CURSOR },
 	{ .base = 0x00, .phy = &cursor_data, .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
-- 
1.7.9.5
