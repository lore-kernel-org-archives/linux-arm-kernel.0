From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 09:26:31 +0900
Subject: [PATCH] s5pv210/s5pv310: Fix wrong UFCON Tx/Rx definitions
Message-ID: <20100728002631.GA25238@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PV210/V310 have different Tx/Rx trigger level on each UARTs
But now use the wrong definitions so we can't set the exact trigger level.

I think it should go rc window and also fix it at each the board.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 788837e..8839733 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -199,15 +199,52 @@
 #define S5PV210_UCON_PCLK	(0<<10)
 #define S5PV210_UCON_UCLK	(1<<10)
 
+/*
+ * S5PV210/S5PV310 UART TX trigger level is different at each UARTs
+ * The below wrong values will be removed. Now some boards use it. so remain it.
+ */
 #define S5PV210_UFCON_TXTRIG0	(0<<8)
 #define S5PV210_UFCON_TXTRIG4	(1<<8)
 #define S5PV210_UFCON_TXTRIG8	(2<<8)
 #define S5PV210_UFCON_TXTRIG16	(3<<8)
 #define S5PV210_UFCON_TXTRIG32	(4<<8)
 #define S5PV210_UFCON_TXTRIG64	(5<<8)
-#define S5PV210_UFCON_TXTRIG128 (6<<8)
-#define S5PV210_UFCON_TXTRIG256 (7<<8)
-
+#define S5PV210_UFCON_TXTRIG128	(6<<8)
+#define S5PV210_UFCON_TXTRIG256	(7<<8)
+
+#define S5PV210_UFCON_UART0_TXTRIG0	(0<<8)
+#define S5PV210_UFCON_UART0_TXTRIG32	(1<<8)
+#define S5PV210_UFCON_UART0_TXTRIG64	(2<<8)
+#define S5PV210_UFCON_UART0_TXTRIG96	(3<<8)
+#define S5PV210_UFCON_UART0_TXTRIG128	(4<<8)
+#define S5PV210_UFCON_UART0_TXTRIG160	(5<<8)
+#define S5PV210_UFCON_UART0_TXTRIG192	(6<<8)
+#define S5PV210_UFCON_UART0_TXTRIG224	(7<<8)
+
+#define S5PV210_UFCON_UART1_TXTRIG0	(0<<8)
+#define S5PV210_UFCON_UART1_TXTRIG8	(1<<8)
+#define S5PV210_UFCON_UART1_TXTRIG16	(2<<8)
+#define S5PV210_UFCON_UART1_TXTRIG24	(3<<8)
+#define S5PV210_UFCON_UART1_TXTRIG32	(4<<8)
+#define S5PV210_UFCON_UART1_TXTRIG40	(5<<8)
+#define S5PV210_UFCON_UART1_TXTRIG48	(6<<8)
+#define S5PV210_UFCON_UART1_TXTRIG56	(7<<8)
+
+#define S5PV210_UFCON_UART23_TXTRIG0	(0<<8)
+#define S5PV210_UFCON_UART23_TXTRIG2	(1<<8)
+#define S5PV210_UFCON_UART23_TXTRIG4	(2<<8)
+#define S5PV210_UFCON_UART23_TXTRIG6	(3<<8)
+#define S5PV210_UFCON_UART23_TXTRIG8	(4<<8)
+#define S5PV210_UFCON_UART23_TXTRIG10	(5<<8)
+#define S5PV210_UFCON_UART23_TXTRIG12	(6<<8)
+#define S5PV210_UFCON_UART23_TXTRIG14	(7<<8)
+
+#define S5PV210_UFCON_TXTRIGMAX		(7<<8)
+
+/*
+ * S5PV210/S5PV310 UART RX trigger level is different@each UARTs
+ * The below wrong values will be removed. Now some boards use it. so remain it.
+ */
 #define S5PV210_UFCON_RXTRIG1	(0<<4)
 #define S5PV210_UFCON_RXTRIG4	(1<<4)
 #define S5PV210_UFCON_RXTRIG8	(2<<4)
@@ -217,6 +254,35 @@
 #define S5PV210_UFCON_RXTRIG128	(6<<4)
 #define S5PV210_UFCON_RXTRIG256	(7<<4)
 
+#define S5PV210_UFCON_UART0_RXTRIG32	(0<<4)
+#define S5PV210_UFCON_UART0_RXTRIG64	(1<<4)
+#define S5PV210_UFCON_UART0_RXTRIG96	(2<<4)
+#define S5PV210_UFCON_UART0_RXTRIG128	(3<<4)
+#define S5PV210_UFCON_UART0_RXTRIG160	(4<<4)
+#define S5PV210_UFCON_UART0_RXTRIG192	(5<<4)
+#define S5PV210_UFCON_UART0_RXTRIG224	(6<<4)
+#define S5PV210_UFCON_UART0_RXTRIG256	(7<<4)
+
+#define S5PV210_UFCON_UART1_RXTRIG8	(0<<4)
+#define S5PV210_UFCON_UART1_RXTRIG16	(1<<4)
+#define S5PV210_UFCON_UART1_RXTRIG24	(2<<4)
+#define S5PV210_UFCON_UART1_RXTRIG32	(3<<4)
+#define S5PV210_UFCON_UART1_RXTRIG40	(4<<4)
+#define S5PV210_UFCON_UART1_RXTRIG48	(5<<4)
+#define S5PV210_UFCON_UART1_RXTRIG56	(6<<4)
+#define S5PV210_UFCON_UART1_RXTRIG64	(7<<4)
+
+#define S5PV210_UFCON_UART23_RXTRIG2	(0<<4)
+#define S5PV210_UFCON_UART23_RXTRIG4	(1<<4)
+#define S5PV210_UFCON_UART23_RXTRIG6	(2<<4)
+#define S5PV210_UFCON_UART23_RXTRIG8	(3<<4)
+#define S5PV210_UFCON_UART23_RXTRIG10	(4<<4)
+#define S5PV210_UFCON_UART23_RXTRIG12	(5<<4)
+#define S5PV210_UFCON_UART23_RXTRIG14	(6<<4)
+#define S5PV210_UFCON_UART23_RXTRIG16	(7<<4)
+
+#define S5PV210_UFCON_RXTRIGMAX		(7<<4)
+
 #define S5PV210_UFSTAT_TXFULL	(1<<24)
 #define S5PV210_UFSTAT_RXFULL	(1<<8)
 #define S5PV210_UFSTAT_TXMASK	(255<<16)
