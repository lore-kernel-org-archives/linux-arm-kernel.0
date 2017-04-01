From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat,  1 Apr 2017 18:44:00 +0800
Subject: [PATCH 7/9] drm/rockchip: Force disable all crtc when unload
In-Reply-To: <1491043442-20626-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491043442-20626-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1491043442-20626-8-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index a5d83cb..5dbf011 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -246,6 +246,7 @@ static void rockchip_drm_unbind(struct device *dev)
 	rockchip_drm_fbdev_fini(drm_dev);
 	drm_kms_helper_poll_fini(drm_dev);
 
+	drm_crtc_force_disable_all(drm_dev);
 	drm_vblank_cleanup(drm_dev);
 	component_unbind_all(dev, drm_dev);
 	drm_mode_config_cleanup(drm_dev);
-- 
2.1.4
