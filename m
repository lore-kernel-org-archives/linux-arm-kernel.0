From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:15:11 +0200
Subject: [PATCH 05/14] sh-pfc: r8a7790: Remove deprecated SPV_EVEN pin
In-Reply-To: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1374671720-8794-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

The pins have been removed from the datasheet, remove them here as well.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index aec961b..350b076 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -380,7 +380,7 @@ enum {
 	FN_FMIN_E, FN_FMIN_F,
 	FN_MLB_CLK, FN_IIC2_SCL_B, FN_I2C2_SCL_B,
 	FN_MLB_SIG, FN_SCIFB1_RXD_D, FN_RX1_C, FN_IIC2_SDA_B,
-	FN_I2C2_SDA_B, FN_MLB_DAT, FN_SPV_EVEN,
+	FN_I2C2_SDA_B, FN_MLB_DAT,
 	FN_SCIFB1_TXD_D, FN_TX1_C, FN_BPFCLK_C,
 	FN_SSI_SCK0129, FN_CAN_CLK_B,
 	FN_MOUT0,
@@ -747,7 +747,7 @@ enum {
 	FMIN_E_MARK, FMIN_F_MARK,
 	MLB_CLK_MARK, IIC2_SCL_B_MARK, I2C2_SCL_B_MARK,
 	MLB_SIG_MARK, SCIFB1_RXD_D_MARK, RX1_C_MARK, IIC2_SDA_B_MARK,
-	I2C2_SDA_B_MARK, MLB_DAT_MARK, SPV_EVEN_MARK,
+	I2C2_SDA_B_MARK, MLB_DAT_MARK,
 	SCIFB1_TXD_D_MARK, TX1_C_MARK, BPFCLK_C_MARK,
 	SSI_SCK0129_MARK, CAN_CLK_B_MARK,
 	MOUT0_MARK,
@@ -1500,7 +1500,6 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_IPSR_MODSEL_DATA(IP11_26_24, IIC2_SDA_B, SEL_IIC2_1),
 	PINMUX_IPSR_MODSEL_DATA(IP11_26_24, I2C2_SDA_B, SEL_I2C2_1),
 	PINMUX_IPSR_DATA(IP11_29_27, MLB_DAT),
-	PINMUX_IPSR_DATA(IP11_29_27, SPV_EVEN),
 	PINMUX_IPSR_MODSEL_DATA(IP11_29_27, SCIFB1_TXD_D, SEL_SCIFB1_3),
 	PINMUX_IPSR_MODSEL_DATA(IP11_29_27, TX1_C, SEL_SCIF1_2),
 	PINMUX_IPSR_MODSEL_DATA(IP11_29_27, BPFCLK_C, SEL_FM_2),
@@ -3601,7 +3600,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP11_31_30 [2] */
 		FN_SSI_SCK0129, FN_CAN_CLK_B, FN_MOUT0, 0,
 		/* IP11_29_27 [3] */
-		FN_MLB_DAT, FN_SPV_EVEN, FN_SCIFB1_TXD_D, FN_TX1_C, FN_BPFCLK_C,
+		FN_MLB_DAT, 0, FN_SCIFB1_TXD_D, FN_TX1_C, FN_BPFCLK_C,
 		0, 0, 0,
 		/* IP11_26_24 [3] */
 		FN_MLB_SIG, FN_SCIFB1_RXD_D, FN_RX1_C, FN_IIC2_SDA_B, FN_I2C2_SDA_B,
-- 
1.8.1.5
