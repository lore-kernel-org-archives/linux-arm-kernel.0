From: augulis.darius@gmail.com (Darius Augulis)
Date: Thu, 05 Aug 2010 23:10:18 +0300
Subject: [PATCH] serial: samsung: fix device name
Message-ID: <20100805201000.14030.34703.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Swap device and driver names in serial/samsung.c

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 drivers/serial/samsung.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index a9d6c56..9d63f24 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
 
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
-	.dev_name	= "s3c2410_serial",
+	.driver_name    = "s3c2410_serial",
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
-	.driver_name	= S3C24XX_SERIAL_NAME,
+	.dev_name       = S3C24XX_SERIAL_NAME,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
