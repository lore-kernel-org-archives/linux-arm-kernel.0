From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 8 Jul 2011 23:59:47 +0800
Subject: [PATCH 07/10] ARM: mxs: add sgtl5000 i2c device
In-Reply-To: <1310140790-2132-1-git-send-email-b29396@freescale.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
Message-ID: <1310140790-2132-8-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/mach-mxs/mach-mx28evk.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 7837a87..c8b154a 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -186,6 +186,12 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* led */
 	MX28_PAD_AUART1_TX__GPIO_3_5 | MXS_PAD_CTRL,
 
+	/* I2C */
+	MX28_PAD_I2C0_SCL__I2C0_SCL |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_I2C0_SDA__I2C0_SDA |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+
 	/* saif0 & saif1 */
 	MX28_PAD_SAIF0_MCLK__SAIF0_MCLK |
 		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
@@ -366,6 +372,12 @@ static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] __initdata = {
 	},
 };
 
+static struct i2c_board_info mxs_i2c0_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("sgtl5000", 0x0a),
+	},
+};
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -409,6 +421,10 @@ static void __init mx28evk_init(void)
 	mx28_add_saif(0);
 	mx28_add_saif(1);
 
+	mx28_add_mxs_i2c(0);
+	i2c_register_board_info(0, mxs_i2c0_board_info,
+				ARRAY_SIZE(mxs_i2c0_board_info));
+
 	/*set the saif clk mux, both saif0/saif1 use saif0 clk*/
 	__raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);
 
-- 
1.7.0.4
