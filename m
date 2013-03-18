From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:43 +0900
Subject: [PATCH 107/142] sh-pfc: sh73a0: Remove I2C function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-108-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh73a0 platforms now use the pinctrl API to control the I2C pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 6d36ebb..13bd138 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3354,13 +3354,9 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VINT),
 	GPIO_FN(TCKON),
 	GPIO_FN(XDVFS1), \
-	GPIO_FN(PORT27_I2C_SCL2), \
-	GPIO_FN(PORT27_I2C_SCL3), \
 	GPIO_FN(MFG0_OUT1), \
 	GPIO_FN(PORT27_IROUT),
 	GPIO_FN(XDVFS2), \
-	GPIO_FN(PORT28_I2C_SDA2), \
-	GPIO_FN(PORT28_I2C_SDA3), \
 	GPIO_FN(PORT28_TPU1TO1),
 	GPIO_FN(SIM_RST), \
 	GPIO_FN(PORT29_TPU1TO1),
@@ -3517,12 +3513,8 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(BBIF1_TXD),
 	GPIO_FN(HSI_RX_READY), \
 	GPIO_FN(BBIF1_RSCK), \
-	GPIO_FN(PORT115_I2C_SCL2), \
-	GPIO_FN(PORT115_I2C_SCL3),
 	GPIO_FN(HSI_RX_WAKE), \
 	GPIO_FN(BBIF1_RSYNC), \
-	GPIO_FN(PORT116_I2C_SDA2), \
-	GPIO_FN(PORT116_I2C_SDA3),
 	GPIO_FN(HSI_RX_FLAG), \
 	GPIO_FN(BBIF1_SS1), \
 	GPIO_FN(BBIF1_FLOW),
@@ -3670,9 +3662,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MFG1_IN2), \
 	GPIO_FN(VIO2_VD2), \
 	GPIO_FN(MSIOF1_MCK0), \
-	GPIO_FN(PORT236_I2C_SDA2),
 	GPIO_FN(MSIOF1_MCK1), \
-	GPIO_FN(PORT237_I2C_SCL2),
 	GPIO_FN(MSIOF1_SS1), \
 	GPIO_FN(VIO2_FIELD2), \
 	GPIO_FN(MSIOF1_SS2), \
@@ -3695,11 +3685,9 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(TPU3TO1),
 	GPIO_FN(MFG2_OUT1), \
 	GPIO_FN(TPU2TO0), \
-	GPIO_FN(PORT248_I2C_SCL3), \
 	GPIO_FN(MSIOF2R_TSCK),
 	GPIO_FN(PORT249_IROUT), \
 	GPIO_FN(MFG4_IN1), \
-	GPIO_FN(PORT249_I2C_SDA3), \
 	GPIO_FN(MSIOF2R_TSYNC),
 	GPIO_FN(SDHICLK0),
 	GPIO_FN(SDHICD0),
-- 
1.7.10.4
