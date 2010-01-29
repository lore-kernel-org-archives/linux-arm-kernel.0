From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 29 Jan 2010 11:06:37 +0900
Subject: [PATCH v2 7/7] ARM: S5P6442: Add serial port support
Message-ID: <1264730797-16166-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds UART serial port support for S5P6442.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/dev-uart.c |    2 ++
 drivers/serial/Kconfig       |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-s5p/dev-uart.c
index 23c7531..a89331e 100644
--- a/arch/arm/plat-s5p/dev-uart.c
+++ b/arch/arm/plat-s5p/dev-uart.c
@@ -95,6 +95,7 @@ static struct resource s5p_uart2_resource[] = {
 };
 
 static struct resource s5p_uart3_resource[] = {
+#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
 	[0] = {
 		.start	= S5P_PA_UART3,
 		.end	= S5P_PA_UART3 + S5P_SZ_UART,
@@ -115,6 +116,7 @@ static struct resource s5p_uart3_resource[] = {
 		.end	= IRQ_S5P_UART_ERR3,
 		.flags	= IORESOURCE_IRQ,
 	},
+#endif
 };
 
 struct s3c24xx_uart_resources s5p_uart_resources[] __initdata = {
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ebdd2b9..f587b88 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -542,7 +542,7 @@ config SERIAL_S5PC100
 
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && CPU_S5PV210
+	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442)
 	default y
 	help
 	  Serial port support for Samsung's S5P Family of SoC's
-- 
1.6.2.5
