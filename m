From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:23 +0100
Subject: [PATCH 03/13] ARM i.MX31 mx31ads: remove unnecessary CONFIG_I2C ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-mx31ads.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 88b97d6..f9a7109 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -476,7 +476,6 @@ static struct wm8350_platform_data __initdata mx31_wm8350_pdata = {
 };
 #endif
 
-#if defined(CONFIG_I2C_IMX) || defined(CONFIG_I2C_IMX_MODULE)
 static struct i2c_board_info __initdata mx31ads_i2c1_devices[] = {
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
 	{
@@ -497,11 +496,6 @@ static void mxc_init_i2c(void)
 
 	imx31_add_imx_i2c1(NULL);
 }
-#else
-static void mxc_init_i2c(void)
-{
-}
-#endif
 
 static unsigned int ssi_pins[] = {
 	MX31_PIN_SFS5__SFS5,
-- 
1.7.2.3
