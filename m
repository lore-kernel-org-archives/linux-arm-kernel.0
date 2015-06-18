From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 18 Jun 2015 15:49:26 +0800
Subject: [PATCH 2/6] drm/rockchip: vop: optimize virtual stride calculate
In-Reply-To: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
References: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1434613770-6608-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vir_stride need number words of the virtual width, and fb->pitches
save bytes_per_pixel, so just div 4 switch to stride.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
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
