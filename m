From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 12 Jul 2011 14:16:26 +0200
Subject: [PATCH 2/2] arm: mach-mxs: add rtc to all boards
In-Reply-To: <1310472986-31493-1-git-send-email-w.sang@pengutronix.de>
References: <1310472986-31493-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1310472986-31493-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@freescale.com> (for mx23evk and mx28evk)
---
 arch/arm/mach-mxs/Kconfig              |    4 ++++
 arch/arm/mach-mxs/mach-mx23evk.c       |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c       |    1 +
 arch/arm/mach-mxs/mach-stmp378x_devb.c |    1 +
 arch/arm/mach-mxs/mach-tx28.c          |    1 +
 5 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4cd0231..00bbc23 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -23,6 +23,7 @@ config MACH_STMP378X_DEVB
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_MXS_MMC
+	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
 	help
 	  Include support for STMP378x-devb platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -34,6 +35,7 @@ config MACH_MX23EVK
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
+	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
 	help
 	  Include support for MX23EVK platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -48,6 +50,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_FLEXCAN
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
+	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
 	select MXS_OCOTP
 	help
 	  Include support for MX28EVK platform. This includes specific
@@ -63,6 +66,7 @@ config MODULE_TX28
 	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXS_PWM
+	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
 
 config MACH_TX28
 	bool "Ka-Ro TX28 module"
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 3c2de33..2c8eb7c 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -167,6 +167,7 @@ static void __init mx23evk_init(void)
 		gpio_set_value(MX23EVK_BL_ENABLE, 1);
 
 	mx23_add_mxsfb(&mx23evk_mxsfb_pdata);
+	mx23_add_rtc_stmp3xxx();
 }
 
 static void __init mx23evk_timer_init(void)
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index eaaf6ff..17ae086 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -404,6 +404,7 @@ static void __init mx28evk_init(void)
 	if (ret)
 		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
 	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
+	mx28_add_rtc_stmp3xxx();
 
 	gpio_led_register_device(0, &mx28evk_led_data);
 }
diff --git a/arch/arm/mach-mxs/mach-stmp378x_devb.c b/arch/arm/mach-mxs/mach-stmp378x_devb.c
index 7f38d82..afec337 100644
--- a/arch/arm/mach-mxs/mach-stmp378x_devb.c
+++ b/arch/arm/mach-mxs/mach-stmp378x_devb.c
@@ -91,6 +91,7 @@ static void __init stmp378x_dvb_init(void)
 
 	mx23_add_duart();
 	mx23_add_auart0();
+	mx23_add_rtc_stmp3xxx();
 
 	/* power on mmc slot */
 	ret = gpio_request_one(STMP378X_DEVB_MMC0_SLOT_POWER,
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index 515a423..ce5d563 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -161,6 +161,7 @@ static void __init tx28_stk5v3_init(void)
 	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
 	mx28_add_mxs_mmc(0, &tx28_mmc0_pdata);
+	mx28_add_rtc_stmp3xxx();
 }
 
 static void __init tx28_timer_init(void)
-- 
1.7.5.4
