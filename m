From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:22 +0900
Subject: [PATCH 12/17] serial: samsung: no more support for S5PC100 SoC
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-13-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes s5pc100 related serial.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 39b1219..36c7747 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1712,8 +1712,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 #define S3C2440_SERIAL_DRV_DATA (kernel_ulong_t)NULL
 #endif
 
-#if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410) || \
-	defined(CONFIG_CPU_S5PC100)
+#if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
 static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S3C6400 UART",
-- 
1.7.10.4
