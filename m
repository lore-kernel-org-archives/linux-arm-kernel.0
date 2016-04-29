From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 29 Apr 2016 15:42:17 +0800
Subject: [PATCH] drm/rockchip: vop: Initialize vskiplines to zero
Message-ID: <1461915737-23156-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a path that use vskiplines with non-initialize.
That would cause vop abnormal behavior.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 8652bb1..bf55cda 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -310,7 +310,7 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint16_t vsu_mode;
 	uint16_t lb_mode;
 	uint32_t val;
-	int vskiplines;
+	int vskiplines = 0;
 
 	if (dst_w > 3840) {
 		DRM_ERROR("Maximum destination width (3840) exceeded\n");
-- 
1.9.1
