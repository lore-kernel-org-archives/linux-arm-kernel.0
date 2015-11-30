From: luisbg@osg.samsung.com (Luis de Bethencourt)
Date: Mon, 30 Nov 2015 14:56:56 +0000
Subject: [PATCH] drm/rockchip: Fix module autoload for OF platform driver
Message-ID: <1448895416-9502-1-git-send-email-luisbg@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hi,

This is a Resend of a patch from October 20th [0]

I am adding Andrew Morton to the CC list as was recommended at the Korea Linux
Forum.

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519
A multitude of similar patches have been merged for other drivers, search
the git log for "module autoload for OF platform driver".

Thanks,
Luis

[0] https://lkml.org/lkml/2015/10/20/485

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
2.5.3
