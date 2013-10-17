From: denis@eukrea.com (Denis Carikli)
Date: Thu, 17 Oct 2013 17:02:10 +0200
Subject: [Patch v2][ 12/37] staging: imx-drm: ipuv3-crtc: don't harcode some
 mode flags.
In-Reply-To: <1382022155-21954-1-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
Message-ID: <1382022155-21954-13-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed for making the eukrea-cpuimx51
  QVGA display work.

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driverdev-devel at linuxdriverproject.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/staging/imx-drm/ipuv3-crtc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 6fd37a7..9279294 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -236,9 +236,11 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
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
