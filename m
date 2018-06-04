From: h.grohne@intenta.de (Helmut Grohne)
Date: Mon, 4 Jun 2018 12:22:19 +0200
Subject: [PATCH v3 3/3] serial: xuartps: remove unnecessary register write
In-Reply-To: <cover.1528106392.git.h.grohne@intenta.de>
References: <cover.1528106392.git.h.grohne@intenta.de>
Message-ID: <44a8e1a32472fe7c54edb04f92ebc20466fde4af.1528106392.git.h.grohne@intenta.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This writel writes the exact same value as the previous writel and is
thus unnecessary. It accidentally became unnecessary in e3538c37ee38
("tty: xuartps: Beautify read-modify writes"), but the new behaviour is
now expected.

Link: https://www.spinics.net/lists/linux-serial/msg23168.html
Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
---
 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a34b2c757593..7a2b1a7350ac 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1238,8 +1238,6 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 			CDNS_UART_SR_TXEMPTY)
 		cpu_relax();
 
-	writel(ctrl, port->membase + CDNS_UART_CR);
-
 	/* restore interrupt state */
 	writel(imr, port->membase + CDNS_UART_IER);
 
-- 
2.11.0
