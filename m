From: vikram.pandita@ti.com (vikram pandita)
Date: Wed, 10 Feb 2010 18:22:54 -0800
Subject: [PATCH] omap2/3/4: serial: fix coding style indentaion
Message-ID: <mailman.202.1265859869.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No logical code change

Fix coding style indentaion as per checkpatch.pl
Fix multi-line comment style reported by Nishanth Menon

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2b78400..5f3035e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -716,15 +716,16 @@ void __init omap_serial_init_port(int port)
 		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
 	}
 
-		/* omap44xx: Never read empty UART fifo
-		 * omap3xxx: Never read empty UART fifo on UARTs
-		 * with IP rev >=0x52
-		 */
-		if (cpu_is_omap44xx())
-			uart->p->serial_in = serial_in_override;
-		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
-				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
-			uart->p->serial_in = serial_in_override;
+	/*
+	 * omap44xx: Never read empty UART fifo
+	 * omap3xxx: Never read empty UART fifo on UARTs
+	 * with IP rev >=0x52
+	 */
+	if (cpu_is_omap44xx())
+		uart->p->serial_in = serial_in_override;
+	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
+			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+		uart->p->serial_in = serial_in_override;
 }
 
 /**
