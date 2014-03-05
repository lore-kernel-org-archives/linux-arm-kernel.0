From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:57 +0100
Subject: [PATCH v5 06/11] imx-drm: imx-tve: Fix DDC I2C bus property
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-7-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the TV Encoder DDC I2C bus property to use the common
'ddc-i2c-bus' property name instead of 'ddc'.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-tve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index 50b25f1..575533f 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -582,7 +582,7 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	tve->dev = dev;
 	spin_lock_init(&tve->lock);
 
-	ddc_node = of_parse_phandle(np, "ddc", 0);
+	ddc_node = of_parse_phandle(np, "i2c-ddc-bus", 0);
 	if (ddc_node) {
 		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
-- 
1.9.0.rc3
