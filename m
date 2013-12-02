From: marex@denx.de (Marek Vasut)
Date: Mon,  2 Dec 2013 16:39:27 +0100
Subject: [PATCH 2/3] imx-drm: ipuv3-crtc: Make DISP_CLK polarity configurable
In-Reply-To: <1385998768-23512-1-git-send-email-marex@denx.de>
References: <1385998768-23512-1-git-send-email-marex@denx.de>
Message-ID: <1385998768-23512-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the LCD display clock polarity configurable via DT so in case
board needs different DISP_CLK clock polarity, it can use the 'pixelclk-active'
DT prop to do such adjustment.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/staging/imx-drm/ipuv3-crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index ce6ba98..1d8223e 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -157,7 +157,7 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 		sig_cfg.Vsync_pol = 1;
 
 	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 1;
+	sig_cfg.clk_pol = !!(mode->flags & DRM_MODE_FLAG_PIXELCLK_NPOL);
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
-- 
1.8.4.2
