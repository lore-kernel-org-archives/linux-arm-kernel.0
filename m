From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  7 May 2015 18:02:39 +0900
Subject: [PATCH] serial: xuartps: add __init to earlycon write method
Message-ID: <1430989359-4364-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/xilinx_uartps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 3ddbac7..009e0db 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1075,7 +1075,8 @@ static void cdns_uart_console_putchar(struct uart_port *port, int ch)
 	writel(ch, port->membase + CDNS_UART_FIFO_OFFSET);
 }
 
-static void cdns_early_write(struct console *con, const char *s, unsigned n)
+static void __init cdns_early_write(struct console *con, const char *s,
+				    unsigned n)
 {
 	struct earlycon_device *dev = con->data;
 
-- 
1.9.1
