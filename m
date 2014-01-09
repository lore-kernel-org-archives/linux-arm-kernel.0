From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:05:00 +0100
Subject: [PATCH v2 16/28] drm/i2c: tda998x: change the video quantization
Message-ID: <20140109120500.6abc6cd2@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the video quantization to RGB/YUV.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 91bd4e8..f60aef9 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -992,7 +992,9 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	reg_clear(priv, REG_PLL_SERIAL_1, PLL_SERIAL_1_SRL_MAN_IZ);
 	reg_clear(priv, REG_PLL_SERIAL_3, PLL_SERIAL_3_SRL_DE);
 	reg_write(priv, REG_SERIALIZER, 0);
-	reg_write(priv, REG_HVF_CNTRL_1, HVF_CNTRL_1_VQR(0));
+
+	/* video quantization range = 0: full, 1: RGB/YUV, 2: YUV */
+	reg_write(priv, REG_HVF_CNTRL_1, HVF_CNTRL_1_VQR(1));
 
 	/* TODO enable pixel repeat for pixel rates less than 25Msamp/s */
 	rep = 0;
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
