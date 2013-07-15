From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:57:01 +0200
Subject: [PATCH 16/22] staging: drm/imx: ipuv3-crtc: don't harcode some mode
 flags.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-17-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed for making the eukrea-cpuimx51
  QVGA display work.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/staging/imx-drm/ipuv3-crtc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 9176a81..19502d8 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -235,9 +235,11 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 		sig_cfg.Hsync_pol = 1;
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		sig_cfg.Vsync_pol = 1;
+	if (mode->flags & DRM_MODE_FLAG_PDATEN)
+		sig_cfg.enable_pol = 1;
+	if (mode->flags & DRM_MODE_FLAG_PPIXDATEDGE)
+		sig_cfg.clk_pol = 1;
 
-	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 0;
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
-- 
1.7.9.5
