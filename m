From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 19 Feb 2014 13:28:13 +0800
Subject: [PATCH 1/1] imx-drm: imx-drm-core: fix the build warning
Message-ID: <1392787693-12539-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/home/b29397/work/projects/upstream/usb/usb/drivers/staging/imx-drm/imx-drm-core.c: In function 'imx_drm_driver_unload':
/home/b29397/work/projects/upstream/usb/usb/drivers/staging/imx-drm/imx-drm-core.c:87:25: warning: unused variable 'imxdrm' [-Wunused-variable]

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/staging/imx-drm/imx-drm-core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

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
1.7.8
