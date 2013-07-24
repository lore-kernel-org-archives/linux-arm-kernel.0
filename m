From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:15:12 +0200
Subject: [PATCH 06/14] sh-pfc: r8a7790: Swap SCIFA2_RXD_B and HRX0_C
 configurations
In-Reply-To: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1374671720-8794-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

The SCIFA2 RXD_B and HRX0_C pins have their pinmux configuration data
swapped, fix it.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 350b076..b06d36c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -464,7 +464,7 @@ enum {
 	FN_LCDOUT21, FN_MSIOF0_SCK, FN_TS_SDAT0, FN_ADICLK,
 	FN_DU2_DB6, FN_LCDOUT22, FN_MSIOF0_SYNC, FN_TS_SCK0,
 	FN_SSI_SCK2, FN_ADIDATA, FN_DU2_DB7, FN_LCDOUT23,
-	FN_SCIFA2_RXD_B, FN_MSIOF0_SS1, FN_ADICHS0,
+	FN_HRX0_C, FN_MSIOF0_SS1, FN_ADICHS0,
 	FN_DU2_DG5, FN_LCDOUT13, FN_MSIOF0_TXD, FN_ADICHS1,
 	FN_DU2_DG6, FN_LCDOUT14,
 
@@ -472,7 +472,7 @@ enum {
 	FN_MSIOF0_SS2, FN_AUDIO_CLKOUT, FN_ADICHS2,
 	FN_DU2_DISP, FN_QPOLA, FN_HTX0_C, FN_SCIFA2_TXD_B,
 	FN_MSIOF0_RXD, FN_TS_SPSYNC0, FN_SSI_WS2,
-	FN_ADICS_SAMP, FN_DU2_CDE, FN_QPOLB, FN_HRX0_C,
+	FN_ADICS_SAMP, FN_DU2_CDE, FN_QPOLB, FN_SCIFA2_RXD_B,
 	FN_USB1_PWEN, FN_AUDIO_CLKOUT_D, FN_USB1_OVC,
 	FN_TCLK1_B,
 
@@ -827,14 +827,14 @@ enum {
 	LCDOUT21_MARK, MSIOF0_SCK_MARK, TS_SDAT0_MARK, ADICLK_MARK,
 	DU2_DB6_MARK, LCDOUT22_MARK, MSIOF0_SYNC_MARK, TS_SCK0_MARK,
 	SSI_SCK2_MARK, ADIDATA_MARK, DU2_DB7_MARK, LCDOUT23_MARK,
-	SCIFA2_RXD_B_MARK, MSIOF0_SS1_MARK, ADICHS0_MARK,
+	HRX0_C_MARK, MSIOF0_SS1_MARK, ADICHS0_MARK,
 	DU2_DG5_MARK, LCDOUT13_MARK, MSIOF0_TXD_MARK, ADICHS1_MARK,
 	DU2_DG6_MARK, LCDOUT14_MARK,
 
 	MSIOF0_SS2_MARK, AUDIO_CLKOUT_MARK, ADICHS2_MARK,
 	DU2_DISP_MARK, QPOLA_MARK, HTX0_C_MARK, SCIFA2_TXD_B_MARK,
 	MSIOF0_RXD_MARK, TS_SPSYNC0_MARK, SSI_WS2_MARK,
-	ADICS_SAMP_MARK, DU2_CDE_MARK, QPOLB_MARK, HRX0_C_MARK,
+	ADICS_SAMP_MARK, DU2_CDE_MARK, QPOLB_MARK, SCIFA2_RXD_B_MARK,
 	USB1_PWEN_MARK, AUDIO_CLKOUT_D_MARK, USB1_OVC_MARK,
 	TCLK1_B_MARK,
 	PINMUX_MARK_END,
@@ -1742,7 +1742,7 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_IPSR_DATA(IP15_25_23, ADIDATA),
 	PINMUX_IPSR_DATA(IP15_25_23, DU2_DB7),
 	PINMUX_IPSR_DATA(IP15_25_23, LCDOUT23),
-	PINMUX_IPSR_MODSEL_DATA(IP15_25_23, SCIFA2_RXD_B, SEL_SCIFA2_1),
+	PINMUX_IPSR_MODSEL_DATA(IP15_25_23, HRX0_C, SEL_SCIFA2_1),
 	PINMUX_IPSR_MODSEL_DATA(IP15_27_26, MSIOF0_SS1, SEL_SOF0_0),
 	PINMUX_IPSR_DATA(IP15_27_26, ADICHS0),
 	PINMUX_IPSR_DATA(IP15_27_26, DU2_DG5),
@@ -1765,7 +1765,7 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_IPSR_DATA(IP16_5_3, ADICS_SAMP),
 	PINMUX_IPSR_DATA(IP16_5_3, DU2_CDE),
 	PINMUX_IPSR_DATA(IP16_5_3, QPOLB),
-	PINMUX_IPSR_MODSEL_DATA(IP16_5_3, HRX0_C, SEL_HSCIF0_2),
+	PINMUX_IPSR_MODSEL_DATA(IP16_5_3, SCIFA2_RXD_B, SEL_HSCIF0_2),
 	PINMUX_IPSR_DATA(IP16_6, USB1_PWEN),
 	PINMUX_IPSR_DATA(IP16_6, AUDIO_CLKOUT_D),
 	PINMUX_IPSR_DATA(IP16_7, USB1_OVC),
@@ -3753,7 +3753,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_MSIOF0_SS1, FN_ADICHS0, FN_DU2_DG5, FN_LCDOUT13,
 		/* IP15_25_23 [3] */
 		FN_MSIOF0_SYNC, FN_TS_SCK0, FN_SSI_SCK2, FN_ADIDATA,
-		FN_DU2_DB7, FN_LCDOUT23, FN_SCIFA2_RXD_B, 0,
+		FN_DU2_DB7, FN_LCDOUT23, FN_HRX0_C, 0,
 		/* IP15_22_20 [3] */
 		FN_MSIOF0_SCK, FN_TS_SDAT0, FN_ADICLK,
 		FN_DU2_DB6, FN_LCDOUT22, 0, 0, 0,
@@ -3804,7 +3804,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_USB1_PWEN, FN_AUDIO_CLKOUT_D,
 		/* IP16_5_3 [3] */
 		FN_MSIOF0_RXD, FN_TS_SPSYNC0, FN_SSI_WS2,
-		FN_ADICS_SAMP, FN_DU2_CDE, FN_QPOLB, FN_HRX0_C, 0,
+		FN_ADICS_SAMP, FN_DU2_CDE, FN_QPOLB, FN_SCIFA2_RXD_B, 0,
 		/* IP16_2_0 [3] */
 		FN_MSIOF0_SS2, FN_AUDIO_CLKOUT, FN_ADICHS2,
 		FN_DU2_DISP, FN_QPOLA, FN_HTX0_C, FN_SCIFA2_TXD_B, 0, }
-- 
1.8.1.5
