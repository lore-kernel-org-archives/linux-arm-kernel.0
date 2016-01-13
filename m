From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 13 Jan 2016 16:22:08 +0800
Subject: [PATCH 2/2] drm/rockchip: cleanup unnecessary export symbol
In-Reply-To: <1452673328-29188-1-git-send-email-mark.yao@rock-chips.com>
References: <1452673328-29188-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1452673328-29188-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now rockchip_drm_vop.c is build into rockchipdrm.ko, so
no need to export following symbol anymore:
    rockchip_drm_dma_attach_device
    rockchip_drm_dma_detach_device
    rockchip_drm_dma_attach_device
    rockchip_drm_dma_detach_device
    rockchip_register_crtc_funcs
    rockchip_unregister_crtc_funcs
    rockchip_fb_get_gem_obj

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    4 ----
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |    1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 8397d1b..a0d51cc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -55,14 +55,12 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 
 	return arm_iommu_attach_device(dev, mapping);
 }
-EXPORT_SYMBOL_GPL(rockchip_drm_dma_attach_device);
 
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev)
 {
 	arm_iommu_detach_device(dev);
 }
-EXPORT_SYMBOL_GPL(rockchip_drm_dma_detach_device);
 
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 				 const struct rockchip_crtc_funcs *crtc_funcs)
@@ -77,7 +75,6 @@ int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rockchip_register_crtc_funcs);
 
 void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc)
 {
@@ -89,7 +86,6 @@ void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc)
 
 	priv->crtc_funcs[pipe] = NULL;
 }
-EXPORT_SYMBOL_GPL(rockchip_unregister_crtc_funcs);
 
 static struct drm_crtc *rockchip_crtc_from_pipe(struct drm_device *drm,
 						int pipe)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index f784488..dd1f8d3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -39,7 +39,6 @@ struct drm_gem_object *rockchip_fb_get_gem_obj(struct drm_framebuffer *fb,
 
 	return rk_fb->obj[plane];
 }
-EXPORT_SYMBOL_GPL(rockchip_fb_get_gem_obj);
 
 static void rockchip_drm_fb_destroy(struct drm_framebuffer *fb)
 {
-- 
1.7.9.5
