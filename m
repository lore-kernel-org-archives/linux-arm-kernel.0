From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 11:58:40 +0100
Subject: [PATCH v2 5/28] drm/i2c: tda998x: don't freeze the system at audio
 startup time
Message-ID: <20140109115840.67c9e2d4@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prevents the system to be freezed at audio startup time,
replacing mdelay by msleep.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 63d5be2..0435752 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -670,7 +670,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
 
 	tda998x_audio_mute(priv, true);
-	mdelay(20);
+	msleep(20);
 	tda998x_audio_mute(priv, false);
 
 	/* Write the audio information packet */

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
