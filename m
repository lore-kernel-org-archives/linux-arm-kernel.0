From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 04:14:17 +0000
Subject: [PATCH] ARM: SAMSUNG: Add SERIAL_SAMSUNG_UARTS_4 Kconfig option
In-Reply-To: <1264738459-1972-1-git-send-email-ben-linux@fluff.org>
References: <1264738459-1972-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264738459-1972-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SERIAL_SAMSUNG_UARTS_4 to mop up the number of cases currently using
four Samsung compatible UARTS.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/serial/Kconfig |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ebdd2b9..1d47c77 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -455,11 +455,18 @@ config SERIAL_SAMSUNG
 	  provide all of these ports, depending on how the serial port
 	  pins are configured.
 
+config SERIAL_SAMSUNG_UARTS_4
+	bool
+	depends on ARM && PLAT_SAMSUNG
+	default y if CPU_S3C2443
+	help
+	  Internal node for the common case of 4 Samsung compatible UARTs
+
 config SERIAL_SAMSUNG_UARTS
 	int
 	depends on ARM && PLAT_S3C
 	default 2 if ARCH_S3C2400
-	default 4 if ARCH_S5P6440 || ARCH_S5PC1XX || ARCH_S5PV210 || ARCH_S3C64XX || CPU_S3C2443
+	default 4 if SERIAL_SAMSUNG_UARTS_4
 	default 3
 	help
 	  Select the number of available UART ports for the Samsung S3C
@@ -526,8 +533,9 @@ config SERIAL_S3C24A0
 	  Serial port support for the Samsung S3C24A0 SoC
 
 config SERIAL_S3C6400
-	tristate "Samsung S3C6400/S3C6410/S5P6440 Serial port support"
+	tristate "Samsung S3C6400/S3C6410/S5P6440 Seria port support"
 	depends on SERIAL_SAMSUNG && (CPU_S3C6400 || CPU_S3C6410 || CPU_S5P6440)
+	select SERIAL_SAMSUNG_UARTS_4
 	default y
 	help
 	  Serial port support for the Samsung S3C6400, S3C6410 and S5P6440
@@ -536,6 +544,7 @@ config SERIAL_S3C6400
 config SERIAL_S5PC100
 	tristate "Samsung S5PC100 Serial port support"
 	depends on SERIAL_SAMSUNG && CPU_S5PC100
+	select SERIAL_SAMSUNG_UARTS_4
 	default y
 	help
 	  Serial port support for the Samsung S5PC100 SoCs
@@ -543,6 +552,7 @@ config SERIAL_S5PC100
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
 	depends on SERIAL_SAMSUNG && CPU_S5PV210
+	select SERIAL_SAMSUNG_UARTS_4
 	default y
 	help
 	  Serial port support for Samsung's S5P Family of SoC's
-- 
1.6.0.4
