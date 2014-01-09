From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:05:26 +0100
Subject: [PATCH v2 18/28] drm/i2c: tda998x: fix the ENABLE_SPACE register
Message-ID: <20140109120526.6035167d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the ENABLE_SPACE register, the value of which was
inverted.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
  drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 8a7d8a2..192ddd2 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1069,7 +1069,7 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		if (priv->rev == TDA19988) {
 			/* let incoming pixels fill the active space (if any) */
-			reg_write(priv, REG_ENABLE_SPACE, 0x01);
+			reg_write(priv, REG_ENABLE_SPACE, 0x00);
 		}
 	}
 
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
