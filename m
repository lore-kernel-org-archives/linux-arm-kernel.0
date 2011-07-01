From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri,  1 Jul 2011 16:54:01 +0200
Subject: [PATCH] arm: mxs: add mmc-device for mach-tx28
Message-ID: <1309532041-24452-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig     |    1 +
 arch/arm/mach-mxs/mach-tx28.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index f114960..73556f0 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -59,6 +59,7 @@ config MODULE_TX28
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
 	select MXS_HAVE_PLATFORM_MXS_I2C
+	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXS_PWM
 
 config MACH_TX28
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index b65e371..91a4b78 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -147,6 +147,11 @@ static struct i2c_board_info tx28_stk5v3_i2c_boardinfo[] __initdata = {
 	},
 };
 
+static struct mxs_mmc_platform_data tx28_mmc0_pdata __initdata = {
+       .wp_gpio = -EINVAL,
+       .flags = SLOTF_4_BIT_CAPABLE,
+};
+
 static void __init tx28_stk5v3_init(void)
 {
 	mxs_iomux_setup_multiple_pads(tx28_stk5v3_pads,
@@ -164,6 +169,7 @@ static void __init tx28_stk5v3_init(void)
 	mx28_add_mxs_i2c(0);
 	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
+	mx28_add_mxs_mmc(0, &tx28_mmc0_pdata);
 }
 
 static void __init tx28_timer_init(void)
-- 
1.7.5.3
