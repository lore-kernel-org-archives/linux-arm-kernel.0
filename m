From: marex@denx.de (Marek Vasut)
Date: Wed, 24 Apr 2013 20:43:59 +0200
Subject: [PATCH V2] video: imx: Select VIDEOMODE_HELPERS for parallel display
Message-ID: <1366829039-12452-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, I get the following problem when building kernel:

drivers/built-in.o: In function `imx_pd_connector_get_modes':
/linux-2.6/drivers/staging/imx-drm/parallel-display.c:78: undefined reference to `of_get_drm_display_mode'
make: *** [vmlinux] Error 1

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/imx-drm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

V2: Select VIDEOMODE_HELPERS only for parallel display

diff --git a/drivers/staging/imx-drm/Kconfig b/drivers/staging/imx-drm/Kconfig
index 8c9e403..0550f01 100644
--- a/drivers/staging/imx-drm/Kconfig
+++ b/drivers/staging/imx-drm/Kconfig
@@ -19,6 +19,7 @@ config DRM_IMX_FB_HELPER
 config DRM_IMX_PARALLEL_DISPLAY
 	tristate "Support for parallel displays"
 	depends on DRM_IMX
+	select VIDEOMODE_HELPERS
 
 config DRM_IMX_TVE
 	tristate "Support for TV and VGA displays"
-- 
1.7.10.4
