From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  9 Feb 2011 21:40:07 +0100
Subject: [PATCH 1/4] ARM: omap1/nokia770: mark some functions __init
In-Reply-To: <20110209192727.GC20795@atomide.com>
References: <20110209192727.GC20795@atomide.com>
Message-ID: <1297284010-2286-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are only called from omap_nokia770_init which is in .init.text, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-nokia770.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index d21f09d..cfd0849 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -115,7 +115,7 @@ static struct mipid_platform_data nokia770_mipid_platform_data = {
 	.shutdown = mipid_shutdown,
 };
 
-static void mipid_dev_init(void)
+static void __init mipid_dev_init(void)
 {
 	const struct omap_lcd_config *conf;
 
@@ -126,7 +126,7 @@ static void mipid_dev_init(void)
 	}
 }
 
-static void ads7846_dev_init(void)
+static void __init ads7846_dev_init(void)
 {
 	if (gpio_request(ADS7846_PENDOWN_GPIO, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
@@ -170,7 +170,7 @@ static struct hwa742_platform_data nokia770_hwa742_platform_data = {
 	.te_connected		= 1,
 };
 
-static void hwa742_dev_init(void)
+static void __init hwa742_dev_init(void)
 {
 	clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);
 	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
-- 
1.7.2.3
