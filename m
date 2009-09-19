From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 19 Sep 2009 09:09:50 +0200
Subject: [PATCH] i2c/imx: make bus available early
Message-ID: <1253344190-12896-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I2C is used by PMICs also, make the busses available early via
subsys_initcall().

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-imx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 0b486a6..4afba3e 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -609,13 +609,12 @@ static int __init i2c_adap_imx_init(void)
 {
 	return platform_driver_probe(&i2c_imx_driver, i2c_imx_probe);
 }
+subsys_initcall(i2c_adap_imx_init);
 
 static void __exit i2c_adap_imx_exit(void)
 {
 	platform_driver_unregister(&i2c_imx_driver);
 }
-
-module_init(i2c_adap_imx_init);
 module_exit(i2c_adap_imx_exit);
 
 MODULE_LICENSE("GPL");
-- 
1.6.3.3
