From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon,  3 Oct 2011 11:46:14 +0200
Subject: [PATCH 1/3] tty/serial: atmel_serial: change platform_data variable
	name
Message-ID: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Easier to follow if platform_data name is pdata.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index af9b781..08b5273 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1414,13 +1414,13 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
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
@@ -1430,9 +1430,9 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
-	if (data->regs)
+	if (pdata->regs)
 		/* Already mapped by setup code */
-		port->membase = data->regs;
+		port->membase = pdata->regs;
 	else {
 		port->flags	|= UPF_IOREMAP;
 		port->membase	= NULL;
@@ -1447,9 +1447,9 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
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
1.7.3
