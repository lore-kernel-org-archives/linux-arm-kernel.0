From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:49 +0200
Subject: [PATCH 17/21] tty/serial/sirf: fix MODULE_DEVICE_TABLE
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes building the sirfsorc-uart driver as a loadable module,
which uses an incorrect MODULE_DEVICE_TABLE, by changing the reference to the
correct symbol.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 6bbfe99..03465b6 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -758,7 +758,7 @@ static struct of_device_id sirfsoc_uart_ids[] = {
 	{ .compatible = "sirf,marco-uart", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sirfsoc_serial_of_match);
+MODULE_DEVICE_TABLE(of, sirfsoc_uart_ids);
 
 static struct platform_driver sirfsoc_uart_driver = {
 	.probe		= sirfsoc_uart_probe,
-- 
1.8.1.2
