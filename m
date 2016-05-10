From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 10 May 2016 20:56:10 +0200
Subject: [PATCH] serial: Make SERIAL_MPS2_UART depend on ARCH_MPS2
Message-ID: <1462906570-27684-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling support for the UART on the ARM MPS2 platform only make sense
when compiling for the ARM MPS2 platform, unless compile-testing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b84810aa8621d8b1..3def7478ca44f573 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1457,7 +1457,7 @@ config SERIAL_MPS2_UART_CONSOLE
 
 config SERIAL_MPS2_UART
 	bool "MPS2 UART port"
-	depends on ARM || COMPILE_TEST
+	depends on ARCH_MPS2 || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  This driver support the UART ports on ARM MPS2.
-- 
1.9.1
