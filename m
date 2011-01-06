From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu,  6 Jan 2011 21:52:47 +0200
Subject: [PATCH 2/7] ARM: S3C2410: H1940: Make h1940-bluetooth.c compile again
In-Reply-To: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
References: <1294343572-28518-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1294343572-28518-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was broken by removal of rfkill_set_led_trigger_name function,
and now compiler complains about implicit declaration.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/h1940-bluetooth.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c2410/h1940-bluetooth.c
index 6b86a72..6c59ef5 100644
--- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
@@ -85,7 +85,6 @@ static int __devinit h1940bt_probe(struct platform_device *pdev)
 	s3c_gpio_cfgpin(S3C2410_GPH(3), S3C2410_GPH3_RXD0);
 	s3c_gpio_setpull(S3C2410_GPH(3), S3C_GPIO_PULL_NONE);
 
-
 	rfk = rfkill_alloc(DRV_NAME, &pdev->dev, RFKILL_TYPE_BLUETOOTH,
 			&h1940bt_rfkill_ops, NULL);
 	if (!rfk) {
@@ -93,8 +92,6 @@ static int __devinit h1940bt_probe(struct platform_device *pdev)
 		goto err_rfk_alloc;
 	}
 
-	rfkill_set_led_trigger_name(rfk, "h1940-bluetooth");
-
 	ret = rfkill_register(rfk);
 	if (ret)
 		goto err_rfkill;
-- 
1.7.3.2
