From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:46 +0100
Subject: [PATCH v3 21/24] drm/i2c: tda998x: add the active aspect in HDMI
 AVI frame
In-Reply-To: <cover.1390153344.git.moinejf@free.fr>
References: <cover.1390153344.git.moinejf@free.fr>
Message-ID: <20140119195846.0b83e7b1@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index a2ad2ac..05713f7 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -649,6 +649,7 @@ tda998x_write_avi(struct tda998x_priv *priv, struct drm_display_mode *mode)
 	buf[HB(1)] = 0x02;
 	buf[HB(2)] = HDMI_AVI_INFOFRAME_SIZE;
 	buf[PB(1)] = HDMI_SCAN_MODE_UNDERSCAN;
+	buf[PB(2)] = HDMI_ACTIVE_ASPECT_PICTURE;
 	buf[PB(3)] = HDMI_QUANTIZATION_RANGE_FULL << 2;
 	buf[PB(4)] = drm_match_cea_mode(mode);
 
-- 
1.8.5.3
