From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:06:39 +0100
Subject: [PATCH v2 23/28] drm/i2c: tda998x: add the active aspect in HDMI
 AVI frame
Message-ID: <20140109120639.5f76c620@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the active aspect as 'picture' in the HDMI AVI frame
and also some comments about this frame.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 55cecb8..68630b8 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -696,7 +696,11 @@ tda998x_write_avi(struct tda998x_priv *priv, struct drm_display_mode *mode)
 	buf[HB(1)] = 0x02;
 	buf[HB(2)] = HDMI_AVI_INFOFRAME_SIZE;
 	buf[PB(1)] = HDMI_SCAN_MODE_UNDERSCAN;
+			/* (color_ind << 5) | (info_pres << 4) | (bar << 2) | scan */
+	buf[PB(2)] = HDMI_ACTIVE_ASPECT_PICTURE;
+			/* (colorimetry << 6) | (pic_ratio << 4) | active_ratio */
 	buf[PB(3)] = HDMI_QUANTIZATION_RANGE_FULL << 2;
+				/* (quant_range << 2) | non_uniform_scaling */
 	buf[PB(4)] = drm_match_cea_mode(mode);
 
 	tda998x_write_if(priv, DIP_IF_FLAGS_IF2, REG_IF2_HB0, buf,
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
