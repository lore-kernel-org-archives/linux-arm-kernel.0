From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Sun, 25 May 2014 23:13:05 +0200
Subject: [PATCH] serial: efm32: add module_exit
Message-ID: <1401052385-3786-1-git-send-email-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing specification of efm32_uart_exit as module_exit.

This fixes the following compilation warning:

  drivers/tty/serial/efm32-uart.c:840:123: warning: ?efm32_uart_exit? defined but not used [-Wunused-function]

Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Jiri Slaby <jslaby@suse.cz>
---

Hi,

This can be seen with e.g. arm allmodconfig.

Best regards,

V.

 drivers/tty/serial/efm32-uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index c167a71..b373f64 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -842,6 +842,7 @@ static void __exit efm32_uart_exit(void)
 	platform_driver_unregister(&efm32_uart_driver);
 	uart_unregister_driver(&efm32_uart_reg);
 }
+module_exit(efm32_uart_exit);
 
 MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
 MODULE_DESCRIPTION("EFM32 UART/USART driver");
-- 
2.0.0.rc2
