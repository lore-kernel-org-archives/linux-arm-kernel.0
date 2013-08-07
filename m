From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:55 +0200
Subject: [PATCH 06/20] tty: serial: pxa: remove old cruft
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-7-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This #if-0'd block wouldn't compile, so let's dispose it.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/tty/serial/pxa.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 05f504e..cc6d539 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -332,31 +332,6 @@ static void serial_pxa_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-#if 0
-static void serial_pxa_dma_init(struct pxa_uart *up)
-{
-	up->rxdma =
-		pxa_request_dma(up->name, DMA_PRIO_LOW, pxa_receive_dma, up);
-	if (up->rxdma < 0)
-		goto out;
-	up->txdma =
-		pxa_request_dma(up->name, DMA_PRIO_LOW, pxa_transmit_dma, up);
-	if (up->txdma < 0)
-		goto err_txdma;
-	up->dmadesc = kmalloc(4 * sizeof(pxa_dma_desc), GFP_KERNEL);
-	if (!up->dmadesc)
-		goto err_alloc;
-
-	/* ... */
-err_alloc:
-	pxa_free_dma(up->txdma);
-err_rxdma:
-	pxa_free_dma(up->rxdma);
-out:
-	return;
-}
-#endif
-
 static int serial_pxa_startup(struct uart_port *port)
 {
 	struct uart_pxa_port *up = (struct uart_pxa_port *)port;
-- 
1.8.3.1
