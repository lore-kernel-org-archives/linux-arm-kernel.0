From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 11:58:27 +0100
Subject: [PATCH v2 4/28] drm/i2c: tda998x: change probe message origin
Message-ID: <20140109115827.18d0df97@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch gives a more precise information about the device getting the
TDA chip version.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c    | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index cd7ac58..63d5be2 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1187,12 +1187,21 @@ tda998x_encoder_init(struct i2c_client *client,
 	priv->rev &= ~0x30; /* not-hdcp and not-scalar bit */
 
 	switch (priv->rev) {
-	case TDA9989N2:  dev_info(dev->dev, "found TDA9989 n2");  break;
-	case TDA19989:   dev_info(dev->dev, "found TDA19989");    break;
-	case TDA19989N2: dev_info(dev->dev, "found TDA19989 n2"); break;
-	case TDA19988:   dev_info(dev->dev, "found TDA19988");    break;
+	case TDA9989N2:
+		dev_info(&client->dev, "found TDA9989 n2");
+		break;
+	case TDA19989:
+		dev_info(&client->dev, "found TDA19989");
+		break;
+	case TDA19989N2:
+		dev_info(&client->dev, "found TDA19989 n2");
+		break;
+	case TDA19988:
+		dev_info(&client->dev, "found TDA19988");
+		break;
 	default:
-		DBG("found unsupported device: %04x", priv->rev);
+		dev_err(&client->dev, "found unsupported device: %04x\n",
+			priv->rev);
 		goto fail;
 	}
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
