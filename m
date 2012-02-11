From: stigge@antcom.de (Roland Stigge)
Date: Sat, 11 Feb 2012 18:18:26 +0100
Subject: [PATCH 4/6] ARM: LPC32xx: Fix missing and bad LPC32XX macros
In-Reply-To: <1328980708-11749-1-git-send-email-stigge@antcom.de>
References: <1328980708-11749-1-git-send-email-stigge@antcom.de>
Message-ID: <1328980708-11749-5-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the LPC32XX_* macros were typed ("LCP32XX_*"), which is fixed by this
patch. (Besides another LCP doc typo.)

Further, the LPC32XX_GPIO_P2_MUX_SET/CLR/STATE macros were missing.

Signed-off-by: Roland Stigge <stigge@antcom.de>

Index: linux-2.6/arch/arm/mach-lpc32xx/include/mach/platform.h
===================================================================
--- linux-2.6.orig/arch/arm/mach-lpc32xx/include/mach/platform.h	2012-02-11 16:05:40.000000000 +0100
+++ linux-2.6/arch/arm/mach-lpc32xx/include/mach/platform.h	2012-02-11 16:20:31.000000000 +0100
@@ -591,42 +591,42 @@
 /*
  * Timer/counter register offsets
  */
-#define LCP32XX_TIMER_IR(x)			io_p2v((x) + 0x00)
-#define LCP32XX_TIMER_TCR(x)			io_p2v((x) + 0x04)
-#define LCP32XX_TIMER_TC(x)			io_p2v((x) + 0x08)
-#define LCP32XX_TIMER_PR(x)			io_p2v((x) + 0x0C)
-#define LCP32XX_TIMER_PC(x)			io_p2v((x) + 0x10)
-#define LCP32XX_TIMER_MCR(x)			io_p2v((x) + 0x14)
-#define LCP32XX_TIMER_MR0(x)			io_p2v((x) + 0x18)
-#define LCP32XX_TIMER_MR1(x)			io_p2v((x) + 0x1C)
-#define LCP32XX_TIMER_MR2(x)			io_p2v((x) + 0x20)
-#define LCP32XX_TIMER_MR3(x)			io_p2v((x) + 0x24)
-#define LCP32XX_TIMER_CCR(x)			io_p2v((x) + 0x28)
-#define LCP32XX_TIMER_CR0(x)			io_p2v((x) + 0x2C)
-#define LCP32XX_TIMER_CR1(x)			io_p2v((x) + 0x30)
-#define LCP32XX_TIMER_CR2(x)			io_p2v((x) + 0x34)
-#define LCP32XX_TIMER_CR3(x)			io_p2v((x) + 0x38)
-#define LCP32XX_TIMER_EMR(x)			io_p2v((x) + 0x3C)
-#define LCP32XX_TIMER_CTCR(x)			io_p2v((x) + 0x70)
+#define LPC32XX_TIMER_IR(x)			io_p2v((x) + 0x00)
+#define LPC32XX_TIMER_TCR(x)			io_p2v((x) + 0x04)
+#define LPC32XX_TIMER_TC(x)			io_p2v((x) + 0x08)
+#define LPC32XX_TIMER_PR(x)			io_p2v((x) + 0x0C)
+#define LPC32XX_TIMER_PC(x)			io_p2v((x) + 0x10)
+#define LPC32XX_TIMER_MCR(x)			io_p2v((x) + 0x14)
+#define LPC32XX_TIMER_MR0(x)			io_p2v((x) + 0x18)
+#define LPC32XX_TIMER_MR1(x)			io_p2v((x) + 0x1C)
+#define LPC32XX_TIMER_MR2(x)			io_p2v((x) + 0x20)
+#define LPC32XX_TIMER_MR3(x)			io_p2v((x) + 0x24)
+#define LPC32XX_TIMER_CCR(x)			io_p2v((x) + 0x28)
+#define LPC32XX_TIMER_CR0(x)			io_p2v((x) + 0x2C)
+#define LPC32XX_TIMER_CR1(x)			io_p2v((x) + 0x30)
+#define LPC32XX_TIMER_CR2(x)			io_p2v((x) + 0x34)
+#define LPC32XX_TIMER_CR3(x)			io_p2v((x) + 0x38)
+#define LPC32XX_TIMER_EMR(x)			io_p2v((x) + 0x3C)
+#define LPC32XX_TIMER_CTCR(x)			io_p2v((x) + 0x70)
 
 /*
  * ir register definitions
  */
-#define LCP32XX_TIMER_CNTR_MTCH_BIT(n)		(1 << ((n) & 0x3))
-#define LCP32XX_TIMER_CNTR_CAPT_BIT(n)		(1 << (4 + ((n) & 0x3)))
+#define LPC32XX_TIMER_CNTR_MTCH_BIT(n)		(1 << ((n) & 0x3))
+#define LPC32XX_TIMER_CNTR_CAPT_BIT(n)		(1 << (4 + ((n) & 0x3)))
 
 /*
  * tcr register definitions
  */
-#define LCP32XX_TIMER_CNTR_TCR_EN		0x1
-#define LCP32XX_TIMER_CNTR_TCR_RESET		0x2
+#define LPC32XX_TIMER_CNTR_TCR_EN		0x1
+#define LPC32XX_TIMER_CNTR_TCR_RESET		0x2
 
 /*
  * mcr register definitions
  */
-#define LCP32XX_TIMER_CNTR_MCR_MTCH(n)		(0x1 << ((n) * 3))
-#define LCP32XX_TIMER_CNTR_MCR_RESET(n)		(0x1 << (((n) * 3) + 1))
-#define LCP32XX_TIMER_CNTR_MCR_STOP(n)		(0x1 << (((n) * 3) + 2))
+#define LPC32XX_TIMER_CNTR_MCR_MTCH(n)		(0x1 << ((n) * 3))
+#define LPC32XX_TIMER_CNTR_MCR_RESET(n)		(0x1 << (((n) * 3) + 1))
+#define LPC32XX_TIMER_CNTR_MCR_STOP(n)		(0x1 << (((n) * 3) + 2))
 
 /*
  * Standard UART register offsets
@@ -690,5 +690,8 @@
 #define LPC32XX_GPIO_P1_MUX_SET			_GPREG(0x130)
 #define LPC32XX_GPIO_P1_MUX_CLR			_GPREG(0x134)
 #define LPC32XX_GPIO_P1_MUX_STATE		_GPREG(0x138)
+#define LPC32XX_GPIO_P2_MUX_SET			_GPREG(0x028)
+#define LPC32XX_GPIO_P2_MUX_CLR			_GPREG(0x02C)
+#define LPC32XX_GPIO_P2_MUX_STATE		_GPREG(0x030)
 
 #endif
Index: linux-2.6/arch/arm/mach-lpc32xx/timer.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-lpc32xx/timer.c	2012-02-11 16:05:40.000000000 +0100
+++ linux-2.6/arch/arm/mach-lpc32xx/timer.c	2012-02-11 16:20:31.000000000 +0100
@@ -34,11 +34,11 @@
 static int lpc32xx_clkevt_next_event(unsigned long delta,
     struct clock_event_device *dev)
 {
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_RESET,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
-	__raw_writel(delta, LCP32XX_TIMER_PR(LPC32XX_TIMER0_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_RESET,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(delta, LPC32XX_TIMER_PR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_EN,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
 
 	return 0;
 }
@@ -58,7 +58,7 @@
 		 * disable the timer to wait for the first call to
 		 * set_next_event().
 		 */
-		__raw_writel(0, LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+		__raw_writel(0, LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
 		break;
 
 	case CLOCK_EVT_MODE_UNUSED:
@@ -81,8 +81,8 @@
 	struct clock_event_device *evt = &lpc32xx_clkevt;
 
 	/* Clear match */
-	__raw_writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
-		LCP32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_MTCH_BIT(0),
+		LPC32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
 
 	evt->event_handler(evt);
 
@@ -128,14 +128,14 @@
 	clkrate = clkrate / clk_get_pclk_div();
 
 	/* Initial timer setup */
-	__raw_writel(0, LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
-		LCP32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
-	__raw_writel(1, LCP32XX_TIMER_MR0(LPC32XX_TIMER0_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_MCR_MTCH(0) |
-		LCP32XX_TIMER_CNTR_MCR_STOP(0) |
-		LCP32XX_TIMER_CNTR_MCR_RESET(0),
-		LCP32XX_TIMER_MCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(0, LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_MTCH_BIT(0),
+		LPC32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
+	__raw_writel(1, LPC32XX_TIMER_MR0(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_MCR_MTCH(0) |
+		LPC32XX_TIMER_CNTR_MCR_STOP(0) |
+		LPC32XX_TIMER_CNTR_MCR_RESET(0),
+		LPC32XX_TIMER_MCR(LPC32XX_TIMER0_BASE));
 
 	/* Setup tick interrupt */
 	setup_irq(IRQ_LPC32XX_TIMER0, &lpc32xx_timer_irq);
@@ -151,14 +151,14 @@
 	clockevents_register_device(&lpc32xx_clkevt);
 
 	/* Use timer1 as clock source. */
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_RESET,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
-	__raw_writel(0, LCP32XX_TIMER_PR(LPC32XX_TIMER1_BASE));
-	__raw_writel(0, LCP32XX_TIMER_MCR(LPC32XX_TIMER1_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_RESET,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
+	__raw_writel(0, LPC32XX_TIMER_PR(LPC32XX_TIMER1_BASE));
+	__raw_writel(0, LPC32XX_TIMER_MCR(LPC32XX_TIMER1_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_EN,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
 
-	clocksource_mmio_init(LCP32XX_TIMER_TC(LPC32XX_TIMER1_BASE),
+	clocksource_mmio_init(LPC32XX_TIMER_TC(LPC32XX_TIMER1_BASE),
 		"lpc32xx_clksrc", clkrate, 300, 32, clocksource_mmio_readl_up);
 }
 
Index: linux-2.6/arch/arm/mach-lpc32xx/pm.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-lpc32xx/pm.c	2012-02-11 16:45:25.000000000 +0100
+++ linux-2.6/arch/arm/mach-lpc32xx/pm.c	2012-02-11 16:46:56.000000000 +0100
@@ -13,7 +13,7 @@
 /*
  * LPC32XX CPU and system power management
  *
- * The LCP32XX has three CPU modes for controlling system power: run,
+ * The LPC32XX has three CPU modes for controlling system power: run,
  * direct-run, and halt modes. When switching between halt and run modes,
  * the CPU transistions through direct-run mode. For Linux, direct-run
  * mode is not used in normal operation. Halt mode is used when the
