From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:42 +0900
Subject: [PATCH 106/142] sh-pfc: sh73a0: Remove SCIFA and SCIFB function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-107-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh73a0 platforms now use the pinctrl API to control the SCIFA and
SCIFB pins, the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |   58 -----------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 1054a42..6d36ebb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3335,19 +3335,13 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(GPI5),
 	GPIO_FN(GPI6),
 	GPIO_FN(GPI7),
-	GPIO_FN(SCIFA7_RXD),
-	GPIO_FN(SCIFA7_CTS_),
 	GPIO_FN(GPO7), \
 	GPIO_FN(MFG0_OUT2),
 	GPIO_FN(GPO6), \
 	GPIO_FN(MFG1_OUT2),
 	GPIO_FN(GPO5), \
-	GPIO_FN(SCIFA0_SCK), \
 	GPIO_FN(FSICOSLDT3), \
 	GPIO_FN(PORT16_VIO_CKOR),
-	GPIO_FN(SCIFA0_TXD),
-	GPIO_FN(SCIFA7_TXD),
-	GPIO_FN(SCIFA7_RTS_), \
 	GPIO_FN(PORT19_VIO_CKO2),
 	GPIO_FN(GPO0),
 	GPIO_FN(GPO1),
@@ -3374,11 +3368,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(PORT30_VIO_CKOR),
 	GPIO_FN(SIM_D), \
 	GPIO_FN(PORT31_IROUT),
-	GPIO_FN(SCIFA4_TXD),
-	GPIO_FN(SCIFA4_RXD), \
 	GPIO_FN(XWUP),
-	GPIO_FN(SCIFA4_RTS_),
-	GPIO_FN(SCIFA4_CTS_),
 	GPIO_FN(FSIBOBT), \
 	GPIO_FN(FSIBIBT),
 	GPIO_FN(FSIBOLR), \
@@ -3387,10 +3377,7 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(FSIBISLD),
 	GPIO_FN(VACK),
 	GPIO_FN(XTAL1L),
-	GPIO_FN(SCIFA0_RTS_), \
 	GPIO_FN(FSICOSLDT2),
-	GPIO_FN(SCIFA0_RXD),
-	GPIO_FN(SCIFA0_CTS_), \
 	GPIO_FN(FSICOSLDT1),
 	GPIO_FN(FSICOBT), \
 	GPIO_FN(FSICIBT), \
@@ -3516,14 +3503,10 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(BBIF2_RXD),
 	GPIO_FN(BBIF2_SYNC),
 	GPIO_FN(BBIF2_SCK),
-	GPIO_FN(SCIFA3_CTS_), \
 	GPIO_FN(MFG3_IN2),
-	GPIO_FN(SCIFA3_RXD), \
 	GPIO_FN(MFG3_IN1),
 	GPIO_FN(BBIF1_SS2), \
-	GPIO_FN(SCIFA3_RTS_), \
 	GPIO_FN(MFG3_OUT1),
-	GPIO_FN(SCIFA3_TXD),
 	GPIO_FN(HSI_RX_DATA), \
 	GPIO_FN(BBIF1_RXD),
 	GPIO_FN(HSI_TX_WAKE), \
@@ -3611,37 +3594,17 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(TPU1TO2), \
 	GPIO_FN(TS_SDEN3), \
 	GPIO_FN(PORT153_MSIOF2_SS1),
-	GPIO_FN(SCIFA2_TXD1), \
 	GPIO_FN(MSIOF2_MCK0),
-	GPIO_FN(SCIFA2_RXD1), \
 	GPIO_FN(MSIOF2_MCK1),
-	GPIO_FN(SCIFA2_RTS1_), \
 	GPIO_FN(PORT156_MSIOF2_SS2),
-	GPIO_FN(SCIFA2_CTS1_), \
 	GPIO_FN(PORT157_MSIOF2_RXD),
 	GPIO_FN(DINT_), \
-	GPIO_FN(SCIFA2_SCK1), \
 	GPIO_FN(TS_SCK3),
-	GPIO_FN(PORT159_SCIFB_SCK), \
-	GPIO_FN(PORT159_SCIFA5_SCK), \
 	GPIO_FN(NMI),
-	GPIO_FN(PORT160_SCIFB_TXD), \
-	GPIO_FN(PORT160_SCIFA5_TXD),
-	GPIO_FN(PORT161_SCIFB_CTS_), \
-	GPIO_FN(PORT161_SCIFA5_CTS_),
-	GPIO_FN(PORT162_SCIFB_RXD), \
-	GPIO_FN(PORT162_SCIFA5_RXD),
-	GPIO_FN(PORT163_SCIFB_RTS_), \
-	GPIO_FN(PORT163_SCIFA5_RTS_), \
 	GPIO_FN(TPU3TO0),
-	GPIO_FN(PORT193_SCIFA5_CTS_), \
 	GPIO_FN(BBIF2_TSYNC1),
-	GPIO_FN(PORT194_SCIFA5_RTS_), \
 	GPIO_FN(BBIF2_TSCK1),
-	GPIO_FN(PORT195_SCIFA5_RXD), \
 	GPIO_FN(BBIF2_TXD1),
-	GPIO_FN(PORT196_SCIFA5_TXD),
-	GPIO_FN(PORT197_SCIFA5_SCK), \
 	GPIO_FN(MFG2_OUT2), \
 	GPIO_FN(TPU2TO1),
 	GPIO_FN(TPU4TO1), \
@@ -3692,26 +3655,16 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MSIOF0L_TXD), \
 	GPIO_FN(VIO2_VD3), \
 
-	GPIO_FN(SCIFA1_TXD), \
 	GPIO_FN(OVCN2),
 	GPIO_FN(EXTLP), \
-	GPIO_FN(SCIFA1_SCK), \
 	GPIO_FN(PORT226_VIO_CKO2),
-	GPIO_FN(SCIFA1_RTS_), \
 	GPIO_FN(IDIN),
-	GPIO_FN(SCIFA1_RXD),
-	GPIO_FN(SCIFA1_CTS_), \
 	GPIO_FN(MFG1_IN1),
 	GPIO_FN(MSIOF1_TXD), \
-	GPIO_FN(SCIFA2_TXD2),
 	GPIO_FN(MSIOF1_TSYNC), \
-	GPIO_FN(SCIFA2_CTS2_),
 	GPIO_FN(MSIOF1_TSCK), \
-	GPIO_FN(SCIFA2_SCK2),
 	GPIO_FN(MSIOF1_RXD), \
-	GPIO_FN(SCIFA2_RXD2),
 	GPIO_FN(MSIOF1_RSCK), \
-	GPIO_FN(SCIFA2_RTS2_), \
 	GPIO_FN(VIO2_CLK2), \
 	GPIO_FN(MSIOF1_RSYNC), \
 	GPIO_FN(MFG1_IN2), \
@@ -3724,7 +3677,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VIO2_FIELD2), \
 	GPIO_FN(MSIOF1_SS2), \
 	GPIO_FN(VIO2_HD2), \
-	GPIO_FN(SCIFA6_TXD),
 	GPIO_FN(PORT241_IRDA_OUT), \
 	GPIO_FN(PORT241_IROUT), \
 	GPIO_FN(MFG4_OUT1), \
@@ -3733,25 +3685,15 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MFG4_IN2),
 	GPIO_FN(PORT243_IRDA_FIRSEL), \
 	GPIO_FN(PORT243_VIO_CKO2),
-	GPIO_FN(PORT244_SCIFA5_CTS_), \
 	GPIO_FN(MFG2_IN1), \
-	GPIO_FN(PORT244_SCIFB_CTS_), \
 	GPIO_FN(MSIOF2R_RXD),
-	GPIO_FN(PORT245_SCIFA5_RTS_), \
 	GPIO_FN(MFG2_IN2), \
-	GPIO_FN(PORT245_SCIFB_RTS_), \
 	GPIO_FN(MSIOF2R_TXD),
-	GPIO_FN(PORT246_SCIFA5_RXD), \
 	GPIO_FN(MFG1_OUT1), \
-	GPIO_FN(PORT246_SCIFB_RXD), \
 	GPIO_FN(TPU1TO0),
-	GPIO_FN(PORT247_SCIFA5_TXD), \
 	GPIO_FN(MFG3_OUT2), \
-	GPIO_FN(PORT247_SCIFB_TXD), \
 	GPIO_FN(TPU3TO1),
-	GPIO_FN(PORT248_SCIFA5_SCK), \
 	GPIO_FN(MFG2_OUT1), \
-	GPIO_FN(PORT248_SCIFB_SCK), \
 	GPIO_FN(TPU2TO0), \
 	GPIO_FN(PORT248_I2C_SCL3), \
 	GPIO_FN(MSIOF2R_TSCK),
-- 
1.7.10.4
