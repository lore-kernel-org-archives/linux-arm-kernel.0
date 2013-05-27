From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Mon, 27 May 2013 10:19:09 +0200
Subject: [PATCH RESEND v2 1/3] staging: drm/imx: set correct sync pins for
 display
In-Reply-To: <1369642751-15555-1-git-send-email-list-09_linux_arm@tqsc.de>
References: <1369642751-15555-1-git-send-email-list-09_linux_arm@tqsc.de>
Message-ID: <1369642751-15555-2-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

partial fix of changes from
"staging: drm/imx: Add support for VGA via TVE on i.MX53"

Have to call imx_drm_crtc_panel_format_pins in imx_drm_crtc_panel_format
with the correct pins instead of (0, 0) This enables configuration of
correct waveforms for vsync / hsync for parallel display, LDB (i.MX53 and
i.MX6) as well as HDMI and MIPI (i.MX6)

TODO: configure pins via device tree

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
---
V2:
  changed patch as suggested by Philipp Zabel. This will
  fix regressions for other interfaces, too
V1:
  Tested-by Philipp Zabel an Rogerio Pimentel

 drivers/staging/imx-drm/imx-drm-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 6455305..8c433fc 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -144,7 +144,7 @@ int imx_drm_crtc_panel_format(struct drm_crtc *crtc, u32 encoder_type,
 		u32 interface_pix_fmt)
 {
 	return imx_drm_crtc_panel_format_pins(crtc, encoder_type,
-					      interface_pix_fmt, 0, 0);
+					      interface_pix_fmt, 2, 3);
 }
 EXPORT_SYMBOL_GPL(imx_drm_crtc_panel_format);
 
-- 
1.7.9.5
