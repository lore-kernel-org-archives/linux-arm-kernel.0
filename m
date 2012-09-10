From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 10 Sep 2012 10:59:34 +0200
Subject: [PATCH 4/7] pwm: i.MX: Use module_platform_driver
In-Reply-To: <1347267577-3296-1-git-send-email-s.hauer@pengutronix.de>
References: <1347267577-3296-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347267577-3296-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 drivers/pwm/pwm-imx.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 13d4d22..a1e799e 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -271,17 +271,7 @@ static struct platform_driver imx_pwm_driver = {
 	.remove		= __devexit_p(imx_pwm_remove),
 };
 
-static int __init imx_pwm_init(void)
-{
-	return platform_driver_register(&imx_pwm_driver);
-}
-arch_initcall(imx_pwm_init);
-
-static void __exit imx_pwm_exit(void)
-{
-	platform_driver_unregister(&imx_pwm_driver);
-}
-module_exit(imx_pwm_exit);
+module_platform_driver(imx_pwm_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.7.10.4
