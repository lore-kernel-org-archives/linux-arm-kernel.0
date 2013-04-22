From: marex@denx.de (Marek Vasut)
Date: Mon, 22 Apr 2013 23:28:30 +0200
Subject: [RFC][PATCH] video: imx: Select VIDEOMODE_HELPERS
Message-ID: <1366666110-9585-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, I get the following problem when building kernel:

drivers/built-in.o: In function `imx_pd_connector_get_modes':
/linux-2.6/drivers/staging/imx-drm/parallel-display.c:78: undefined reference to `of_get_drm_display_mode'
make: *** [vmlinux] Error 1

NOTE: I think this patch is almost absolutely not correct.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/imx-drm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/imx-drm/Kconfig b/drivers/staging/imx-drm/Kconfig
index 8c9e403..5ad9165 100644
--- a/drivers/staging/imx-drm/Kconfig
+++ b/drivers/staging/imx-drm/Kconfig
@@ -1,6 +1,7 @@
 config DRM_IMX
 	tristate "DRM Support for Freescale i.MX"
 	select DRM_KMS_HELPER
+	select VIDEOMODE_HELPERS
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
 	depends on DRM && (ARCH_MXC || ARCH_MULTIPLATFORM)
-- 
1.7.10.4
