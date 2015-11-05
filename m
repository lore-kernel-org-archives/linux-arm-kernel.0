From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  5 Nov 2015 20:15:27 +0900
Subject: [RFC PATCH 6/7] drm/rockchip: remove redundant "depends on
 RESET_CONTROLLER"
In-Reply-To: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1446722128-11961-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_ROCKCHIP selects RESET_CONTROLLER.
The dependency "depends on RESET_CONTROLLER" is already met.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 35215f6..cb21e38 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -1,7 +1,6 @@
 config DRM_ROCKCHIP
 	tristate "DRM Support for Rockchip"
 	depends on DRM && ROCKCHIP_IOMMU
-	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	select DRM_PANEL
-- 
1.9.1
