From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:49 +0200
Subject: [PATCH 21/24] serial: ks8695: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-22-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/serial_ks8695.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index 7c13639..9bd004f 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -548,8 +548,8 @@ static struct uart_ops ks8695uart_pops = {
 
 static struct uart_port ks8695uart_ports[SERIAL_KS8695_NR] = {
 	{
-		.membase	= (void *) KS8695_UART_VA,
-		.mapbase	= KS8695_UART_VA,
+		.membase	= KS8695_UART_VA,
+		.mapbase	= KS8695_UART_PA,
 		.iotype		= SERIAL_IO_MEM,
 		.irq		= KS8695_IRQ_UART_TX,
 		.uartclk	= KS8695_CLOCK_RATE * 16,
-- 
1.7.10
