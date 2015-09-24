From: aalonso@freescale.com (Adrian Alonso)
Date: Thu, 24 Sep 2015 15:54:02 -0500
Subject: [PATCH v5 6/7] pinctrl: freescale: imx7d: support iomux lpsr
 controller
In-Reply-To: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
Message-ID: <1443128043-21063-6-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iMX7D has two iomuxc controllers, iomuxc controller similar as
previous iMX SoC generation and iomuxc-lpsr which provides low
power state rentetion capabilities on gpios that are part of
iomuxc-lpsr

Add iomuxc-lpsr gpio group id's

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V2: Add imx7d_lpsr_pads enums
Changes for V3: Resend
Changes for V4: Resend
Changes for V5: Remove flags SHARE_INPUT_SELECT_REG and
 ZERO_OFFSET_VALID.

 drivers/pinctrl/freescale/pinctrl-imx7d.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx7d.c b/drivers/pinctrl/freescale/pinctrl-imx7d.c
index 1fa7530..e901907 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7d.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7d.c
@@ -174,6 +174,17 @@ enum imx7d_pads {
 	MX7D_PAD_ENET1_COL = 154,
 };
 
+enum imx7d_lpsr_pads {
+	MX7D_PAD_GPIO1_IO00 = 0,
+	MX7D_PAD_GPIO1_IO01 = 1,
+	MX7D_PAD_GPIO1_IO02 = 2,
+	MX7D_PAD_GPIO1_IO03 = 3,
+	MX7D_PAD_GPIO1_IO04 = 4,
+	MX7D_PAD_GPIO1_IO05 = 5,
+	MX7D_PAD_GPIO1_IO06 = 6,
+	MX7D_PAD_GPIO1_IO07 = 7,
+};
+
 /* Pad names for the pinmux subsystem */
 static const struct pinctrl_pin_desc imx7d_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX7D_PAD_RESERVE0),
@@ -333,13 +344,31 @@ static const struct pinctrl_pin_desc imx7d_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX7D_PAD_ENET1_COL),
 };
 
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc imx7d_lpsr_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO00),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO01),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO02),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO03),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO04),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO05),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO06),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO07),
+};
+
 static struct imx_pinctrl_soc_info imx7d_pinctrl_info = {
 	.pins = imx7d_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx7d_pinctrl_pads),
 };
 
+static struct imx_pinctrl_soc_info imx7d_lpsr_pinctrl_info = {
+	.pins = imx7d_lpsr_pinctrl_pads,
+	.npins = ARRAY_SIZE(imx7d_lpsr_pinctrl_pads),
+};
+
 static struct of_device_id imx7d_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx7d-iomuxc", .data = &imx7d_pinctrl_info, },
+	{ .compatible = "fsl,imx7d-iomuxc-lpsr", .data = &imx7d_lpsr_pinctrl_info },
 	{ /* sentinel */ }
 };
 
-- 
2.1.4
