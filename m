From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 18:04:33 +0200
Subject: [PATCH 2/7] staging: drm/imx: ipuv3-crtc: use external clock for TV
 Encoder
In-Reply-To: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
References: <1365437078-22579-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1365437078-22579-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipuv3-crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index b028b0d..620e571 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -413,6 +413,8 @@ static int ipu_set_interface_pix_fmt(struct drm_crtc *crtc, u32 encoder_type,
 	ipu_crtc->interface_pix_fmt = pixfmt;
 
 	switch (encoder_type) {
+	case DRM_MODE_ENCODER_DAC:
+	case DRM_MODE_ENCODER_TVDAC:
 	case DRM_MODE_ENCODER_LVDS:
 		ipu_crtc->di_clkflags = IPU_DI_CLKMODE_SYNC |
 			IPU_DI_CLKMODE_EXT;
-- 
1.8.2.rc2
