From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 13 Aug 2017 08:21:40 +0200
Subject: [PATCH 01/11] serial: meson: constify uart_ops structures
In-Reply-To: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502605310-4314-2-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/meson_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 42e4a4c..07c0f98 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -424,7 +424,7 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
 	}
 }
 
-static struct uart_ops meson_uart_ops = {
+static const struct uart_ops meson_uart_ops = {
 	.set_mctrl      = meson_uart_set_mctrl,
 	.get_mctrl      = meson_uart_get_mctrl,
 	.tx_empty	= meson_uart_tx_empty,
