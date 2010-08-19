From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 19 Aug 2010 11:24:46 +0900
Subject: [PATCH v2] ARM: S5PC210/S5PC110: Define correct MAX trigger at	UFCON
Message-ID: <20100819022446.GA2093@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

S5PC110/S5PC210 have different Tx/Rx trigger level on each UARTs
But now use the wrong definitions so we can't set the exact trigger level.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 788837e..4d102a9 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -199,6 +199,10 @@
 #define S5PV210_UCON_PCLK	(0<<10)
 #define S5PV210_UCON_UCLK	(1<<10)
 
+/*
+ * S5PC110/S5PC210 UART TX/RX trigger level is different@each UARTs
+ * The below wrong values will be removed. Now some boards use it. so remain it.
+ */
 #define S5PV210_UFCON_TXTRIG0	(0<<8)
 #define S5PV210_UFCON_TXTRIG4	(1<<8)
 #define S5PV210_UFCON_TXTRIG8	(2<<8)
@@ -217,6 +221,9 @@
 #define S5PV210_UFCON_RXTRIG128	(6<<4)
 #define S5PV210_UFCON_RXTRIG256	(7<<4)
 
+#define S5PV210_UFCON_TXTRIGMAX (7<<8)
+#define S5PV210_UFCON_RXTRIGMAX	(7<<4)
+
 #define S5PV210_UFSTAT_TXFULL	(1<<24)
 #define S5PV210_UFSTAT_RXFULL	(1<<8)
 #define S5PV210_UFSTAT_TXMASK	(255<<16)
