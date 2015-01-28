From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:48:07 +0100
Subject: [PATCH 3/5] drm: rockchip: add reset controller dependency
In-Reply-To: <1422452889-415782-1-git-send-email-arnd@arndb.de>
References: <1422452889-415782-1-git-send-email-arnd@arndb.de>
Message-ID: <1422452889-415782-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the reset controller subsystem is disabled, this driver
fails to build:

drivers/gpu/drm/rockchip/rockchip_drm_vop.c: In function 'vop_initial':
drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1267:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]

The easiest solution is to add a dependency in Kconfig to avoid
that case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index cb21e3821244..35215f6867d3 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -1,6 +1,7 @@
 config DRM_ROCKCHIP
 	tristate "DRM Support for Rockchip"
 	depends on DRM && ROCKCHIP_IOMMU
+	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	select DRM_PANEL
-- 
2.1.0.rc2
