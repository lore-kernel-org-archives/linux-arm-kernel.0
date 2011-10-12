From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Oct 2011 18:06:57 +0200
Subject: [PATCH v2 2/5] tty/serial: atmel_serial: change platform_data
	variable name
In-Reply-To: <1318435620-7481-1-git-send-email-nicolas.ferre@atmel.com>
References: <1318435620-7481-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <58d65421a85737b7a25b967da09c3f564fc49be7.1318433947.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Easier to follow if platform_data name is pdata.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c7232a9..a507daa 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1417,13 +1417,13 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 				      struct platform_device *pdev)
 {
 	struct uart_port *port = &atmel_port->uart;
-	struct atmel_uart_data *data = pdev->dev.platform_data;
+	struct atmel_uart_data *pdata = pdev->dev.platform_data;
 
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF;
 	port->ops		= &atmel_pops;
 	port->fifosize		= 1;
-	port->line		= data->num;
+	port->line		= pdata->num;
 	port->dev		= &pdev->dev;
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
@@ -1433,9 +1433,9 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
-	if (data->regs)
+	if (pdata->regs)
 		/* Already mapped by setup code */
-		port->membase = data->regs;
+		port->membase = pdata->regs;
 	else {
 		port->flags	|= UPF_IOREMAP;
 		port->membase	= NULL;
@@ -1450,9 +1450,9 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 		/* only enable clock when USART is in use */
 	}
 
-	atmel_port->use_dma_rx = data->use_dma_rx;
-	atmel_port->use_dma_tx = data->use_dma_tx;
-	atmel_port->rs485	= data->rs485;
+	atmel_port->use_dma_rx = pdata->use_dma_rx;
+	atmel_port->use_dma_tx = pdata->use_dma_tx;
+	atmel_port->rs485	= pdata->rs485;
 	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-- 
1.7.5.4
