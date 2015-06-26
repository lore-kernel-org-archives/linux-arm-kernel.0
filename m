From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 26 Jun 2015 18:07:25 +0800
Subject: [PATCH v2 1/5] drm/rockchip: vop: optimize virtual stride calculate
In-Reply-To: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1435313249-4549-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vir_stride need number words of the virtual width, and fb->pitches
save bytes_per_pixel, so just div 4 switch to stride.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 6188221..3c9f4f3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -644,7 +644,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
 	offset += (src.y1 >> 16) * fb->pitches[0];
 	yrgb_mst = rk_obj->dma_addr + offset;
 
-	y_vir_stride = fb->pitches[0] / (fb->bits_per_pixel >> 3);
+	y_vir_stride = fb->pitches[0] >> 2;
 
 	/*
 	 * If this plane update changes the plane's framebuffer, (or more
-- 
1.7.9.5
