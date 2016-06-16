From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2016 14:27:57 +0200
Subject: [PATCH] drm: rockchip: select DRM_GEM_CMA_HELPER
Message-ID: <20160616122800.1174015-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rockchip drm driver started using drm_gem_cma_vm_ops, but that might
not be part of the kernel, causing the link to fail:

drivers/gpu/built-in.o:(.data+0xb234): undefined reference to `drm_gem_cma_vm_ops'

This adds a Kconfig 'select' statement to enable it like the other
user do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 80f67cd80add ("drm/rockchip: Use cma gem vm ops")
---
 drivers/gpu/drm/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index d30bdc38a760..e48611e83c03 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -2,6 +2,7 @@ config DRM_ROCKCHIP
 	tristate "DRM Support for Rockchip"
 	depends on DRM && ROCKCHIP_IOMMU
 	depends on RESET_CONTROLLER
+	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	select DRM_PANEL
-- 
2.9.0
