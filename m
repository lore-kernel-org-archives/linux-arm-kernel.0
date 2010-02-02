From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:18 -0800
Subject: [PATCH 06/16] ARM: LPC32XX: Added LPC32XX identifier to TIMER
	register field macros
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-7-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The TIMER macros and associated code have been updated with the
LPC32XX identifier.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/include/mach/platform.h |   48 ++++++++++++------------
 arch/arm/mach-lpc32xx/timer.c                 |   34 ++++++++++--------
 2 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index 099db8a..1ee148c 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -600,42 +600,42 @@
  * Timer/counter register offsets
  *
  */
-#define TIMER_IR(x)			((x) + 0x00)
-#define TIMER_TCR(x)			((x) + 0x04)
-#define TIMER_TC(x)			((x) + 0x08)
-#define TIMER_PR(x)			((x) + 0x0C)
-#define TIMER_PC(x)			((x) + 0x10)
-#define TIMER_MCR(x)			((x) + 0x14)
-#define TIMER_MR0(x)			((x) + 0x18)
-#define TIMER_MR1(x)			((x) + 0x1C)
-#define TIMER_MR2(x)			((x) + 0x20)
-#define TIMER_MR3(x)			((x) + 0x24)
-#define TIMER_CCR(x)			((x) + 0x28)
-#define TIMER_CR0(x)			((x) + 0x2C)
-#define TIMER_CR1(x)			((x) + 0x30)
-#define TIMER_CR2(x)			((x) + 0x34)
-#define TIMER_CR3(x)			((x) + 0x38)
-#define TIMER_EMR(x)			((x) + 0x3C)
-#define TIMER_CTCR(x)			((x) + 0x70)
+#define LCP32XX_TIMER_IR(x)			((x) + 0x00)
+#define LCP32XX_TIMER_TCR(x)			((x) + 0x04)
+#define LCP32XX_TIMER_TC(x)			((x) + 0x08)
+#define LCP32XX_TIMER_PR(x)			((x) + 0x0C)
+#define LCP32XX_TIMER_PC(x)			((x) + 0x10)
+#define LCP32XX_TIMER_MCR(x)			((x) + 0x14)
+#define LCP32XX_TIMER_MR0(x)			((x) + 0x18)
+#define LCP32XX_TIMER_MR1(x)			((x) + 0x1C)
+#define LCP32XX_TIMER_MR2(x)			((x) + 0x20)
+#define LCP32XX_TIMER_MR3(x)			((x) + 0x24)
+#define LCP32XX_TIMER_CCR(x)			((x) + 0x28)
+#define LCP32XX_TIMER_CR0(x)			((x) + 0x2C)
+#define LCP32XX_TIMER_CR1(x)			((x) + 0x30)
+#define LCP32XX_TIMER_CR2(x)			((x) + 0x34)
+#define LCP32XX_TIMER_CR3(x)			((x) + 0x38)
+#define LCP32XX_TIMER_EMR(x)			((x) + 0x3C)
+#define LCP32XX_TIMER_CTCR(x)			((x) + 0x70)
 
 /*
  * ir register definitions
  */
-#define TIMER_CNTR_MTCH_BIT(n)		(1 << ((n) & 0x3))
-#define TIMER_CNTR_CAPT_BIT(n)		(1 << (4 + ((n) & 0x3)))
+#define LCP32XX_TIMER_CNTR_MTCH_BIT(n)		(1 << ((n) & 0x3))
+#define LCP32XX_TIMER_CNTR_CAPT_BIT(n)		(1 << (4 + ((n) & 0x3)))
 
 /*
  * tcr register definitions
  */
-#define TIMER_CNTR_TCR_EN		0x1
-#define TIMER_CNTR_TCR_RESET		0x2
+#define LCP32XX_TIMER_CNTR_TCR_EN		0x1
+#define LCP32XX_TIMER_CNTR_TCR_RESET		0x2
 
 /*
  * mcr register definitions
  */
-#define TIMER_CNTR_MCR_MTCH(n)		(0x1 << ((n) * 3))
-#define TIMER_CNTR_MCR_RESET(n)		(0x1 << (((n) * 3) + 1))
-#define TIMER_CNTR_MCR_STOP(n)		(0x1 << (((n) * 3) + 2))
+#define LCP32XX_TIMER_CNTR_MCR_MTCH(n)		(0x1 << ((n) * 3))
+#define LCP32XX_TIMER_CNTR_MCR_RESET(n)		(0x1 << (((n) * 3) + 1))
+#define LCP32XX_TIMER_CNTR_MCR_STOP(n)		(0x1 << (((n) * 3) + 2))
 
 /*
  *
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 35f58e2..cd79017 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -40,7 +40,7 @@
 
 static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
 {
-	return (cycle_t)readl(TIMER_TC(TIMER1_IOBASE));
+	return (cycle_t)readl(LCP32XX_TIMER_TC(TIMER1_IOBASE));
 }
 
 static struct clocksource lpc32xx_clksrc = {
@@ -62,9 +62,9 @@ static int lpc32xx_clkevt_next_event(unsigned long delta,
 
 	local_irq_save(flags);
 
-	writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER0_IOBASE));
-	writel(delta, TIMER_PR(TIMER0_IOBASE));
-	writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER0_IOBASE));
+	writel(LCP32XX_TIMER_CNTR_TCR_RESET, LCP32XX_TIMER_TCR(TIMER0_IOBASE));
+	writel(delta, LCP32XX_TIMER_PR(TIMER0_IOBASE));
+	writel(LCP32XX_TIMER_CNTR_TCR_EN, LCP32XX_TIMER_TCR(TIMER0_IOBASE));
 
 	local_irq_restore(flags);
 
@@ -86,7 +86,7 @@ static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
 		 * disable the timer to wait for the first call to
 		 * set_next_event().
 		 */
-		writel(0, TIMER_TCR(TIMER0_IOBASE));
+		writel(0, LCP32XX_TIMER_TCR(TIMER0_IOBASE));
 		break;
 
 	case CLOCK_EVT_MODE_UNUSED:
@@ -109,7 +109,8 @@ static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = &lpc32xx_clkevt;
 
 	/* Clear match */
-	writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
+	writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
+		LCP32XX_TIMER_IR(TIMER0_IOBASE));
 
 	evt->event_handler(evt);
 
@@ -153,11 +154,14 @@ static void __init lpc32xx_timer_init(void)
 	clkrate = clkrate / clk_get_pclk_div();
 
 	/* Initial timer setup */
-	writel(0, TIMER_TCR(TIMER0_IOBASE));
-	writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
-	writel(1, TIMER_MR0(TIMER0_IOBASE));
-	writel(TIMER_CNTR_MCR_MTCH(0) | TIMER_CNTR_MCR_STOP(0) |
-	    TIMER_CNTR_MCR_RESET(0), TIMER_MCR(TIMER0_IOBASE));
+	writel(0, LCP32XX_TIMER_TCR(TIMER0_IOBASE));
+	writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
+		LCP32XX_TIMER_IR(TIMER0_IOBASE));
+	writel(1, LCP32XX_TIMER_MR0(TIMER0_IOBASE));
+	writel(LCP32XX_TIMER_CNTR_MCR_MTCH(0) |
+		LCP32XX_TIMER_CNTR_MCR_STOP(0) |
+		LCP32XX_TIMER_CNTR_MCR_RESET(0),
+		LCP32XX_TIMER_MCR(TIMER0_IOBASE));
 
 	/* Setup tick interrupt */
 	setup_irq(IRQ_TIMER0, &lpc32xx_timer_irq);
@@ -172,10 +176,10 @@ static void __init lpc32xx_timer_init(void)
 	clockevents_register_device(&lpc32xx_clkevt);
 
 	/* Use timer1 as clock source. */
-	writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER1_IOBASE));
-	writel(0, TIMER_PR(TIMER1_IOBASE));
-	writel(0, TIMER_MCR(TIMER1_IOBASE));
-	writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER1_IOBASE));
+	writel(LCP32XX_TIMER_CNTR_TCR_RESET, LCP32XX_TIMER_TCR(TIMER1_IOBASE));
+	writel(0, LCP32XX_TIMER_PR(TIMER1_IOBASE));
+	writel(0, LCP32XX_TIMER_MCR(TIMER1_IOBASE));
+	writel(LCP32XX_TIMER_CNTR_TCR_EN, LCP32XX_TIMER_TCR(TIMER1_IOBASE));
 	lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
 		lpc32xx_clksrc.shift);
 	clocksource_register(&lpc32xx_clksrc);
-- 
1.6.6
