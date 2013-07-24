From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 15:15:13 +0200
Subject: [PATCH 07/14] sh-pfc: r8a7790: Add TCLK1 pin configuration support
In-Reply-To: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1374671720-8794-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Update the pinmux configuration tables to support the TCLK1 pin.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index b06d36c..51e590b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -170,7 +170,7 @@ enum {
 	FN_VI0_R1, FN_VI0_R1_B, FN_TX0_B, FN_D6,
 	FN_IIC2_SCL_C, FN_VI3_DATA6, FN_VI0_R2, FN_VI0_R2_B,
 	FN_I2C2_SCL_C, FN_D7, FN_AD_DI_B, FN_IIC2_SDA_C,
-	FN_VI3_DATA7, FN_VI0_R3, FN_VI0_R3_B, FN_I2C2_SDA_C,
+	FN_VI3_DATA7, FN_VI0_R3, FN_VI0_R3_B, FN_I2C2_SDA_C, FN_TCLK1,
 	FN_D8, FN_SCIFA1_SCK_C, FN_AVB_TXD0,
 	FN_VI0_G0, FN_VI0_G0_B, FN_VI2_DATA0_VI2_B0,
 
@@ -547,7 +547,7 @@ enum {
 	VI0_R1_MARK, VI0_R1_B_MARK, TX0_B_MARK, D6_MARK,
 	IIC2_SCL_C_MARK, VI3_DATA6_MARK, VI0_R2_MARK, VI0_R2_B_MARK,
 	I2C2_SCL_C_MARK, D7_MARK, AD_DI_B_MARK, IIC2_SDA_C_MARK,
-	VI3_DATA7_MARK, VI0_R3_MARK, VI0_R3_B_MARK, I2C2_SDA_C_MARK,
+	VI3_DATA7_MARK, VI0_R3_MARK, VI0_R3_B_MARK, I2C2_SDA_C_MARK, TCLK1_MARK,
 	D8_MARK, SCIFA1_SCK_C_MARK, AVB_TXD0_MARK,
 	VI0_G0_MARK, VI0_G0_B_MARK, VI2_DATA0_VI2_B0_MARK,
 
@@ -900,6 +900,7 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_IPSR_MODSEL_DATA(IP0_26_23, VI0_R3, SEL_VI0_0),
 	PINMUX_IPSR_MODSEL_DATA(IP0_26_23, VI0_R3_B, SEL_VI0_1),
 	PINMUX_IPSR_MODSEL_DATA(IP0_26_23, I2C2_SDA_C, SEL_I2C2_2),
+	PINMUX_IPSR_MODSEL_DATA(IP0_26_23, TCLK1, SEL_TMU1_0),
 	PINMUX_IPSR_DATA(IP0_30_27, D8),
 	PINMUX_IPSR_MODSEL_DATA(IP0_30_27, SCIFA1_SCK_C, SEL_SCIFA1_2),
 	PINMUX_IPSR_DATA(IP0_30_27, AVB_TXD0),
@@ -3214,7 +3215,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP0_26_23 [4] */
 		FN_D7, FN_AD_DI_B, FN_IIC2_SDA_C,
 		FN_VI3_DATA7, FN_VI0_R3, FN_VI0_R3_B, FN_I2C2_SDA_C,
-		0, 0, 0, 0, 0, 0, 0, 0, 0,
+		FN_TCLK1, 0, 0, 0, 0, 0, 0, 0, 0,
 		/* IP0_22_20 [3] */
 		FN_D6, FN_IIC2_SCL_C, FN_VI3_DATA6, FN_VI0_R2, FN_VI0_R2_B,
 		FN_I2C2_SCL_C, 0, 0,
-- 
1.8.1.5
