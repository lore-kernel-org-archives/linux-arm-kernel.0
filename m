From: michal.simek@xilinx.com (Michal Simek)
Date: Wed,  6 Jun 2018 14:41:34 +0200
Subject: [RFC PATCH v2 1/6] serial: uartps: Do not initialize field to zero
 again
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
Message-ID: <e8b0169887855a5ef2c1a0456842f650601b451c.1528288895.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writing zero and NULLs to already initialized fields is not needed.
Remove this additional writes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8a3e34234e98..5f116f3ecd4a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1510,15 +1510,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 	/* At this point, we've got an empty uart_port struct, initialize it */
 	spin_lock_init(&port->lock);
-	port->membase	= NULL;
-	port->irq	= 0;
 	port->type	= PORT_UNKNOWN;
 	port->iotype	= UPIO_MEM32;
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
 	port->line	= id;
-	port->dev	= NULL;
 
 	/*
 	 * Register the port.
-- 
1.9.1
