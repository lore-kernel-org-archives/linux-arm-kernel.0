From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 22:18:52 +0800
Subject: [PATCH] pinctrl: imx51: fix .conf_reg of MX51_PAD_SD2_CMD__CSPI_MOSI
Message-ID: <1344867532-27068-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .conf_reg of MX51_PAD_SD2_CMD__CSPI_MOSI should be 0x7bc rather
than NO_PAD.  This error will cause SD2 probe failure.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Hi Linus,

Please send this fix for -rc, so that my imx51 pinctrl series can get
a fixed base.

Regards,
Shawn

 drivers/pinctrl/pinctrl-imx51.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx51.c b/drivers/pinctrl/pinctrl-imx51.c
index 689b3c8..9fd0216 100644
--- a/drivers/pinctrl/pinctrl-imx51.c
+++ b/drivers/pinctrl/pinctrl-imx51.c
@@ -974,7 +974,7 @@ static struct imx_pin_reg imx51_pin_regs[] = {
 	IMX_PIN_REG(MX51_PAD_EIM_DA13, NO_PAD, 0x050, 0, 0x000, 0), /* MX51_PAD_EIM_DA13__EIM_DA13 */
 	IMX_PIN_REG(MX51_PAD_EIM_DA14, NO_PAD, 0x054, 0, 0x000, 0), /* MX51_PAD_EIM_DA14__EIM_DA14 */
 	IMX_PIN_REG(MX51_PAD_EIM_DA15, NO_PAD, 0x058, 0, 0x000, 0), /* MX51_PAD_EIM_DA15__EIM_DA15 */
-	IMX_PIN_REG(MX51_PAD_SD2_CMD, NO_PAD, 0x3b4, 2, 0x91c, 3), /* MX51_PAD_SD2_CMD__CSPI_MOSI */
+	IMX_PIN_REG(MX51_PAD_SD2_CMD, 0x7bc, 0x3b4, 2, 0x91c, 3), /* MX51_PAD_SD2_CMD__CSPI_MOSI */
 	IMX_PIN_REG(MX51_PAD_SD2_CMD, 0x7bc, 0x3b4, 1, 0x9b0, 2), /* MX51_PAD_SD2_CMD__I2C1_SCL */
 	IMX_PIN_REG(MX51_PAD_SD2_CMD, 0x7bc, 0x3b4, 0, 0x000, 0), /* MX51_PAD_SD2_CMD__SD2_CMD */
 	IMX_PIN_REG(MX51_PAD_SD2_CLK, 0x7c0, 0x3b8, 2, 0x914, 3), /* MX51_PAD_SD2_CLK__CSPI_SCLK */
-- 
1.7.5.4
