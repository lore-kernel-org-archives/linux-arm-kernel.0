From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:39 +0100
Subject: [PATCH v3 06/24] drm/i2c: tda998x: force the page register at
 startup time
In-Reply-To: <cover.1390153344.git.moinejf@free.fr>
References: <cover.1390153344.git.moinejf@free.fr>
Message-ID: <20140119195839.4fba4591@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch forces the page register to be set on the first I/O operation.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 96b5966..b688801 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1170,7 +1170,7 @@ tda998x_encoder_init(struct i2c_client *client,
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
 
-	priv->current_page = 0;
+	priv->current_page = 0xff;
 	priv->hdmi = client;
 	priv->cec = i2c_new_dummy(client->adapter, 0x34);
 	priv->dpms = DRM_MODE_DPMS_OFF;
-- 
1.8.5.3
