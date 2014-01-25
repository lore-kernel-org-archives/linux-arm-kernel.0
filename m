From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 25 Jan 2014 18:14:37 +0100
Subject: [PATCH v4 17/24] drm/i2c: tda998x: fix the ENABLE_SPACE register
In-Reply-To: <cover.1390646891.git.moinejf@free.fr>
References: <cover.1390646891.git.moinejf@free.fr>
Message-ID: <20140125181437.07f7860f@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the ENABLE_SPACE register, the value of which was
inverted.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 5a67b6f..e172f11 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -965,7 +965,7 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 	if (priv->rev == TDA19988) {
 		/* let incoming pixels fill the active space (if any) */
-		reg_write(priv, REG_ENABLE_SPACE, 0x01);
+		reg_write(priv, REG_ENABLE_SPACE, 0x00);
 	}
 
 	/*
-- 
1.8.5.3
