From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 11 Nov 2011 23:12:40 +0800
Subject: [PATCH 2/2] ARM: mxs: remove mmc_platform_data __initdata attribute
In-Reply-To: <1321024360-5249-1-git-send-email-b29396@freescale.com>
References: <1321024360-5249-1-git-send-email-b29396@freescale.com>
Message-ID: <1321024360-5249-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmc driver still uses it after init.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/mach-mx23evk.c       |    2 +-
 arch/arm/mach-mxs/mach-mx28evk.c       |    2 +-
 arch/arm/mach-mxs/mach-stmp378x_devb.c |    2 +-
 arch/arm/mach-mxs/mach-tx28.c          |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 2c8eb7c..9a0c568 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -133,7 +133,7 @@ static const struct mxsfb_platform_data mx23evk_mxsfb_pdata __initconst = {
 	.ld_intf_width	= STMLCDIF_24BIT,
 };
 
-static struct mxs_mmc_platform_data mx23evk_mmc_pdata __initdata = {
+static struct mxs_mmc_platform_data mx23evk_mmc_pdata = {
 	.wp_gpio = MX23EVK_MMC0_WRITE_PROTECT,
 	.flags = SLOTF_8_BIT_CAPABLE,
 };
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 226ba64..9a57da9 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -361,7 +361,7 @@ static const struct mxsfb_platform_data mx28evk_mxsfb_pdata __initconst = {
 	.ld_intf_width	= STMLCDIF_24BIT,
 };
 
-static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] __initdata = {
+static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] = {
 	{
 		/* mmc0 */
 		.wp_gpio = MX28EVK_MMC0_WRITE_PROTECT,
diff --git a/arch/arm/mach-mxs/mach-stmp378x_devb.c b/arch/arm/mach-mxs/mach-stmp378x_devb.c
index afec337..aaf06bf 100644
--- a/arch/arm/mach-mxs/mach-stmp378x_devb.c
+++ b/arch/arm/mach-mxs/mach-stmp378x_devb.c
@@ -66,7 +66,7 @@ static const iomux_cfg_t stmp378x_dvb_pads[] __initconst = {
 	MX23_PAD_PWM3__GPIO_1_29 | MXS_PAD_CTRL, /* power enable */
 };
 
-static struct mxs_mmc_platform_data stmp378x_dvb_mmc_pdata __initdata = {
+static struct mxs_mmc_platform_data stmp378x_dvb_mmc_pdata = {
 	.wp_gpio = STMP378X_DEVB_MMC0_WRITE_PROTECT,
 };
 
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index ce5d563..ec8337e 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -139,7 +139,7 @@ static struct i2c_board_info tx28_stk5v3_i2c_boardinfo[] __initdata = {
 	},
 };
 
-static struct mxs_mmc_platform_data tx28_mmc0_pdata __initdata = {
+static struct mxs_mmc_platform_data tx28_mmc0_pdata = {
        .wp_gpio = -EINVAL,
        .flags = SLOTF_4_BIT_CAPABLE,
 };
-- 
1.7.0.4
