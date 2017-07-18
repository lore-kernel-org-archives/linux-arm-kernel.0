From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 18 Jul 2017 12:30:01 +0800
Subject: [RFC PATCH 3/5] serial: xuartps: Remove __init marking from early
 write
In-Reply-To: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1500352203-21513-4-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The earlycon would be alive outside the init code in these cases:
1/ we have keep_bootcon in cmdline.
2/ we don't have a real console to switch to.

So remove the __init marking to avoid invalid memory access.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fde55dc..31a630a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1163,7 +1163,7 @@ static void cdns_uart_console_putchar(struct uart_port *port, int ch)
 	writel(ch, port->membase + CDNS_UART_FIFO);
 }
 
-static void __init cdns_early_write(struct console *con, const char *s,
+static void cdns_early_write(struct console *con, const char *s,
 				    unsigned n)
 {
 	struct earlycon_device *dev = con->data;
-- 
2.1.4
