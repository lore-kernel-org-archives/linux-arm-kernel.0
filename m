From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 29 Mar 2012 21:58:58 +0200
Subject: [PATCH] ARM: imx/mx21ads: remove unneeded cast
Message-ID: <1333051138-27360-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-mx21ads.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index e432d4a..d14bbe9 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -304,8 +304,7 @@ static void __init mx21ads_board_init(void)
 	imx21_add_mxc_nand(&mx21ads_nand_board_info);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
-	platform_device_register_full(
-			(struct platform_device_info *)&mx21ads_cs8900_devinfo);
+	platform_device_register_full(&mx21ads_cs8900_devinfo);
 }
 
 static void __init mx21ads_timer_init(void)
-- 
1.7.9.1
