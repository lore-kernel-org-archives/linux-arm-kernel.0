From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:53 +0200
Subject: [PATCH 19/19] ARM: s3c64xx: don't put smartq_bl_init in .init.text
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a section mismatch found by modpost:

	WARNING: arch/arm/mach-s3c64xx/built-in.o(.data+0x2498): Section mismatch in reference from the variable smartq_backlight_data to the function .init.text:smartq_bl_init()
	The variable smartq_backlight_data references
	the function __init smartq_bl_init()
	If the reference is valid then annotate the
	variable with __init* or __refdata (see linux/init.h) or name the variable:
	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-s3c64xx/mach-smartq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 028d080..b0bb9fb 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -135,7 +135,7 @@ static struct platform_device smartq_usb_otg_vbus_dev = {
 	.dev.platform_data	= &smartq_usb_otg_vbus_pdata,
 };
 
-static int __init smartq_bl_init(struct device *dev)
+static int smartq_bl_init(struct device *dev)
 {
     s3c_gpio_cfgpin(S3C64XX_GPF(15), S3C_GPIO_SFN(2));
 
-- 
1.7.1
