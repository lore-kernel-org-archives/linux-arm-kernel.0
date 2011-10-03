From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon,  3 Oct 2011 11:46:15 +0200
Subject: [PATCH 2/3] tty/serial: atmel_serial: whitespace and braces
	modifications
In-Reply-To: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com>
References: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com>
Message-ID: <0349cfe6fbc65fec3321c588f39e01d37dcbc6b8.1317634987.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 08b5273..a652f8f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1430,10 +1430,10 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
-	if (pdata->regs)
+	if (pdata->regs) {
 		/* Already mapped by setup code */
 		port->membase = pdata->regs;
-	else {
+	} else {
 		port->flags	|= UPF_IOREMAP;
 		port->membase	= NULL;
 	}
@@ -1447,9 +1447,10 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 		/* only enable clock when USART is in use */
 	}
 
-	atmel_port->use_dma_rx = pdata->use_dma_rx;
-	atmel_port->use_dma_tx = pdata->use_dma_tx;
+	atmel_port->use_dma_rx	= pdata->use_dma_rx;
+	atmel_port->use_dma_tx	= pdata->use_dma_tx;
 	atmel_port->rs485	= pdata->rs485;
+
 	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-- 
1.7.3
