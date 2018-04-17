From: hjc@rock-chips.com (Sandy Huang)
Date: Tue, 17 Apr 2018 18:15:07 +0800
Subject: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
Message-ID: <1523960108-190541-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When video width is bigger than 3840 the linebuffer mode
should be LB_YUV_3840X5.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 56bbd2e..3e7501b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -332,7 +332,7 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
 
 	if (width > 2560)
 		lb_mode = LB_RGB_3840X2;
-	else if (width > 1920)
+	else if (!is_yuv && width > 1920)
 		lb_mode = LB_RGB_2560X4;
 	else if (!is_yuv)
 		lb_mode = LB_RGB_1920X5;
-- 
2.7.4
