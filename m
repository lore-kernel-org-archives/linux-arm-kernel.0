From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Aug 2012 13:32:56 +0300
Subject: [PATCH v3 16/23] serial: omap: drop "inline" from IRQ handler
 prototype
In-Reply-To: <1345717983-18179-1-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
Message-ID: <1345717983-18179-17-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it makes no sense to mark our IRQ handler inline
since it's passed as a function pointer when
enabling the IRQ line.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index bdfd019..ba22247 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -344,7 +344,7 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
  * @irq: uart port irq number
  * @dev_id: uart port info
  */
-static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
+static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 {
 	struct uart_omap_port *up = dev_id;
 	struct tty_struct *tty = up->port.state->port.tty;
-- 
1.7.12.rc3
