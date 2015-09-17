From: luis@debethencourt.com (Luis de Bethencourt)
Date: Thu, 17 Sep 2015 16:22:09 +0200
Subject: [PATCH 4/5] drm/rockchip: Fix module autoload for OF platform driver
Message-ID: <20150917142209.GA20192@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5d8ae5e..5897851 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -374,6 +374,7 @@ static const struct of_device_id vop_driver_dt_match[] = {
 	  .data = &rk3288_vop },
 	{},
 };
+MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
 
 static inline void vop_writel(struct vop *vop, uint32_t offset, uint32_t v)
 {
-- 
2.4.6
