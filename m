From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:00:07 +0100
Subject: [PATCH v2 11/28] drm/i2c: tda998x: check the CEC device creation
Message-ID: <20140109120007.117c4151@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 93ef64c..2ba0355 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1170,6 +1170,8 @@ tda998x_encoder_init(struct i2c_client *client,
 	priv->current_page = 0xff;
 	priv->hdmi = client;
 	priv->cec = i2c_new_dummy(client->adapter, 0x34);
+	if (!priv->cec)
+		return -ENODEV;
 	priv->dpms = DRM_MODE_DPMS_OFF;
 
 	encoder_slave->slave_priv = priv;

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
