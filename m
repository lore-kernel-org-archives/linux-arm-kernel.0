From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:29:01 +0100
Subject: [PATCH 3/6] staging: drm/imx: silence ipu_crtc_dpms debug message
In-Reply-To: <1352734144-14897-1-git-send-email-s.hauer@pengutronix.de>
References: <1352734144-14897-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352734144-14897-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

It's for debugging only, so use dev_dbg.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/staging/imx-drm/ipuv3-crtc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 78d3eda..7e85c59 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -116,7 +116,7 @@ static void ipu_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
 
-	dev_info(ipu_crtc->dev, "%s mode: %d\n", __func__, mode);
+	dev_dbg(ipu_crtc->dev, "%s mode: %d\n", __func__, mode);
 
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
-- 
1.7.10.4
