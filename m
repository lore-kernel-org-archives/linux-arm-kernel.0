From: alexey.pelykh@gmail.com (Alexey Pelykh)
Date: Sat, 21 Sep 2013 04:10:54 -0400
Subject: [PATCH] OMAP/serial: Fix Mode13 vs Mode16 priority
Message-ID: <20130921081054.GA15775@inertiallabs-linux64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Pelykh <alexey.pelykh@gmail.com>

Make Mode16 more preferred than Mode13, to match TRM baudrates table.

Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-omap at vger.kernel.org
Cc: linux-kernel at vger.kernel.org

---

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7d348c8..146e712 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -247,7 +247,7 @@ serial_omap_baud_is_mode16(struct uart_port *port, unsigned int baud)
 	if(baudAbsDiff16 < 0)
 		baudAbsDiff16 = -baudAbsDiff16;
 
-	return (baudAbsDiff13 > baudAbsDiff16);
+	return (baudAbsDiff13 >= baudAbsDiff16);
 }
 
 /*
