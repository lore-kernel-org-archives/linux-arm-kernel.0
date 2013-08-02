From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri,  2 Aug 2013 12:38:22 +0200
Subject: [PATCH 2/7] pinctrl: imx header, conditional probe functions
In-Reply-To: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1375439907-10462-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functions are not available if included by imx1 core driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-imx.h b/drivers/pinctrl/pinctrl-imx.h
index bcedd99..446fc01 100644
--- a/drivers/pinctrl/pinctrl-imx.h
+++ b/drivers/pinctrl/pinctrl-imx.h
@@ -89,7 +89,11 @@ struct imx_pinctrl_soc_info {
 #define IMX_MUX_MASK	0x7
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
+#if IS_ENABLED(PINCTRL_IMX)
+
 int imx_pinctrl_probe(struct platform_device *pdev,
 			struct imx_pinctrl_soc_info *info);
 int imx_pinctrl_remove(struct platform_device *pdev);
+
+#endif
 #endif /* __DRIVERS_PINCTRL_IMX_H */
-- 
1.8.3.2
