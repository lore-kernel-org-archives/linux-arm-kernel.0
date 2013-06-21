From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:57:18 +0200
Subject: [PATCH 1/4] staging: drm/imx: remove unused variables
In-Reply-To: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
References: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1371805041-9299-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 3 ---
 drivers/staging/imx-drm/ipuv3-crtc.c   | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 6455305..56d6bc4 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -491,7 +491,6 @@ int imx_drm_add_crtc(struct drm_crtc *crtc,
 {
 	struct imx_drm_device *imxdrm = __imx_drm_device();
 	struct imx_drm_crtc *imx_drm_crtc;
-	const struct drm_crtc_funcs *crtc_funcs;
 	int ret;
 
 	mutex_lock(&imxdrm->mutex);
@@ -512,8 +511,6 @@ int imx_drm_add_crtc(struct drm_crtc *crtc,
 	imx_drm_crtc->cookie.cookie = cookie;
 	imx_drm_crtc->cookie.id = id;
 
-	crtc_funcs = imx_drm_helper_funcs->crtc_funcs;
-
 	imx_drm_crtc->crtc = crtc;
 	imx_drm_crtc->imxdrm = imxdrm;
 
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index ff5c633..abcdaef 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -22,7 +22,6 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <drm/drmP.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <linux/fb.h>
 #include <linux/clk.h>
@@ -42,9 +41,6 @@ struct ipu_framebuffer {
 };
 
 struct ipu_crtc {
-	struct drm_fb_helper	fb_helper;
-	struct ipu_framebuffer	ifb;
-	int			num_crtcs;
 	struct device		*dev;
 	struct drm_crtc		base;
 	struct imx_drm_crtc	*imx_crtc;
@@ -54,7 +50,6 @@ struct ipu_crtc {
 	struct dmfc_channel	*dmfc;
 	struct ipu_di		*di;
 	int			enabled;
-	struct ipu_priv		*ipu_priv;
 	struct drm_pending_vblank_event *page_flip_event;
 	struct drm_framebuffer	*newfb;
 	int			irq;
-- 
1.8.3.1
