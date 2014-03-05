From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:56 +0100
Subject: [PATCH v5 05/11] imx-drm: imx-hdmi: Fix DDC I2C bus property
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the DDC I2C bus property to use the common 'ddc-i2c-bus'
property name instead of 'ddc'. This is already documented in
Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 909bee4..4540a9aa 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -1610,7 +1610,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 		hdmi->dev_type = device_id->driver_data;
 	}
 
-	ddc_node = of_parse_phandle(np, "ddc", 0);
+	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
 	if (ddc_node) {
 		hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		if (!hdmi->ddc)
-- 
1.9.0.rc3
