From: Ying.Liu@freescale.com (Liu Ying)
Date: Mon, 10 Feb 2014 18:29:45 +0800
Subject: [PATCH] staging: drm/imx: remove an unnecessary local variable
Message-ID: <1392028185-4528-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes an unnecessary local variable defined
in the function imx_drm_driver_unload() so as to fix the
following build warning.

drivers/staging/imx-drm/imx-drm-core.c: \
In function ?imx_drm_driver_unload?:
drivers/staging/imx-drm/imx-drm-core.c:87:25: \
warning: unused variable ?imxdrm? [-Wunused-variable]

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/staging/imx-drm/imx-drm-core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 236ed66..573fe88 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -84,8 +84,6 @@ static void imx_drm_driver_lastclose(struct drm_device *drm)
 
 static int imx_drm_driver_unload(struct drm_device *drm)
 {
-	struct imx_drm_device *imxdrm = drm->dev_private;
-
 	imx_drm_device_put();
 
 	drm_vblank_cleanup(drm);
-- 
1.7.9.5
