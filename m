From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 17 May 2010 21:46:50 +0900
Subject: [PATCH] serial: SAMSUNG: Fix dev_name and driver_name
Message-ID: <4BF13ABA.3090504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thd dev_name and driver_name should be switched each other.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/serial/samsung.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index a9d6c56..6f3cf70 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
 
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
-	.dev_name	= "s3c2410_serial",
+	.dev_name	= S3C24XX_SERIAL_NAME,
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
-	.driver_name	= S3C24XX_SERIAL_NAME,
+	.driver_name	= "s3c2410_serial",
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
-- 
1.7.0.4
