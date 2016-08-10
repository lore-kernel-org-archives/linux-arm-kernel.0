From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 23:54:10 +0200
Subject: [PATCH 4/9] drm/mediatek: add CONFIG_OF dependency
In-Reply-To: <20160810215424.1926658-1-arnd@arndb.de>
References: <20160810215424.1926658-1-arnd@arndb.de>
Message-ID: <20160810215424.1926658-5-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mediatek DRM driver can be configured for compile testing with
CONFIG_OF disabled, but then fails to link:

drivers/gpu/built-in.o: In function `mtk_drm_bind':
analogix_dp_reg.c:(.text+0x52888): undefined reference to `of_find_device_by_node'
analogix_dp_reg.c:(.text+0x52930): undefined reference to `of_find_device_by_node'

This adds an explicit Kconfig dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patchwork.kernel.org/patch/9120871/
---
I originally sent this on May 18 when the driver was newly added,
but my fix never made it.
---
 drivers/gpu/drm/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 5c2163737691..96ebf8bb6024 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -3,6 +3,7 @@ config DRM_MEDIATEK
 	depends on DRM
 	depends on ARCH_MEDIATEK || (ARM && COMPILE_TEST)
 	depends on COMMON_CLK
+	depends on OF
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
-- 
2.9.0
