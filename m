From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 16:48:09 +0100
Subject: [PATCH 1/6] serial: export fsl8250_handle_irq
In-Reply-To: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
Message-ID: <1447688894-2936779-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fsl8250_handle_irq is now used by the of_serial driver, and that fails
if it is a loadable module:

ERROR: "fsl8250_handle_irq" [drivers/tty/serial/of_serial.ko] undefined!

This exports the symbol to avoid randconfig errors.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d43b54d269d2 ("serial: Enable Freescale 16550 workaround on arm")
Cc: Scott Wood <scottwood@freescale.com>
---
 drivers/tty/serial/8250/8250_fsl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index c0533a57ec53..910bfee5a88b 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -60,3 +60,4 @@ int fsl8250_handle_irq(struct uart_port *port)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	return 1;
 }
+EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
-- 
2.1.0.rc2
