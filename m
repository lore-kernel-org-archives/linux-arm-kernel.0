From: aalonso@freescale.com (Adrian Alonso)
Date: Mon, 6 Jul 2015 17:59:06 -0500
Subject: [PATCH 4/4][v2] ARM: imx: pinctrl-imx7d: add iomuxc-lpsr gpio group
 ids
In-Reply-To: <1436223546-6333-1-git-send-email-aalonso@freescale.com>
References: <1436223546-6333-1-git-send-email-aalonso@freescale.com>
Message-ID: <1436223546-6333-4-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Add imx7d SoC iomuxc-lpsr gpio group id's
* Add IOMUXC_LPSR_SUPPORT flag for pinctrl-imx driver to
  support iomuxc-lpsr controller.

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
 drivers/pinctrl/freescale/pinctrl-imx7d.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx7d.c b/drivers/pinctrl/freescale/pinctrl-imx7d.c
index 1fa7530..cf89275 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7d.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7d.c
@@ -172,6 +172,14 @@ enum imx7d_pads {
 	MX7D_PAD_ENET1_RX_CLK = 152,
 	MX7D_PAD_ENET1_CRS = 153,
 	MX7D_PAD_ENET1_COL = 154,
+	MX7D_PAD_GPIO1_IO00 = 155,
+	MX7D_PAD_GPIO1_IO01 = 156,
+	MX7D_PAD_GPIO1_IO02 = 157,
+	MX7D_PAD_GPIO1_IO03 = 158,
+	MX7D_PAD_GPIO1_IO04 = 159,
+	MX7D_PAD_GPIO1_IO05 = 160,
+	MX7D_PAD_GPIO1_IO06 = 161,
+	MX7D_PAD_GPIO1_IO07 = 162,
 };
 
 /* Pad names for the pinmux subsystem */
@@ -331,11 +339,20 @@ static const struct pinctrl_pin_desc imx7d_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX7D_PAD_ENET1_RX_CLK),
 	IMX_PINCTRL_PIN(MX7D_PAD_ENET1_CRS),
 	IMX_PINCTRL_PIN(MX7D_PAD_ENET1_COL),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO00),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO01),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO02),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO03),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO04),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO05),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO06),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO07),
 };
 
 static struct imx_pinctrl_soc_info imx7d_pinctrl_info = {
 	.pins = imx7d_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx7d_pinctrl_pads),
+	.flags = IOMUXC_LPSR_SUPPORT,
 };
 
 static struct of_device_id imx7d_pinctrl_of_match[] = {
-- 
2.1.4
