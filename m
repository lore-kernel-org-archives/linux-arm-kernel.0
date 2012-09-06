From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  6 Sep 2012 14:48:10 +0200
Subject: [PATCH 4/9] pwm i.MX: Use module_platform_driver
In-Reply-To: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
References: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1346935695-25179-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 drivers/pwm/pwm-imx.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 242a30d..97f385e 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -270,17 +270,7 @@ static struct platform_driver imx_pwm_driver = {
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
