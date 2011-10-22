From: yong.zhang0@gmail.com (Yong Zhang)
Date: Sat, 22 Oct 2011 17:56:15 +0800
Subject: [PATCH 03/49] arm: irq: Remove IRQF_DISABLED
In-Reply-To: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
Message-ID: <1319277421-9203-4-git-send-email-yong.zhang0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: "Hans J. Koch" <hjk@hansjkoch.de>
Acked-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Alexey Charkov <alchark@gmail.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: John Linn <john.linn@xilinx.com>
Acked-by: David Brown <davidb@codeaurora.org>
Acked-by: Jiandong Zheng <jdzheng@broadcom.com>
Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/common/time-acorn.c                |    1 -
 arch/arm/common/timer-sp.c                  |    2 +-
 arch/arm/include/asm/floppy.h               |    2 +-
 arch/arm/kernel/perf_event.c                |    2 +-
 arch/arm/mach-at91/at91rm9200_time.c        |    2 +-
 arch/arm/mach-at91/at91sam926x_time.c       |    2 +-
 arch/arm/mach-at91/at91x40_time.c           |    2 +-
 arch/arm/mach-bcmring/dma.c                 |    2 +-
 arch/arm/mach-clps711x/time.c               |    2 +-
 arch/arm/mach-cns3xxx/core.c                |    2 +-
 arch/arm/mach-davinci/board-da830-evm.c     |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    2 +-
 arch/arm/mach-davinci/time.c                |    4 ++--
 arch/arm/mach-ebsa110/core.c                |    2 +-
 arch/arm/mach-ep93xx/core.c                 |    2 +-
 arch/arm/mach-footbridge/dc21285-timer.c    |    2 +-
 arch/arm/mach-footbridge/dc21285.c          |   10 +++++-----
 arch/arm/mach-footbridge/isa-timer.c        |    2 +-
 arch/arm/mach-gemini/time.c                 |    2 +-
 arch/arm/mach-h720x/cpu-h7201.c             |    2 +-
 arch/arm/mach-h720x/cpu-h7202.c             |    2 +-
 arch/arm/mach-imx/mach-armadillo5x0.c       |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c           |    2 +-
 arch/arm/mach-imx/mach-pca100.c             |    2 +-
 arch/arm/mach-imx/mach-pcm037.c             |    2 +-
 arch/arm/mach-imx/mx31lilly-db.c            |    2 +-
 arch/arm/mach-integrator/integrator_ap.c    |    2 +-
 arch/arm/mach-ixp2000/core.c                |    2 +-
 arch/arm/mach-ixp23xx/core.c                |    2 +-
 arch/arm/mach-ixp4xx/common.c               |    2 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c        |    2 +-
 arch/arm/mach-ixp4xx/fsg-setup.c            |    4 ++--
 arch/arm/mach-ixp4xx/nas100d-setup.c        |    2 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c          |    4 ++--
 arch/arm/mach-ks8695/time.c                 |    2 +-
 arch/arm/mach-lpc32xx/timer.c               |    2 +-
 arch/arm/mach-mmp/time.c                    |    2 +-
 arch/arm/mach-msm/timer.c                   |    4 ++--
 arch/arm/mach-netx/time.c                   |    2 +-
 arch/arm/mach-omap1/fpga.c                  |    4 ++--
 arch/arm/mach-omap1/pm.c                    |    1 -
 arch/arm/mach-omap1/time.c                  |    2 +-
 arch/arm/mach-omap1/timer32k.c              |    2 +-
 arch/arm/mach-omap2/omap_l3_noc.c           |    4 ++--
 arch/arm/mach-omap2/omap_l3_smx.c           |    4 ++--
 arch/arm/mach-omap2/pm34xx.c                |    2 +-
 arch/arm/mach-omap2/timer.c                 |    2 +-
 arch/arm/mach-pnx4008/time.c                |    2 +-
 arch/arm/mach-pxa/am200epd.c                |    2 +-
 arch/arm/mach-pxa/am300epd.c                |    2 +-
 arch/arm/mach-pxa/em-x270.c                 |    2 +-
 arch/arm/mach-pxa/magician.c                |    2 +-
 arch/arm/mach-pxa/mainstone.c               |    2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c        |    2 +-
 arch/arm/mach-pxa/sharpsl_pm.c              |    8 ++++----
 arch/arm/mach-pxa/time.c                    |    2 +-
 arch/arm/mach-pxa/trizeps4.c                |    2 +-
 arch/arm/mach-rpc/dma.c                     |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq.c         |    2 +-
 arch/arm/mach-sa1100/dma.c                  |    2 +-
 arch/arm/mach-sa1100/time.c                 |    2 +-
 arch/arm/mach-shark/core.c                  |    2 +-
 arch/arm/mach-tcc8k/time.c                  |    2 +-
 arch/arm/mach-tegra/timer.c                 |    2 +-
 arch/arm/mach-u300/timer.c                  |    2 +-
 arch/arm/mach-vt8500/timer.c                |    2 +-
 arch/arm/mach-w90x900/time.c                |    2 +-
 arch/arm/mach-zynq/timer.c                  |    2 +-
 arch/arm/plat-iop/time.c                    |    2 +-
 arch/arm/plat-mxc/Kconfig                   |    2 +-
 arch/arm/plat-mxc/epit.c                    |    2 +-
 arch/arm/plat-mxc/time.c                    |    2 +-
 arch/arm/plat-nomadik/timer.c               |    2 +-
 arch/arm/plat-omap/dma.c                    |    1 -
 arch/arm/plat-orion/time.c                  |    2 +-
 arch/arm/plat-pxa/dma.c                     |    2 +-
 arch/arm/plat-s3c24xx/dma.c                 |    2 +-
 arch/arm/plat-s5p/s5p-time.c                |    2 +-
 arch/arm/plat-s5p/sysmmu.c                  |    2 +-
 arch/arm/plat-samsung/time.c                |    2 +-
 arch/arm/plat-spear/time.c                  |    2 +-
 82 files changed, 93 insertions(+), 96 deletions(-)

diff --git a/arch/arm/common/time-acorn.c b/arch/arm/common/time-acorn.c
index deeed56..e3fcd71 100644
--- a/arch/arm/common/time-acorn.c
+++ b/arch/arm/common/time-acorn.c
@@ -75,7 +75,6 @@ ioc_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction ioc_timer_irq = {
 	.name		= "timer",
-	.flags		= IRQF_DISABLED,
 	.handler	= ioc_timer_interrupt
 };
 
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 2393b5b..f9da742 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -153,7 +153,7 @@ static struct clock_event_device sp804_clockevent = {
 
 static struct irqaction sp804_timer_irq = {
 	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= sp804_timer_interrupt,
 	.dev_id		= &sp804_clockevent,
 };
diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index c9f03ec..f488255 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -25,7 +25,7 @@
 
 #define fd_inb(port)		inb((port))
 #define fd_request_irq()	request_irq(IRQ_FLOPPYDISK,floppy_interrupt,\
-					    IRQF_DISABLED,"floppy",NULL)
+					    0,"floppy",NULL)
 #define fd_free_irq()		free_irq(IRQ_FLOPPYDISK,NULL)
 #define fd_disable_irq()	disable_irq(IRQ_FLOPPYDISK)
 #define fd_enable_irq()		enable_irq(IRQ_FLOPPYDISK)
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 24e2347..7476e47 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -432,7 +432,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 		}
 
 		err = request_irq(irq, handle_irq,
-				  IRQF_DISABLED | IRQF_NOBALANCING,
+				  IRQF_NOBALANCING,
 				  "arm-pmu", armpmu);
 		if (err) {
 			pr_err("unable to request IRQ%d for ARM PMU counters\n",
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 1dd69c8..3a80632 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -87,7 +87,7 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction at91rm9200_timer_irq = {
 	.name		= "at91_tick",
-	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= at91rm9200_timer_interrupt
 };
 
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 4ba8549..7136ac9 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -122,7 +122,7 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
 
 static struct irqaction at91sam926x_pit_irq = {
 	.name		= "at91_tick",
-	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= at91sam926x_pit_interrupt
 };
 
diff --git a/arch/arm/mach-at91/at91x40_time.c b/arch/arm/mach-at91/at91x40_time.c
index dfff289..19f7837 100644
--- a/arch/arm/mach-at91/at91x40_time.c
+++ b/arch/arm/mach-at91/at91x40_time.c
@@ -49,7 +49,7 @@ static irqreturn_t at91x40_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction at91x40_timer_irq = {
 	.name		= "at91_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= at91x40_timer_interrupt
 };
 
diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index b52b8de..73633e1 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -823,7 +823,7 @@ int dma_init(void)
 						  DMA_NUM_CHANNELS) +
 						 channelIdx,
 						 dma_interrupt_handler,
-						 IRQF_DISABLED, channel->name,
+						 0, channel->name,
 						 channel);
 				if (rc != 0) {
 					printk(KERN_ERR
diff --git a/arch/arm/mach-clps711x/time.c b/arch/arm/mach-clps711x/time.c
index d581ef0..7eca9ce 100644
--- a/arch/arm/mach-clps711x/time.c
+++ b/arch/arm/mach-clps711x/time.c
@@ -56,7 +56,7 @@ p720t_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction clps711x_timer_irq = {
 	.name		= "CLPS711x Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= p720t_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 941a308..a1fbab1 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -176,7 +176,7 @@ static irqreturn_t cns3xxx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction cns3xxx_timer_irq = {
 	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= cns3xxx_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 11c3db9..347fbe9 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -74,7 +74,7 @@ static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
 	if (handler != NULL) {
 		da830_evm_usb_ocic_handler = handler;
 
-		error = request_irq(irq, da830_evm_usb_ocic_irq, IRQF_DISABLED |
+		error = request_irq(irq, da830_evm_usb_ocic_irq,
 				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				    "OHCI over-current indicator", NULL);
 		if (error)
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index c6701e4..a0705ea 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -216,7 +216,7 @@ static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
 		hawk_usb_ocic_handler = handler;
 
 		error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
-					IRQF_DISABLED | IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_RISING |
 					IRQF_TRIGGER_FALLING,
 					"OHCI over-current indicator", NULL);
 		if (error)
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index e1969ce..9cdf755 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -178,7 +178,7 @@ static struct timer_s timers[] = {
 		.name      = "clockevent",
 		.opts      = TIMER_OPTS_DISABLED,
 		.irqaction = {
-			.flags   = IRQF_DISABLED | IRQF_TIMER,
+			.flags   = IRQF_TIMER,
 			.handler = timer_interrupt,
 		}
 	},
@@ -187,7 +187,7 @@ static struct timer_s timers[] = {
 		.period     = ~0,
 		.opts       = TIMER_OPTS_PERIODIC,
 		.irqaction = {
-			.flags   = IRQF_DISABLED | IRQF_TIMER,
+			.flags   = IRQF_TIMER,
 			.handler = freerun_interrupt,
 		}
 	},
diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index d0ce8ab..7113ac3 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -195,7 +195,7 @@ ebsa110_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction ebsa110_timer_irq = {
 	.name		= "EBSA110 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ebsa110_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 2432a6b..6741b86 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -135,7 +135,7 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction ep93xx_timer_irq = {
 	.name		= "ep93xx timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ep93xx_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index 121ad1d..e76386a 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -85,7 +85,7 @@ static irqreturn_t timer1_interrupt(int irq, void *dev_id)
 static struct irqaction footbridge_timer_irq = {
 	.name		= "dc21285_timer1",
 	.handler	= timer1_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.dev_id		= &ckevt_dc21285,
 };
 
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 18c32a5..0e30e3c 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -342,15 +342,15 @@ void __init dc21285_preinit(void)
 	/*
 	 * We don't care if these fail.
 	 */
-	dc21285_request_irq(IRQ_PCI_SERR, dc21285_serr_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_SERR, dc21285_serr_irq, 0,
 			    "PCI system error", &serr_timer);
-	dc21285_request_irq(IRQ_PCI_PERR, dc21285_parity_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_PERR, dc21285_parity_irq, 0,
 			    "PCI parity error", &perr_timer);
-	dc21285_request_irq(IRQ_PCI_ABORT, dc21285_abort_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_ABORT, dc21285_abort_irq, 0,
 			    "PCI abort", NULL);
-	dc21285_request_irq(IRQ_DISCARD_TIMER, dc21285_discard_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_DISCARD_TIMER, dc21285_discard_irq, 0,
 			    "Discard timer", NULL);
-	dc21285_request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, 0,
 			    "PCI data parity", NULL);
 
 	if (cfn_mode) {
diff --git a/arch/arm/mach-footbridge/isa-timer.c b/arch/arm/mach-footbridge/isa-timer.c
index c40bb41..9be453f 100644
--- a/arch/arm/mach-footbridge/isa-timer.c
+++ b/arch/arm/mach-footbridge/isa-timer.c
@@ -27,7 +27,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 static struct irqaction pit_timer_irq = {
 	.name		= "pit",
 	.handler	= pit_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.dev_id		= &i8253_clockevent,
 };
 
diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index 21dc5a8..cc996ec 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -45,7 +45,7 @@ static irqreturn_t gemini_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction gemini_timer_irq = {
 	.name		= "Gemini Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= gemini_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-h720x/cpu-h7201.c b/arch/arm/mach-h720x/cpu-h7201.c
index 24df2a3..75502f6 100644
--- a/arch/arm/mach-h720x/cpu-h7201.c
+++ b/arch/arm/mach-h720x/cpu-h7201.c
@@ -37,7 +37,7 @@ h7201_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction h7201_timer_irq = {
 	.name		= "h7201 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= h7201_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-h720x/cpu-h7202.c b/arch/arm/mach-h720x/cpu-h7202.c
index c37d570..380f3d7 100644
--- a/arch/arm/mach-h720x/cpu-h7202.c
+++ b/arch/arm/mach-h720x/cpu-h7202.c
@@ -171,7 +171,7 @@ static struct irq_chip h7202_timerx_chip = {
 
 static struct irqaction h7202_timer_irq = {
 	.name		= "h7202 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= h7202_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index c9a9cf6..adb2210 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -407,7 +407,7 @@ static int armadillo5x0_sdhc1_init(struct device *dev,
 
 	/* When supported the trigger type have to be BOTH */
 	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_ATA_DMACK), detect_irq,
-			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			  IRQF_TRIGGER_FALLING,
 			  "sdhc-detect", data);
 
 	if (ret)
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 59e75f6..d98f96b 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -312,7 +312,7 @@ static int mx31_3ds_sdhc1_init(struct device *dev,
 	}
 
 	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
-			  detect_irq, IRQF_DISABLED |
+			  detect_irq,
 			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			  "sdhc1-detect", data);
 	if (ret) {
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 26072f4..a4a329a 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -247,7 +247,7 @@ static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 	int ret;
 
 	ret = request_irq(IRQ_GPIOC(29), detect_irq,
-			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			  IRQF_TRIGGER_FALLING,
 			  "imx-mmc-detect", data);
 	if (ret)
 		printk(KERN_ERR
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index efd6b53..eb68614 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -369,7 +369,7 @@ static int pcm970_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 #endif
 
 	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_SCK6), detect_irq,
-			IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			IRQF_TRIGGER_FALLING,
 				"sdhc-detect", data);
 	if (ret)
 		goto err_gpio_free_2;
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index 7d26f76..f0c1ea4 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -131,7 +131,7 @@ static int mxc_mmc1_init(struct device *dev,
 	gpio_direction_input(gpio_wp);
 
 	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO1_1), detect_irq,
-			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			  IRQF_TRIGGER_FALLING,
 			  "MMC detect", data);
 	if (ret)
 		goto exit_free_wp;
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index a1769f3..3dbe8a6 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -410,7 +410,7 @@ static struct clock_event_device integrator_clockevent = {
 
 static struct irqaction integrator_timer_irq = {
 	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= integrator_timer_interrupt,
 	.dev_id		= &integrator_clockevent,
 };
diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
index 24f0fe3..84d9c1c 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -214,7 +214,7 @@ static irqreturn_t ixp2000_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction ixp2000_timer_irq = {
 	.name		= "IXP2000 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ixp2000_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index a1bee33..e556bb3 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -366,7 +366,7 @@ ixp23xx_timer_interrupt(int irq, void *dev_id)
 static struct irqaction ixp23xx_timer_irq = {
 	.name		= "IXP23xx Timer Tick",
 	.handler	= ixp23xx_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 };
 
 void __init ixp23xx_init_timer(void)
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index b86a005..a04ed78 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -280,7 +280,7 @@ static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction ixp4xx_timer_irq = {
 	.name		= "timer1",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ixp4xx_timer_interrupt,
 	.dev_id		= &clockevent_ixp4xx,
 };
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 8837fbc..37c8c15 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -255,7 +255,7 @@ static void __init dsmg600_init(void)
 	pm_power_off = dsmg600_power_off;
 
 	if (request_irq(gpio_to_irq(DSMG600_RB_GPIO), &dsmg600_reset_handler,
-		IRQF_DISABLED | IRQF_TRIGGER_LOW,
+		IRQF_TRIGGER_LOW,
 		"DSM-G600 reset button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Reset Button IRQ %d not available\n",
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 2887c35..ec2a6b6 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -208,7 +208,7 @@ static void __init fsg_init(void)
 	platform_add_devices(fsg_devices, ARRAY_SIZE(fsg_devices));
 
 	if (request_irq(gpio_to_irq(FSG_RB_GPIO), &fsg_reset_handler,
-			IRQF_DISABLED | IRQF_TRIGGER_LOW,
+			IRQF_TRIGGER_LOW,
 			"FSG reset button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Reset Button IRQ %d not available\n",
@@ -216,7 +216,7 @@ static void __init fsg_init(void)
 	}
 
 	if (request_irq(gpio_to_irq(FSG_SB_GPIO), &fsg_power_handler,
-			IRQF_DISABLED | IRQF_TRIGGER_LOW,
+			IRQF_TRIGGER_LOW,
 			"FSG power button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Power Button IRQ %d not available\n",
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index de716fa..c45dcf5 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -271,7 +271,7 @@ static void __init nas100d_init(void)
 	pm_power_off = nas100d_power_off;
 
 	if (request_irq(gpio_to_irq(NAS100D_RB_GPIO), &nas100d_reset_handler,
-		IRQF_DISABLED | IRQF_TRIGGER_LOW,
+		IRQF_TRIGGER_LOW,
 		"NAS100D reset button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Reset Button IRQ %d not available\n",
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index ac81ccb..2a1db88 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -262,7 +262,7 @@ static void __init nslu2_init(void)
 	pm_power_off = nslu2_power_off;
 
 	if (request_irq(gpio_to_irq(NSLU2_RB_GPIO), &nslu2_reset_handler,
-		IRQF_DISABLED | IRQF_TRIGGER_LOW,
+		IRQF_TRIGGER_LOW,
 		"NSLU2 reset button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Reset Button IRQ %d not available\n",
@@ -270,7 +270,7 @@ static void __init nslu2_init(void)
 	}
 
 	if (request_irq(gpio_to_irq(NSLU2_PB_GPIO), &nslu2_power_handler,
-		IRQF_DISABLED | IRQF_TRIGGER_HIGH,
+		IRQF_TRIGGER_HIGH,
 		"NSLU2 power button", NULL) < 0) {
 
 		printk(KERN_DEBUG "Power Button IRQ %d not available\n",
diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
index 69c072c..16e42e4 100644
--- a/arch/arm/mach-ks8695/time.c
+++ b/arch/arm/mach-ks8695/time.c
@@ -76,7 +76,7 @@ static irqreturn_t ks8695_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction ks8695_timer_irq = {
 	.name		= "ks8695_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= ks8695_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index b42c909..279f826 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -91,7 +91,7 @@ static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction lpc32xx_timer_irq = {
 	.name		= "LPC32XX Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= lpc32xx_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 4e91ee6..bc47afd 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -192,7 +192,7 @@ static void __init timer_config(void)
 
 static struct irqaction timer_irq = {
 	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= timer_interrupt,
 	.dev_id		= &ckevt,
 };
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 63621f1..a5d4ac9 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -173,7 +173,7 @@ static struct msm_clock msm_clocks[] = {
 		},
 		.irq = {
 			.name    = "gp_timer",
-			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
+			.flags   = IRQF_TIMER | IRQF_TRIGGER_RISING,
 			.handler = msm_timer_interrupt,
 			.dev_id  = &msm_clocks[0].clockevent,
 			.irq     = INT_GP_TIMER_EXP
@@ -198,7 +198,7 @@ static struct msm_clock msm_clocks[] = {
 		},
 		.irq = {
 			.name    = "dg_timer",
-			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
+			.flags   = IRQF_TIMER | IRQF_TRIGGER_RISING,
 			.handler = msm_timer_interrupt,
 			.dev_id  = &msm_clocks[1].clockevent,
 			.irq     = INT_DEBUG_TIMER_EXP
diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index e24c141..125a51d 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -100,7 +100,7 @@ netx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction netx_timer_irq = {
 	.name		= "NetX Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= netx_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 0a17a1a..474ae1c 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -132,8 +132,8 @@ static struct irq_chip omap_fpga_irq = {
  * mask_ack routine for all of the FPGA interrupts has been changed from
  * fpga_mask_ack_irq() to fpga_ack_irq() so that the specific FPGA interrupt
  * being serviced is left unmasked.  We can do this because the FPGA cascade
- * interrupt is installed with the IRQF_DISABLED flag, which leaves all
- * interrupts masked at the CPU while an FPGA interrupt handler executes.
+ * interrupt leaves all interrupts masked@the CPU while an FPGA interrupt
+ * handler executes.
  *
  * Limited testing indicates that this workaround appears to be effective
  * for the smc9194 Ethernet driver used on the Innovator.  It should work
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 495b398..4f13b18 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -641,7 +641,6 @@ static irqreturn_t omap_wakeup_interrupt(int irq, void *dev)
 
 static struct irqaction omap_wakeup_irq = {
 	.name		= "peripheral wakeup",
-	.flags		= IRQF_DISABLED,
 	.handler	= omap_wakeup_interrupt
 };
 
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a183777..a35b4d2 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -163,7 +163,7 @@ static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
 
 static struct irqaction omap_mpu_timer1_irq = {
 	.name		= "mpu_timer1",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= omap_mpu_timer1_interrupt,
 };
 
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 96604a5..db08fd4 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -155,7 +155,7 @@ static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction omap_32k_timer_irq = {
 	.name		= "32KHz timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= omap_32k_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index 7b9f190..d4454d2 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -180,7 +180,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq,
 			l3_interrupt_handler,
-			IRQF_DISABLED, "l3-dbg-irq", l3);
+			0, "l3-dbg-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
 					 OMAP44XX_IRQ_L3_DBG);
@@ -191,7 +191,7 @@ static int __init omap4_l3_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 1);
 	ret = request_irq(irq,
 			l3_interrupt_handler,
-			IRQF_DISABLED, "l3-app-irq", l3);
+			0, "l3-app-irq", l3);
 	if (ret) {
 		pr_crit("L3: request_irq failed to register for 0x%x\n",
 					 OMAP44XX_IRQ_L3_APP);
diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 873c0e3..a4ac780 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -240,7 +240,7 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 
 	l3->debug_irq = platform_get_irq(pdev, 0);
 	ret = request_irq(l3->debug_irq, omap3_l3_app_irq,
-		IRQF_DISABLED | IRQF_TRIGGER_RISING,
+		IRQF_TRIGGER_RISING,
 		"l3-debug-irq", l3);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't request debug irq\n");
@@ -249,7 +249,7 @@ static int __init omap3_l3_probe(struct platform_device *pdev)
 
 	l3->app_irq = platform_get_irq(pdev, 1);
 	ret = request_irq(l3->app_irq, omap3_l3_app_irq,
-		IRQF_DISABLED | IRQF_TRIGGER_RISING,
+		IRQF_TRIGGER_RISING,
 		"l3-app-irq", l3);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't request app irq\n");
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c8cbd00..ea5b37a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -878,7 +878,7 @@ static int __init omap3_pm_init(void)
 
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
-			  IRQF_DISABLED, "prcm", NULL);
+			  0, "prcm", NULL);
 	if (ret) {
 		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
 		       INT_34XX_PRCM_MPU_IRQ);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1140e98..db3ce69 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -91,7 +91,7 @@ static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction omap2_gp_timer_irq = {
 	.name		= "gp timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= omap2_gp_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index 0c8aad4..cd4ea0c 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -80,7 +80,7 @@ static irqreturn_t pnx4008_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction pnx4008_timer_irq = {
 	.name = "PNX4008 Tick Timer",
-	.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags = IRQF_TIMER | IRQF_IRQPOLL,
 	.handler = pnx4008_timer_interrupt
 };
 
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 4cb069f..d60a218 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -293,7 +293,7 @@ static int am200_setup_irq(struct fb_info *info)
 	int ret;
 
 	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
-				IRQF_DISABLED|IRQF_TRIGGER_FALLING,
+				IRQF_TRIGGER_FALLING,
 				"AM200", info->par);
 	if (ret)
 		dev_err(&am200_device->dev, "request_irq failed: %d\n", ret);
diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index fa8bad2..373b420 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -241,7 +241,7 @@ static int am300_setup_irq(struct fb_info *info)
 	struct broadsheetfb_par *par = info->par;
 
 	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am300_handle_irq,
-				IRQF_DISABLED|IRQF_TRIGGER_RISING,
+				IRQF_TRIGGER_RISING,
 				"AM300", par);
 	if (ret)
 		dev_err(&am300_device->dev, "request_irq failed: %d\n", ret);
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 94acc0b..2bd6480 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -559,7 +559,7 @@ static int em_x270_mci_init(struct device *dev,
 	}
 
 	err = request_irq(gpio_to_irq(mmc_cd), em_x270_detect_int,
-			      IRQF_DISABLED | IRQF_TRIGGER_RISING |
+			      IRQF_TRIGGER_RISING |
 			      IRQF_TRIGGER_FALLING,
 			      "MMC card detect", data);
 	if (err) {
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 4b796c3..47e4ce1 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -618,7 +618,7 @@ static int magician_mci_init(struct device *dev,
 				irq_handler_t detect_irq, void *data)
 {
 	return request_irq(IRQ_MAGICIAN_SD, detect_irq,
-				IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
+				IRQF_SAMPLE_RANDOM,
 				"mmc card detect", data);
 }
 
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 0567d39..4772294 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -398,7 +398,7 @@ static int mainstone_mci_init(struct device *dev, irq_handler_t mstone_detect_in
 	 */
 	MST_MSCWR1 &= ~MST_MSCWR1_MS_SEL;
 
-	err = request_irq(MAINSTONE_MMC_IRQ, mstone_detect_int, IRQF_DISABLED,
+	err = request_irq(MAINSTONE_MMC_IRQ, mstone_detect_int, 0,
 			     "MMC card detect", data);
 	if (err)
 		printk(KERN_ERR "mainstone_mci_init: MMC/SD: can't request MMC card detect IRQ\n");
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 9a9c539..8617f6b 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -297,7 +297,7 @@ static int pcm990_mci_init(struct device *dev, irq_handler_t mci_detect_int,
 {
 	int err;
 
-	err = request_irq(PCM027_MMCDET_IRQ, mci_detect_int, IRQF_DISABLED,
+	err = request_irq(PCM027_MMCDET_IRQ, mci_detect_int, 0,
 			     "MMC card detect", data);
 	if (err)
 		printk(KERN_ERR "pcm990_mci_init: MMC/SD: can't request MMC "
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 785880f..6da91c2 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -907,23 +907,23 @@ static int __devinit sharpsl_pm_probe(struct platform_device *pdev)
 	gpio_direction_input(sharpsl_pm.machinfo->gpio_batlock);
 
 	/* Register interrupt handlers */
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
+	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
 		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin));
 	}
 
-	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
+	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
 		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock));
 	}
 
 	if (sharpsl_pm.machinfo->gpio_fatal) {
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
+		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
 			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal));
 		}
 	}
 
 	if (sharpsl_pm.machinfo->batfull_irq) {
 		/* Register interrupt handler. */
-		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
+		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
 			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull));
 		}
 	}
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index de68470..b267783 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -107,7 +107,7 @@ static struct clock_event_device ckevt_pxa_osmr0 = {
 
 static struct irqaction pxa_ost0_irq = {
 	.name		= "ost0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= pxa_ost0_interrupt,
 	.dev_id		= &ckevt_pxa_osmr0,
 };
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 1aaed2b..840e780 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -332,7 +332,7 @@ static int trizeps4_mci_init(struct device *dev, irq_handler_t mci_detect_int,
 	int err;
 
 	err = request_irq(TRIZEPS4_MMC_IRQ, mci_detect_int,
-		IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_SAMPLE_RANDOM,
+		IRQF_TRIGGER_RISING | IRQF_SAMPLE_RANDOM,
 		"MMC card detect", data);
 	if (err) {
 		printk(KERN_ERR "trizeps4_mci_init: MMC/SD: can't request"
diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 85883b2..6d3517d 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -141,7 +141,7 @@ static int iomd_request_dma(unsigned int chan, dma_t *dma)
 	struct iomd_dma *idma = container_of(dma, struct iomd_dma, dma);
 
 	return request_irq(idma->irq, iomd_dma_handle,
-			   IRQF_DISABLED, idma->dma.device_id, idma);
+			   0, idma->dma.device_id, idma);
 }
 
 static void iomd_free_dma(unsigned int chan, dma_t *dma)
diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c2410/usb-simtec.c
index 29bd3d9..17e10f9 100644
--- a/arch/arm/mach-s3c2410/usb-simtec.c
+++ b/arch/arm/mach-s3c2410/usb-simtec.c
@@ -80,7 +80,7 @@ static void usb_simtec_enableoc(struct s3c2410_hcd_info *info, int on)
 
 	if (on) {
 		ret = request_irq(IRQ_USBOC, usb_simtec_ocirq,
-				  IRQF_DISABLED | IRQF_TRIGGER_RISING |
+				  IRQF_TRIGGER_RISING |
 				   IRQF_TRIGGER_FALLING,
 				  "USB Over-current", info);
 		if (ret != 0) {
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index cb1ebeb..f3525fc 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -103,7 +103,7 @@ static void smartq_usb_host_enableoc(struct s3c2410_hcd_info *info, int on)
 
 	if (on) {
 		ret = request_irq(gpio_to_irq(S3C64XX_GPL(10)),
-				  smartq_usb_host_ocirq, IRQF_DISABLED |
+				  smartq_usb_host_ocirq,
 				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				  "USB host overcurrent", info);
 		if (ret != 0)
diff --git a/arch/arm/mach-sa1100/dma.c b/arch/arm/mach-sa1100/dma.c
index ad66035..5b3fe04 100644
--- a/arch/arm/mach-sa1100/dma.c
+++ b/arch/arm/mach-sa1100/dma.c
@@ -124,7 +124,7 @@ int sa1100_request_dma (dma_device_t device, const char *device_id,
 
 	i = dma - dma_chan;
 	regs = (dma_regs_t *)&DDAR(i);
-	err = request_irq(IRQ_DMA0 + i, dma_irq_handler, IRQF_DISABLED,
+	err = request_irq(IRQ_DMA0 + i, dma_irq_handler, 0,
 			  device_id, regs);
 	if (err) {
 		printk(KERN_ERR
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index fa66024..c551717 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -99,7 +99,7 @@ static struct clock_event_device ckevt_sa1100_osmr0 = {
 
 static struct irqaction sa1100_timer_irq = {
 	.name		= "ost0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= sa1100_ost0_interrupt,
 	.dev_id		= &ckevt_sa1100_osmr0,
 };
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index feda3ca..65e8857 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -130,7 +130,7 @@ shark_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction shark_timer_irq = {
 	.name		= "Shark Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= shark_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-tcc8k/time.c b/arch/arm/mach-tcc8k/time.c
index a96babe..5a47cfa 100644
--- a/arch/arm/mach-tcc8k/time.c
+++ b/arch/arm/mach-tcc8k/time.c
@@ -80,7 +80,7 @@ static struct clock_event_device clockevent_tcc = {
 
 static struct irqaction tcc8k_timer_irq = {
 	.name		= "TC32_timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= tcc8k_timer_interrupt,
 	.dev_id		= &clockevent_tcc,
 };
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index e2272d2..e283e42 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -173,7 +173,7 @@ static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction tegra_timer_irq = {
 	.name		= "timer0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_HIGH,
+	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
 	.handler	= tegra_timer_interrupt,
 	.dev_id		= &tegra_clockevent,
 	.irq		= INT_TMR3,
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 5f51bde..2f672f3 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -326,7 +326,7 @@ static irqreturn_t u300_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction u300_timer_irq = {
 	.name		= "U300 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= u300_timer_interrupt,
 };
 
diff --git a/arch/arm/mach-vt8500/timer.c b/arch/arm/mach-vt8500/timer.c
index d5376c5..9385ce4 100644
--- a/arch/arm/mach-vt8500/timer.c
+++ b/arch/arm/mach-vt8500/timer.c
@@ -117,7 +117,7 @@ static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
 
 struct irqaction irq = {
 	.name    = "vt8500_timer",
-	.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags   = IRQF_TIMER | IRQF_IRQPOLL,
 	.handler = vt8500_timer_interrupt,
 	.dev_id  = &clockevent,
 };
diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index a2c4e2d..980e2d4 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -110,7 +110,7 @@ static irqreturn_t nuc900_timer0_interrupt(int irq, void *dev_id)
 
 static struct irqaction nuc900_timer0_irq = {
 	.name		= "nuc900-timer0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= nuc900_timer0_interrupt,
 };
 
diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index c2c96cc..bdbd7bc 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -130,7 +130,7 @@ static irqreturn_t xttcpss_clock_event_interrupt(int irq, void *dev_id)
 
 static struct irqaction event_timer_irq = {
 	.name	= "xttcpss clockevent",
-	.flags	= IRQF_DISABLED | IRQF_TIMER,
+	.flags	= IRQF_TIMER,
 	.handler = xttcpss_clock_event_interrupt,
 };
 
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 568dd02..5b0df54 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -137,7 +137,7 @@ iop_timer_interrupt(int irq, void *dev_id)
 static struct irqaction iop_timer_irq = {
 	.name		= "IOP Timer Tick",
 	.handler	= iop_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.dev_id		= &iop_clockevent,
 };
 
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 4bdc975..e052d35 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -41,7 +41,7 @@ config MXC_IRQ_PRIOR
 	help
 	  Select this if you want to use prioritized IRQ handling.
 	  This feature prevents higher priority ISR to be interrupted
-	  by lower priority IRQ even IRQF_DISABLED flag is not set.
+	  by lower priority IRQ.
 	  This may be useful in embedded applications, where are strong
 	  requirements for timing.
 	  Say N here, unless you have a specialized requirement.
diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/plat-mxc/epit.c
index d3467f8..340f188 100644
--- a/arch/arm/plat-mxc/epit.c
+++ b/arch/arm/plat-mxc/epit.c
@@ -170,7 +170,7 @@ static irqreturn_t epit_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction epit_timer_irq = {
 	.name		= "i.MX EPIT Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= epit_timer_interrupt,
 };
 
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..464ac64 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -254,7 +254,7 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction mxc_timer_irq = {
 	.name		= "i.MX Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= mxc_timer_interrupt,
 };
 
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 30b6433..a8bfad3 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -177,7 +177,7 @@ static irqreturn_t nmdk_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction nmdk_timer_irq = {
 	.name		= "Nomadik Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= nmdk_timer_interrupt,
 	.dev_id		= &nmdk_clkevt,
 };
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..f51e18e 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1928,7 +1928,6 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 static struct irqaction omap24xx_dma_irq = {
 	.name = "DMA",
 	.handler = omap2_dma_irq_handler,
-	.flags = IRQF_DISABLED
 };
 
 #else
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 69a6136..c70cdb2 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -190,7 +190,7 @@ static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction orion_timer_irq = {
 	.name		= "orion_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= orion_timer_interrupt
 };
 
diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index 2d3c19d..7d0fdbd 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -378,7 +378,7 @@ int __init pxa_init_dma(int irq, int num_ch)
 		spin_lock_init(&dma_channels[i].lock);
 	}
 
-	ret = request_irq(irq, dma_irq_handler, IRQF_DISABLED, "DMA", NULL);
+	ret = request_irq(irq, dma_irq_handler, 0, "DMA", NULL);
 	if (ret) {
 		printk (KERN_CRIT "Wow!  Can't register IRQ for DMA\n");
 		kfree(dma_channels);
diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 53754bc..2db21b2 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -743,7 +743,7 @@ int s3c2410_dma_request(enum dma_ch channel,
 		chan->irq_claimed = 1;
 		local_irq_restore(flags);
 
-		err = request_irq(chan->irq, s3c2410_dma_irq, IRQF_DISABLED,
+		err = request_irq(chan->irq, s3c2410_dma_irq, 0,
 				  client->name, (void *)chan);
 
 		local_irq_save(flags);
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index c833e7b..2ee6af1 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -253,7 +253,7 @@ static irqreturn_t s5p_clock_event_isr(int irq, void *dev_id)
 
 static struct irqaction s5p_clock_event_irq = {
 	.name		= "s5p_time_irq",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= s5p_clock_event_isr,
 	.dev_id		= &time_event_device,
 };
diff --git a/arch/arm/plat-s5p/sysmmu.c b/arch/arm/plat-s5p/sysmmu.c
index e1cbc72..282eeb4 100644
--- a/arch/arm/plat-s5p/sysmmu.c
+++ b/arch/arm/plat-s5p/sysmmu.c
@@ -257,7 +257,7 @@ static int s5p_sysmmu_probe(struct platform_device *pdev)
 			goto err_map;
 		}
 
-		if (request_irq(irq, s5p_sysmmu_irq, IRQF_DISABLED,
+		if (request_irq(irq, s5p_sysmmu_irq, 0,
 						pdev->name, (void *)i)) {
 			dev_err(dev, "Failed to request IRQ for %s.\n",
 							sysmmu_ips_name[i]);
diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index e3bb806..43bd19d 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -138,7 +138,7 @@ s3c2410_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction s3c2410_timer_irq = {
 	.name		= "S3C2410 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= s3c2410_timer_interrupt,
 };
 
diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index 0c77e42..5496f4b 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -169,7 +169,7 @@ static irqreturn_t spear_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction spear_timer_irq = {
 	.name = "timer",
-	.flags = IRQF_DISABLED | IRQF_TIMER,
+	.flags = IRQF_TIMER,
 	.handler = spear_timer_interrupt
 };
 
-- 
1.7.1
