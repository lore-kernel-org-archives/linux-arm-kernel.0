From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:14:23 +0900
Subject: [PATCH 06/11] serial: sh-sci: Don't check IRQ in verify port operation
In-Reply-To: <cover.1387887969.git.horms+renesas@verge.net.au>
References: <cover.1387887969.git.horms+renesas@verge.net.au>
Message-ID: <bc14e00672b563f41a1ac1d421b5c78c94868983.1387887969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The IRQ number can't be modified by the user as the port is fixed.
There's no need to check the new IRQ number as it will be ignored by the
core.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 67dadbd..b3d0e00 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2118,10 +2118,6 @@ static void sci_config_port(struct uart_port *port, int flags)
 
 static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	struct sci_port *s = to_sci_port(port);
-
-	if (ser->irq != s->cfg->irqs[SCIx_TXI_IRQ])
-		return -EINVAL;
 	if (ser->baud_base < 2400)
 		/* No paper tape reader for Mitch.. */
 		return -EINVAL;
-- 
1.8.4
