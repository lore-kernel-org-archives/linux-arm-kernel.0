From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:05:43 +0100
Subject: [PATCH v2 19/28] drm/i2c: tda998x: fix the value of the TBG_CNTRL_1
 register
Message-ID: <20140109120543.1e3c9581@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the 'toggle flag enable' bit of the TBG_CNTRL_1
register which was set when no toggle was needed.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 192ddd2..7dbbc6b 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1080,11 +1080,11 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	 * Always generate sync polarity relative to input sync and
 	 * revert input stage toggled sync at output stage
 	 */
-	reg = TBG_CNTRL_1_DWIN_DIS | TBG_CNTRL_1_TGL_EN;
+	reg = TBG_CNTRL_1_DWIN_DIS;
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
-		reg |= TBG_CNTRL_1_H_TGL;
+		reg |= TBG_CNTRL_1_H_TGL | TBG_CNTRL_1_TGL_EN;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
-		reg |= TBG_CNTRL_1_V_TGL;
+		reg |= TBG_CNTRL_1_V_TGL | TBG_CNTRL_1_TGL_EN;
 	reg_write(priv, REG_TBG_CNTRL_1, reg);
 
 	/* Only setup the info frames if the sink is HDMI */
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
