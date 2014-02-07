From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri,  7 Feb 2014 15:59:08 +0100
Subject: [PATCH 1/8] tty/serial: at91: use dev_err instead of printk
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1391785155-18525-2-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For better consistency.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 91c0d8839570..ed9621a21d67 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1549,7 +1549,7 @@ static int atmel_startup(struct uart_port *port)
 	retval = request_irq(port->irq, atmel_interrupt, IRQF_SHARED,
 			tty ? tty->name : "atmel_serial", port);
 	if (retval) {
-		printk("atmel_serial: atmel_startup - Can't get irq\n");
+		dev_err(port->dev, "atmel_startup - Can't get irq\n");
 		return retval;
 	}
 
@@ -1732,7 +1732,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 		clk_disable_unprepare(atmel_port->clk);
 		break;
 	default:
-		printk(KERN_ERR "atmel_serial: unknown pm %d\n", state);
+		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
 	}
 }
 
-- 
1.8.5
