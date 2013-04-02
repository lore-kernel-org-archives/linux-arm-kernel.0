From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:30 +0900
Subject: [PATCH 22/28] sh-pfc: r8a73a4: Remove SCIF function GPIOS
In-Reply-To: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879376-10020-23-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a73a4 board support will use the pinctrl API to control the SCIF
pins, remove the corresponding unused function GPIOS.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |   45 ----------------------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 8a5288c..470b18f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2160,55 +2160,45 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 
 	/* Port19 */
 	GPIO_FN(LCDD19),
-	GPIO_FN(SCIFB3_RTS_19),
 	GPIO_FN(DU0_DB3),
 
 	/* Port20 */
 	GPIO_FN(LCDD20),
-	GPIO_FN(SCIFB3_CTS_20),
 	GPIO_FN(DU0_DB4),
 
 	/* Port21 */
 	GPIO_FN(LCDD21),
-	GPIO_FN(SCIFB3_TXD_21),
 	GPIO_FN(DU0_DB5),
 
 	/* Port22 */
 	GPIO_FN(LCDD22),
-	GPIO_FN(SCIFB3_RXD_22),
 	GPIO_FN(DU0_DB6),
 
 	/* Port23 */
 	GPIO_FN(LCDD23),
-	GPIO_FN(SCIFB3_SCK_23),
 	GPIO_FN(DU0_DB7),
 
 	/* Port24 */
 	GPIO_FN(LCDHSYN),
 	GPIO_FN(LCDCS),
-	GPIO_FN(SCIFB1_RTS_24),
 	GPIO_FN(DU0_EXHSYNC_N_CSYNC_N_HSYNC_N),
 
 	/* Port25 */
 	GPIO_FN(LCDVSYN),
-	GPIO_FN(SCIFB1_CTS_25),
 	GPIO_FN(DU0_EXVSYNC_N_VSYNC_N_CSYNC_N),
 
 	/* Port26 */
 	GPIO_FN(LCDDCK),
 	GPIO_FN(LCDWR),
-	GPIO_FN(SCIFB1_TXD_26),
 	GPIO_FN(DU0_DOTCLKIN),
 
 	/* Port27 */
 	GPIO_FN(LCDDISP),
 	GPIO_FN(LCDRS),
-	GPIO_FN(SCIFB1_RXD_27),
 	GPIO_FN(DU0_DOTCLKOUT),
 
 	/* Port28 */
 	GPIO_FN(LCDRD_N),
-	GPIO_FN(SCIFB1_SCK_28),
 	GPIO_FN(DU0_DOTCLKOUTB),
 
 	/* Port29 */
@@ -2222,48 +2212,36 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(DU0_ODDF_N_CLAMP),
 
 	/* Port32 */
-	GPIO_FN(SCIFA0_RTS),
 	GPIO_FN(SIM0_DET),
 	GPIO_FN(CSCIF0_RTS),
 
 	/* Port33 */
-	GPIO_FN(SCIFA0_CTS),
 	GPIO_FN(SIM1_DET),
 	GPIO_FN(CSCIF0_CTS),
 
 	/* Port34 */
-	GPIO_FN(SCIFA0_SCK),
 	GPIO_FN(SIM0_PWRON),
 	GPIO_FN(CSCIF0_SCK),
 
 	/* Port35 */
-	GPIO_FN(SCIFA1_RTS),
 	GPIO_FN(CSCIF1_RTS),
 
 	/* Port36 */
-	GPIO_FN(SCIFA1_CTS),
 	GPIO_FN(CSCIF1_CTS),
 
 	/* Port37 */
-	GPIO_FN(SCIFA1_SCK),
 	GPIO_FN(CSCIF1_SCK),
 
 	/* Port38 */
-	GPIO_FN(SCIFB0_RTS),
 	GPIO_FN(TPU0TO1),
-	GPIO_FN(SCIFB3_RTS_38),
 	GPIO_FN(CHSCIF0_HRTS),
 
 	/* Port39 */
-	GPIO_FN(SCIFB0_CTS),
 	GPIO_FN(TPU0TO2),
-	GPIO_FN(SCIFB3_CTS_39),
 	GPIO_FN(CHSCIF0_HCTS),
 
 	/* Port40 */
-	GPIO_FN(SCIFB0_SCK),
 	GPIO_FN(TPU0TO3),
-	GPIO_FN(SCIFB3_SCK_40),
 	GPIO_FN(CHSCIF0_HSCK),
 
 	/* Port64 */
@@ -2274,52 +2252,44 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 
 	/* Port66 */
 	GPIO_FN(HSI_RX_WAKE),
-	GPIO_FN(SCIFB2_CTS_66),
 	GPIO_FN(MSIOF3_SYNC),
 	GPIO_FN(GenIO4),
 	GPIO_FN(IRQ40),
 
 	/* Port67 */
 	GPIO_FN(HSI_RX_READY),
-	GPIO_FN(SCIFB1_TXD_67),
 	GPIO_FN(GIO_OUT3_67),
 	GPIO_FN(CHSCIF1_HTX),
 
 	/* Port68 */
 	GPIO_FN(HSI_RX_FLAG),
-	GPIO_FN(SCIFB2_TXD_68),
 	GPIO_FN(MSIOF3_TXD),
 	GPIO_FN(GIO_OUT4_68),
 
 	/* Port69 */
 	GPIO_FN(HSI_RX_DATA),
-	GPIO_FN(SCIFB2_RXD_69),
 	GPIO_FN(MSIOF3_RXD),
 	GPIO_FN(GIO_OUT5_69),
 
 	/* Port70 */
 	GPIO_FN(HSI_TX_FLAG),
-	GPIO_FN(SCIFB1_RTS_70),
 	GPIO_FN(GIO_OUT1_70),
 	GPIO_FN(HSIC_TSTCLK0),
 	GPIO_FN(CHSCIF1_HRTS),
 
 	/* Port71 */
 	GPIO_FN(HSI_TX_DATA),
-	GPIO_FN(SCIFB1_CTS_71),
 	GPIO_FN(GIO_OUT2_71),
 	GPIO_FN(HSIC_TSTCLK1),
 	GPIO_FN(CHSCIF1_HCTS),
 
 	/* Port72 */
 	GPIO_FN(HSI_TX_WAKE),
-	GPIO_FN(SCIFB1_RXD_72),
 	GPIO_FN(GenIO8),
 	GPIO_FN(CHSCIF1_HRX),
 
 	/* Port73 */
 	GPIO_FN(HSI_TX_READY),
-	GPIO_FN(SCIFB2_RTS_73),
 	GPIO_FN(MSIOF3_SCK),
 	GPIO_FN(GIO_OUT0_73),
 
@@ -2398,36 +2368,28 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(IRQ49),
 
 	/* Port116 */
-	GPIO_FN(SCIFA0_TXD),
 	GPIO_FN(CSCIF0_TX),
 
 	/* Port117 */
-	GPIO_FN(SCIFA0_RXD),
 	GPIO_FN(CSCIF0_RX),
 
 	/* Port118 */
-	GPIO_FN(SCIFA1_TXD),
 	GPIO_FN(CSCIF1_TX),
 
 	/* Port119 */
-	GPIO_FN(SCIFA1_RXD),
 	GPIO_FN(CSCIF1_RX),
 
 	/* Port120 */
 	GPIO_FN(SF_PORT_1_120),
-	GPIO_FN(SCIFB3_RXD_120),
 	GPIO_FN(DU0_CDE),
 
 	/* Port121 */
 	GPIO_FN(SF_PORT_0_121),
-	GPIO_FN(SCIFB3_TXD_121),
 
 	/* Port122 */
-	GPIO_FN(SCIFB0_TXD),
 	GPIO_FN(CHSCIF0_HTX),
 
 	/* Port123 */
-	GPIO_FN(SCIFB0_RXD),
 	GPIO_FN(CHSCIF0_HRX),
 
 	/* Port124 */
@@ -2721,11 +2683,9 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MSIOF0_TXD),
 
 	/* Port261 */
-	GPIO_FN(SCIFB1_SCK_261),
 	GPIO_FN(CHSCIF1_HSCK),
 
 	/* Port262 */
-	GPIO_FN(SCIFB2_SCK_262),
 
 	/* Port263 - Port266 FN1 */
 	GPIO_FN(MSIOF1_SS2),
@@ -2809,7 +2769,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	/* Port295 */
 	GPIO_FN(SDHID2_0),
 	GPIO_FN(MSIOF4_TXD),
-	GPIO_FN(SCIFB2_TXD_295),
 	GPIO_FN(MSIOF6_TXD),
 
 	/* Port296 */
@@ -2830,10 +2789,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MSIOF4_SS1),
 
 	/* Port297 - Port300 FN3 */
-	GPIO_FN(SCIFB2_RXD_297),
-	GPIO_FN(SCIFB2_CTS_298),
-	GPIO_FN(SCIFB2_SCK_299),
-	GPIO_FN(SCIFB2_RTS_300),
 
 	/* Port297 - Port300 FN4 */
 	GPIO_FN(MSIOF6_RXD),
-- 
1.7.10.4
