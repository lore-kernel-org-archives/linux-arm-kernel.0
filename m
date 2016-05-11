From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 22:11:07 +0200
Subject: [PATCH] drm: mediatek: remove IOMMU_DMA select
In-Reply-To: <1462982509-342936-1-git-send-email-arnd@arndb.de>
References: <1462982509-342936-1-git-send-email-arnd@arndb.de>
Message-ID: <1462997501-982363-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a harmless build warning when trying to use the mediatek
DRM driver with IOMMU support disabled:

warning: (DRM_MEDIATEK) selects IOMMU_DMA which has unmet direct dependencies (IOMMU_SUPPORT)

However, the IOMMU_DMA symbol is not meant to be used by drivers
at all, and this driver doesn't seem to have a strict dependency
on it other than using the mediatek IOMMU driver that does.

Since we also want to be able to do compile tests with the
driver on other platforms, the IOMMU_DMA symbol should not
be selected here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If someone has a better explanation about why the 'select' is here,
let me know, it certainly seems out of place.

 drivers/gpu/drm/mediatek/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 0c06a69d7f04..545973f6b743 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -7,7 +7,6 @@ config DRM_MEDIATEK
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
-	select IOMMU_DMA
 	select MEMORY
 	select MTK_SMI
 	help
-- 
2.7.0
