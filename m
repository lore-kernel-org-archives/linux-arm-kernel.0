From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:17 +0900
Subject: [PATCH 07/17] serial: samsung: no more support for S5P6440 and S5P6450
 SoCs
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes s5p64x0 related serial because of removing
support for s5p64x0 SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig   |    1 -
 drivers/tty/serial/samsung.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fb57159..7039238 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -238,7 +238,6 @@ config SERIAL_SAMSUNG_UARTS_4
 config SERIAL_SAMSUNG_UARTS
 	int
 	depends on PLAT_SAMSUNG
-	default 6 if CPU_S5P6450
 	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
 	default 3
 	help
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c1d3ebd..39b1219 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1713,7 +1713,6 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410) || \
-	defined(CONFIG_CPU_S5P6440) || defined(CONFIG_CPU_S5P6450) || \
 	defined(CONFIG_CPU_S5PC100)
 static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
-- 
1.7.10.4
