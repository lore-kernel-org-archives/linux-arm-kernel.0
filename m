From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:06:07 +0100
Subject: [PATCH v2 20/28] drm/i2c: tda998x: move the TBG_CNTRL_0 register
 setting
Message-ID: <20140109120607.6a33bee5@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the comment, the TBG_CNTRL_0 register must be set at the
end of the mode change sequence.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 7dbbc6b..864b9f5 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1073,9 +1073,6 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 		}
 	}
 
-	/* must be last register set: */
-	reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
-
 	/*
 	 * Always generate sync polarity relative to input sync and
 	 * revert input stage toggled sync at output stage
@@ -1100,6 +1097,9 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 		if (priv->audio_type)
 			tda998x_configure_audio(priv, mode);
 	}
+
+	/* must be last register set: */
+	reg_write(priv, REG_TBG_CNTRL_0, 0);
 }
 
 static enum drm_connector_status
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
