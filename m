From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:52 +0530
Subject: [PATCH 7/9] pinctrl: SPEAr1310: add register entries for enabling pad
 direction
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <a341163b0862f3d57da0370ceac5c2e886415238.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Pad direction must also be updated for SPEAr1310, while setting pads values.
This patch adds support for that.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear1310.c | 266 ++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index a25ab73..0436fc7 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -164,6 +164,10 @@ static const struct pinctrl_pin_desc spear1310_pins[] = {
 	#define PMX_SSP0_CS0_MASK			(1 << 29)
 	#define PMX_SSP0_CS1_2_MASK			(1 << 30)
 
+#define PAD_DIRECTION_SEL_0				0x65C
+#define PAD_DIRECTION_SEL_1				0x660
+#define PAD_DIRECTION_SEL_2				0x664
+
 /* combined macros */
 #define PMX_GMII_MASK		(PMX_GMIICLK_MASK |			\
 				PMX_GMIICOL_CRS_XFERER_MIITXCLK_MASK |	\
@@ -237,6 +241,10 @@ static struct spear_muxreg i2c0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_I2C0_MASK,
 		.val = PMX_I2C0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_I2C0_MASK,
+		.val = PMX_I2C0_MASK,
 	},
 };
 
@@ -269,6 +277,10 @@ static struct spear_muxreg ssp0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_SSP0_MASK,
 		.val = PMX_SSP0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_SSP0_MASK,
+		.val = PMX_SSP0_MASK,
 	},
 };
 
@@ -294,6 +306,10 @@ static struct spear_muxreg ssp0_cs0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_SSP0_CS0_MASK,
 		.val = PMX_SSP0_CS0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_SSP0_CS0_MASK,
+		.val = PMX_SSP0_CS0_MASK,
 	},
 };
 
@@ -319,6 +335,10 @@ static struct spear_muxreg ssp0_cs1_2_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_SSP0_CS1_2_MASK,
 		.val = PMX_SSP0_CS1_2_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_SSP0_CS1_2_MASK,
+		.val = PMX_SSP0_CS1_2_MASK,
 	},
 };
 
@@ -352,6 +372,10 @@ static struct spear_muxreg i2s0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_I2S0_MASK,
 		.val = PMX_I2S0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_I2S0_MASK,
+		.val = PMX_I2S0_MASK,
 	},
 };
 
@@ -384,6 +408,10 @@ static struct spear_muxreg i2s1_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_I2S1_MASK,
 		.val = PMX_I2S1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_I2S1_MASK,
+		.val = PMX_I2S1_MASK,
 	},
 };
 
@@ -418,6 +446,10 @@ static struct spear_muxreg clcd_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_CLCD1_MASK,
 		.val = PMX_CLCD1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_CLCD1_MASK,
+		.val = PMX_CLCD1_MASK,
 	},
 };
 
@@ -443,6 +475,10 @@ static struct spear_muxreg clcd_high_res_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_CLCD2_MASK,
 		.val = PMX_CLCD2_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_CLCD2_MASK,
+		.val = PMX_CLCD2_MASK,
 	},
 };
 
@@ -479,6 +515,14 @@ static struct spear_muxreg arm_gpio_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_EGPIO_1_GRP_MASK,
 		.val = PMX_EGPIO_1_GRP_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_EGPIO_0_GRP_MASK,
+		.val = PMX_EGPIO_0_GRP_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_EGPIO_1_GRP_MASK,
+		.val = PMX_EGPIO_1_GRP_MASK,
 	},
 };
 
@@ -511,6 +555,10 @@ static struct spear_muxreg smi_2_chips_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_SMI_MASK,
 		.val = PMX_SMI_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_SMI_MASK,
+		.val = PMX_SMI_MASK,
 	},
 };
 
@@ -539,6 +587,14 @@ static struct spear_muxreg smi_4_chips_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_SMINCS2_MASK | PMX_SMINCS3_MASK,
 		.val = PMX_SMINCS2_MASK | PMX_SMINCS3_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_SMI_MASK,
+		.val = PMX_SMI_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_SMINCS2_MASK | PMX_SMINCS3_MASK,
+		.val = PMX_SMINCS2_MASK | PMX_SMINCS3_MASK,
 	},
 };
 
@@ -573,6 +629,10 @@ static struct spear_muxreg gmii_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_GMII_MASK,
 		.val = PMX_GMII_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_GMII_MASK,
+		.val = PMX_GMII_MASK,
 	},
 };
 
@@ -615,6 +675,18 @@ static struct spear_muxreg rgmii_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_RGMII_REG2_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_RGMII_REG0_MASK,
+		.val = PMX_RGMII_REG0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_RGMII_REG1_MASK,
+		.val = PMX_RGMII_REG1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_RGMII_REG2_MASK,
+		.val = PMX_RGMII_REG2_MASK,
 	},
 };
 
@@ -649,6 +721,10 @@ static struct spear_muxreg smii_0_1_2_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_SMII_0_1_2_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_SMII_0_1_2_MASK,
+		.val = PMX_SMII_0_1_2_MASK,
 	},
 };
 
@@ -681,6 +757,10 @@ static struct spear_muxreg ras_mii_txclk_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_NFCE2_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_NFCE2_MASK,
+		.val = PMX_NFCE2_MASK,
 	},
 };
 
@@ -721,6 +801,14 @@ static struct spear_muxreg nand_8bit_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_NAND8BIT_1_MASK,
 		.val = PMX_NAND8BIT_1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_NAND8BIT_0_MASK,
+		.val = PMX_NAND8BIT_0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_NAND8BIT_1_MASK,
+		.val = PMX_NAND8BIT_1_MASK,
 	},
 };
 
@@ -747,6 +835,10 @@ static struct spear_muxreg nand_16bit_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_NAND16BIT_1_MASK,
 		.val = PMX_NAND16BIT_1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_NAND16BIT_1_MASK,
+		.val = PMX_NAND16BIT_1_MASK,
 	},
 };
 
@@ -772,6 +864,10 @@ static struct spear_muxreg nand_4_chips_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_NAND_4CHIPS_MASK,
 		.val = PMX_NAND_4CHIPS_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_NAND_4CHIPS_MASK,
+		.val = PMX_NAND_4CHIPS_MASK,
 	},
 };
 
@@ -833,6 +929,10 @@ static struct spear_muxreg keyboard_rowcol6_8_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_KBD_ROWCOL68_MASK,
 		.val = PMX_KBD_ROWCOL68_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_KBD_ROWCOL68_MASK,
+		.val = PMX_KBD_ROWCOL68_MASK,
 	},
 };
 
@@ -866,6 +966,10 @@ static struct spear_muxreg uart0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_UART0_MASK,
 		.val = PMX_UART0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_UART0_MASK,
+		.val = PMX_UART0_MASK,
 	},
 };
 
@@ -891,6 +995,10 @@ static struct spear_muxreg uart0_modem_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_UART0_MODEM_MASK,
 		.val = PMX_UART0_MODEM_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_UART0_MODEM_MASK,
+		.val = PMX_UART0_MODEM_MASK,
 	},
 };
 
@@ -923,6 +1031,10 @@ static struct spear_muxreg gpt0_tmr0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_GPT0_TMR0_MASK,
 		.val = PMX_GPT0_TMR0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_GPT0_TMR0_MASK,
+		.val = PMX_GPT0_TMR0_MASK,
 	},
 };
 
@@ -948,6 +1060,10 @@ static struct spear_muxreg gpt0_tmr1_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_GPT0_TMR1_MASK,
 		.val = PMX_GPT0_TMR1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_GPT0_TMR1_MASK,
+		.val = PMX_GPT0_TMR1_MASK,
 	},
 };
 
@@ -980,6 +1096,10 @@ static struct spear_muxreg gpt1_tmr0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_GPT1_TMR0_MASK,
 		.val = PMX_GPT1_TMR0_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_GPT1_TMR0_MASK,
+		.val = PMX_GPT1_TMR0_MASK,
 	},
 };
 
@@ -1005,6 +1125,10 @@ static struct spear_muxreg gpt1_tmr1_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_GPT1_TMR1_MASK,
 		.val = PMX_GPT1_TMR1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_GPT1_TMR1_MASK,
+		.val = PMX_GPT1_TMR1_MASK,
 	},
 };
 
@@ -1049,6 +1173,20 @@ static const unsigned mcif_pins[] = { 86, 87, 88, 89, 90, 91, 92, 93, 213, 214,
 		.reg = PAD_FUNCTION_EN_2,			\
 		.mask = PMX_MCIFALL_2_MASK,			\
 		.val = PMX_MCIFALL_2_MASK,			\
+	}, {							\
+		.reg = PAD_DIRECTION_SEL_0,			\
+		.mask = PMX_MCI_DATA8_15_MASK,			\
+		.val = PMX_MCI_DATA8_15_MASK,			\
+	}, {							\
+		.reg = PAD_DIRECTION_SEL_1,			\
+		.mask = PMX_MCIFALL_1_MASK | PMX_NFWPRT1_MASK |	\
+			PMX_NFWPRT2_MASK,			\
+		.val = PMX_MCIFALL_1_MASK | PMX_NFWPRT1_MASK |  \
+			PMX_NFWPRT2_MASK,			\
+	}, {							\
+		.reg = PAD_DIRECTION_SEL_2,			\
+		.mask = PMX_MCIFALL_2_MASK,			\
+		.val = PMX_MCIFALL_2_MASK,			\
 	}
 
 /* sdhci device */
@@ -1154,6 +1292,10 @@ static struct spear_muxreg touch_xy_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_TOUCH_XY_MASK,
 		.val = PMX_TOUCH_XY_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_TOUCH_XY_MASK,
+		.val = PMX_TOUCH_XY_MASK,
 	},
 };
 
@@ -1187,6 +1329,10 @@ static struct spear_muxreg uart1_dis_i2c_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_I2C0_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_I2C0_MASK,
+		.val = PMX_I2C0_MASK,
 	},
 };
 
@@ -1213,6 +1359,12 @@ static struct spear_muxreg uart1_dis_sd_muxreg[] = {
 		.mask = PMX_MCIDATA1_MASK |
 			PMX_MCIDATA2_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_MCIDATA1_MASK |
+			PMX_MCIDATA2_MASK,
+		.val = PMX_MCIDATA1_MASK |
+			PMX_MCIDATA2_MASK,
 	},
 };
 
@@ -1246,6 +1398,10 @@ static struct spear_muxreg uart2_3_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_I2S0_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_I2S0_MASK,
+		.val = PMX_I2S0_MASK,
 	},
 };
 
@@ -1278,6 +1434,10 @@ static struct spear_muxreg uart4_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_I2S0_MASK | PMX_CLCD1_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_I2S0_MASK | PMX_CLCD1_MASK,
+		.val = PMX_I2S0_MASK | PMX_CLCD1_MASK,
 	},
 };
 
@@ -1310,6 +1470,10 @@ static struct spear_muxreg uart5_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_CLCD1_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_CLCD1_MASK,
+		.val = PMX_CLCD1_MASK,
 	},
 };
 
@@ -1344,6 +1508,10 @@ static struct spear_muxreg rs485_0_1_tdm_0_1_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_CLCD1_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_CLCD1_MASK,
+		.val = PMX_CLCD1_MASK,
 	},
 };
 
@@ -1376,6 +1544,10 @@ static struct spear_muxreg i2c_1_2_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_CLCD1_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_CLCD1_MASK,
+		.val = PMX_CLCD1_MASK,
 	},
 };
 
@@ -1409,6 +1581,10 @@ static struct spear_muxreg i2c3_dis_smi_clcd_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_CLCD1_MASK | PMX_SMI_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_CLCD1_MASK | PMX_SMI_MASK,
+		.val = PMX_CLCD1_MASK | PMX_SMI_MASK,
 	},
 };
 
@@ -1435,6 +1611,10 @@ static struct spear_muxreg i2c3_dis_sd_i2s0_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_I2S1_MASK | PMX_MCIDATA3_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_I2S1_MASK | PMX_MCIDATA3_MASK,
+		.val = PMX_I2S1_MASK | PMX_MCIDATA3_MASK,
 	},
 };
 
@@ -1469,6 +1649,10 @@ static struct spear_muxreg i2c_4_5_dis_smi_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_0,
 		.mask = PMX_SMI_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_SMI_MASK,
+		.val = PMX_SMI_MASK,
 	},
 };
 
@@ -1499,6 +1683,14 @@ static struct spear_muxreg i2c4_dis_sd_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_MCIDATA5_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_MCIDATA4_MASK,
+		.val = PMX_MCIDATA4_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCIDATA5_MASK,
+		.val = PMX_MCIDATA5_MASK,
 	},
 };
 
@@ -1526,6 +1718,12 @@ static struct spear_muxreg i2c5_dis_sd_muxreg[] = {
 		.mask = PMX_MCIDATA6_MASK |
 			PMX_MCIDATA7_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCIDATA6_MASK |
+			PMX_MCIDATA7_MASK,
+		.val = PMX_MCIDATA6_MASK |
+			PMX_MCIDATA7_MASK,
 	},
 };
 
@@ -1560,6 +1758,10 @@ static struct spear_muxreg i2c_6_7_dis_kbd_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_KBD_ROWCOL25_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_KBD_ROWCOL25_MASK,
+		.val = PMX_KBD_ROWCOL25_MASK,
 	},
 };
 
@@ -1587,6 +1789,12 @@ static struct spear_muxreg i2c6_dis_sd_muxreg[] = {
 		.mask = PMX_MCIIORDRE_MASK |
 			PMX_MCIIOWRWE_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCIIORDRE_MASK |
+			PMX_MCIIOWRWE_MASK,
+		.val = PMX_MCIIORDRE_MASK |
+			PMX_MCIIOWRWE_MASK,
 	},
 };
 
@@ -1613,6 +1821,12 @@ static struct spear_muxreg i2c7_dis_sd_muxreg[] = {
 		.mask = PMX_MCIRESETCF_MASK |
 			PMX_MCICS0CE_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCIRESETCF_MASK |
+			PMX_MCICS0CE_MASK,
+		.val = PMX_MCIRESETCF_MASK |
+			PMX_MCICS0CE_MASK,
 	},
 };
 
@@ -1651,6 +1865,14 @@ static struct spear_muxreg can0_dis_nor_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_NFRSTPWDWN3_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_NFRSTPWDWN2_MASK,
+		.val = PMX_NFRSTPWDWN2_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_NFRSTPWDWN3_MASK,
+		.val = PMX_NFRSTPWDWN3_MASK,
 	},
 };
 
@@ -1677,6 +1899,10 @@ static struct spear_muxreg can0_dis_sd_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_MCICFINTR_MASK | PMX_MCIIORDY_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCICFINTR_MASK | PMX_MCIIORDY_MASK,
+		.val = PMX_MCICFINTR_MASK | PMX_MCIIORDY_MASK,
 	},
 };
 
@@ -1711,6 +1937,10 @@ static struct spear_muxreg can1_dis_sd_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_MCICS1_MASK | PMX_MCIDMAACK_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCICS1_MASK | PMX_MCIDMAACK_MASK,
+		.val = PMX_MCICS1_MASK | PMX_MCIDMAACK_MASK,
 	},
 };
 
@@ -1737,6 +1967,10 @@ static struct spear_muxreg can1_dis_kbd_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_1,
 		.mask = PMX_KBD_ROWCOL25_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_KBD_ROWCOL25_MASK,
+		.val = PMX_KBD_ROWCOL25_MASK,
 	},
 };
 
@@ -1782,6 +2016,18 @@ static struct spear_muxreg pci_muxreg[] = {
 		.reg = PAD_FUNCTION_EN_2,
 		.mask = PMX_PCI_REG2_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_0,
+		.mask = PMX_MCI_DATA8_15_MASK,
+		.val = PMX_MCI_DATA8_15_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_PCI_REG1_MASK,
+		.val = PMX_PCI_REG1_MASK,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_PCI_REG2_MASK,
+		.val = PMX_PCI_REG2_MASK,
 	},
 };
 
@@ -1964,6 +2210,14 @@ static struct spear_muxreg ssp1_dis_kbd_muxreg[] = {
 			PMX_KBD_COL0_MASK | PMX_NFIO8_15_MASK | PMX_NFCE1_MASK |
 			PMX_NFCE2_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_1,
+		.mask = PMX_KBD_ROWCOL25_MASK | PMX_KBD_COL1_MASK |
+			PMX_KBD_COL0_MASK | PMX_NFIO8_15_MASK | PMX_NFCE1_MASK |
+			PMX_NFCE2_MASK,
+		.val = PMX_KBD_ROWCOL25_MASK | PMX_KBD_COL1_MASK |
+			PMX_KBD_COL0_MASK | PMX_NFIO8_15_MASK | PMX_NFCE1_MASK |
+			PMX_NFCE2_MASK,
 	},
 };
 
@@ -1990,6 +2244,12 @@ static struct spear_muxreg ssp1_dis_sd_muxreg[] = {
 		.mask = PMX_MCIADDR0ALE_MASK | PMX_MCIADDR2_MASK |
 			PMX_MCICECF_MASK | PMX_MCICEXD_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCIADDR0ALE_MASK | PMX_MCIADDR2_MASK |
+			PMX_MCICECF_MASK | PMX_MCICEXD_MASK,
+		.val = PMX_MCIADDR0ALE_MASK | PMX_MCIADDR2_MASK |
+			PMX_MCICECF_MASK | PMX_MCICEXD_MASK,
 	},
 };
 
@@ -2024,6 +2284,12 @@ static struct spear_muxreg gpt64_muxreg[] = {
 		.mask = PMX_MCICDCF1_MASK | PMX_MCICDCF2_MASK | PMX_MCICDXD_MASK
 			| PMX_MCILEDS_MASK,
 		.val = 0,
+	}, {
+		.reg = PAD_DIRECTION_SEL_2,
+		.mask = PMX_MCICDCF1_MASK | PMX_MCICDCF2_MASK | PMX_MCICDXD_MASK
+			| PMX_MCILEDS_MASK,
+		.val = PMX_MCICDCF1_MASK | PMX_MCICDCF2_MASK | PMX_MCICDXD_MASK
+			| PMX_MCILEDS_MASK,
 	},
 };
 
-- 
1.7.12.rc2.18.g61b472e
