From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 22 Jan 2014 10:38:52 +0100
Subject: [PATCH] tty/serial: atmel_serial: remove dev_dbg in atmel_set_termios
Message-ID: <1390383532-2600-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a driver bug which stopped the whole system (in case
of serial console).
This log message is not useful anyway as this information is
printed elsewhere.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a49f10d269b2..3d7206fc532f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1853,13 +1853,10 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	mode &= ~ATMEL_US_USMODE;
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
-		dev_dbg(port->dev, "Setting UART to RS485\n");
 		if ((atmel_port->rs485.delay_rts_after_send) > 0)
 			UART_PUT_TTGR(port,
 					atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
-	} else {
-		dev_dbg(port->dev, "Setting UART to RS232\n");
 	}
 
 	/* set the parity, stop bits and data size */
-- 
1.8.2.2
