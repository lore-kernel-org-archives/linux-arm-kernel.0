From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:27 -0800
Subject: [PATCH 15/16] ARM: LPC32XX: Updated device IRQ names with LPC32XX
	identifier
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-16-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Added _LCP32XX identifier to IRQ names used in the arch area to
identify device specific IRQs.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/common.c            |    6 +-
 arch/arm/mach-lpc32xx/include/mach/irqs.h |  158 ++++++++++++++--------------
 arch/arm/mach-lpc32xx/irq.c               |    4 +-
 arch/arm/mach-lpc32xx/phy3250.c           |    4 +-
 arch/arm/mach-lpc32xx/serial.c            |    8 +-
 arch/arm/mach-lpc32xx/timer.c             |    2 +-
 6 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 1efa3d1..b925c09 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -63,19 +63,19 @@ struct platform_device watchdog_device = {
 static struct i2c_pnx_data i2c0_data = {
 	.name = I2C_CHIP_NAME "0",
 	.base = LPC32XX_I2C1_BASE,
-	.irq = IRQ_I2C_1,
+	.irq = IRQ_LPC32XX_I2C_1,
 };
 
 static struct i2c_pnx_data i2c1_data = {
 	.name = I2C_CHIP_NAME "1",
 	.base = LPC32XX_I2C2_BASE,
-	.irq = IRQ_I2C_2,
+	.irq = IRQ_LPC32XX_I2C_2,
 };
 
 static struct i2c_pnx_data i2c2_data = {
 	.name = "USB-I2C",
 	.base = LPC32XX_OTG_I2C_BASE,
-	.irq = IRQ_USB_I2C,
+	.irq = IRQ_LPC32XX_USB_I2C,
 };
 
 struct platform_device i2c0_device = {
diff --git a/arch/arm/mach-lpc32xx/include/mach/irqs.h b/arch/arm/mach-lpc32xx/include/mach/irqs.h
index 157a26c..9ef2720 100644
--- a/arch/arm/mach-lpc32xx/include/mach/irqs.h
+++ b/arch/arm/mach-lpc32xx/include/mach/irqs.h
@@ -26,93 +26,93 @@
 /*
  * MIC interrupts
  */
-#define IRQ_SUB1IRQ		0
-#define IRQ_SUB2IRQ		1
-#define IRQ_PWM3		3
-#define IRQ_PWM4		4
-#define IRQ_HSTIMER		5
-#define IRQ_WATCH		6
-#define IRQ_UART_IIR3		7
-#define IRQ_UART_IIR4		8
-#define IRQ_UART_IIR5		9
-#define IRQ_UART_IIR6		10
-#define IRQ_FLASH		11
-#define IRQ_SD1			13
-#define IRQ_LCD			14
-#define IRQ_SD0			15
-#define IRQ_TIMER0		16
-#define IRQ_TIMER1		17
-#define IRQ_TIMER2		18
-#define IRQ_TIMER3		19
-#define IRQ_SSP0		20
-#define IRQ_SSP1		21
-#define IRQ_I2S0		22
-#define IRQ_I2S1		23
-#define IRQ_UART_IIR7		24
-#define IRQ_UART_IIR2		25
-#define IRQ_UART_IIR1		26
-#define IRQ_MSTIMER		27
-#define IRQ_DMA			28
-#define IRQ_ETHERNET		29
-#define IRQ_SUB1FIQ		30
-#define IRQ_SUB2FIQ		31
+#define IRQ_LPC32XX_SUB1IRQ		0
+#define IRQ_LPC32XX_SUB2IRQ		1
+#define IRQ_LPC32XX_PWM3		3
+#define IRQ_LPC32XX_PWM4		4
+#define IRQ_LPC32XX_HSTIMER		5
+#define IRQ_LPC32XX_WATCH		6
+#define IRQ_LPC32XX_UART_IIR3		7
+#define IRQ_LPC32XX_UART_IIR4		8
+#define IRQ_LPC32XX_UART_IIR5		9
+#define IRQ_LPC32XX_UART_IIR6		10
+#define IRQ_LPC32XX_FLASH		11
+#define IRQ_LPC32XX_SD1			13
+#define IRQ_LPC32XX_LCD			14
+#define IRQ_LPC32XX_SD0			15
+#define IRQ_LPC32XX_TIMER0		16
+#define IRQ_LPC32XX_TIMER1		17
+#define IRQ_LPC32XX_TIMER2		18
+#define IRQ_LPC32XX_TIMER3		19
+#define IRQ_LPC32XX_SSP0		20
+#define IRQ_LPC32XX_SSP1		21
+#define IRQ_LPC32XX_I2S0		22
+#define IRQ_LPC32XX_I2S1		23
+#define IRQ_LPC32XX_UART_IIR7		24
+#define IRQ_LPC32XX_UART_IIR2		25
+#define IRQ_LPC32XX_UART_IIR1		26
+#define IRQ_LPC32XX_MSTIMER		27
+#define IRQ_LPC32XX_DMA			28
+#define IRQ_LPC32XX_ETHERNET		29
+#define IRQ_LPC32XX_SUB1FIQ		30
+#define IRQ_LPC32XX_SUB2FIQ		31
 
 /*
  * SIC1 interrupts start at offset 32
  */
-#define IRQ_JTAG_COMM_TX	(32 + 1)
-#define IRQ_JTAG_COMM_RX	(32 + 2)
-#define IRQ_GPI_11		(32 + 4)
-#define IRQ_TS_P		(32 + 6)
-#define IRQ_TS_IRQ		(32 + 7)
-#define IRQ_TS_AUX		(32 + 8)
-#define IRQ_SPI2		(32 + 12)
-#define IRQ_PLLUSB		(32 + 13)
-#define IRQ_PLLHCLK		(32 + 14)
-#define IRQ_PLL397		(32 + 17)
-#define IRQ_I2C_2		(32 + 18)
-#define IRQ_I2C_1		(32 + 19)
-#define IRQ_RTC			(32 + 20)
-#define IRQ_KEY			(32 + 22)
-#define IRQ_SPI1		(32 + 23)
-#define IRQ_SW			(32 + 24)
-#define IRQ_USB_OTG_TIMER	(32 + 25)
-#define IRQ_USB_OTG_ATX		(32 + 26)
-#define IRQ_USB_HOST		(32 + 27)
-#define IRQ_USB_DEV_DMA		(32 + 28)
-#define IRQ_USB_DEV_LP		(32 + 29)
-#define IRQ_USB_DEV_HP		(32 + 30)
-#define IRQ_USB_I2C		(32 + 31)
+#define IRQ_LPC32XX_JTAG_COMM_TX	(32 + 1)
+#define IRQ_LPC32XX_JTAG_COMM_RX	(32 + 2)
+#define IRQ_LPC32XX_GPI_11		(32 + 4)
+#define IRQ_LPC32XX_TS_P		(32 + 6)
+#define IRQ_LPC32XX_TS_IRQ		(32 + 7)
+#define IRQ_LPC32XX_TS_AUX		(32 + 8)
+#define IRQ_LPC32XX_SPI2		(32 + 12)
+#define IRQ_LPC32XX_PLLUSB		(32 + 13)
+#define IRQ_LPC32XX_PLLHCLK		(32 + 14)
+#define IRQ_LPC32XX_PLL397		(32 + 17)
+#define IRQ_LPC32XX_I2C_2		(32 + 18)
+#define IRQ_LPC32XX_I2C_1		(32 + 19)
+#define IRQ_LPC32XX_RTC			(32 + 20)
+#define IRQ_LPC32XX_KEY			(32 + 22)
+#define IRQ_LPC32XX_SPI1		(32 + 23)
+#define IRQ_LPC32XX_SW			(32 + 24)
+#define IRQ_LPC32XX_USB_OTG_TIMER	(32 + 25)
+#define IRQ_LPC32XX_USB_OTG_ATX		(32 + 26)
+#define IRQ_LPC32XX_USB_HOST		(32 + 27)
+#define IRQ_LPC32XX_USB_DEV_DMA		(32 + 28)
+#define IRQ_LPC32XX_USB_DEV_LP		(32 + 29)
+#define IRQ_LPC32XX_USB_DEV_HP		(32 + 30)
+#define IRQ_LPC32XX_USB_I2C		(32 + 31)
 
 /*
  * SIC2 interrupts start at offset 64
  */
-#define IRQ_GPIO_00		(64 + 0)
-#define IRQ_GPIO_01		(64 + 1)
-#define IRQ_GPIO_02		(64 + 2)
-#define IRQ_GPIO_03		(64 + 3)
-#define IRQ_GPIO_04		(64 + 4)
-#define IRQ_GPIO_05		(64 + 5)
-#define IRQ_SPI2_DATAIN		(64 + 6)
-#define IRQ_U2_HCTS		(64 + 7)
-#define IRQ_P0_P1_IRQ		(64 + 8)
-#define IRQ_GPI_08		(64 + 9)
-#define IRQ_GPI_09		(64 + 10)
-#define IRQ_GPI_10		(64 + 11)
-#define IRQ_U7_HCTS		(64 + 12)
-#define IRQ_GPI_07		(64 + 15)
-#define IRQ_SDIO		(64 + 18)
-#define IRQ_U5_RX		(64 + 19)
-#define IRQ_SPI1_DATAIN		(64 + 20)
-#define IRQ_GPI_00		(64 + 22)
-#define IRQ_GPI_01		(64 + 23)
-#define IRQ_GPI_02		(64 + 24)
-#define IRQ_GPI_03		(64 + 25)
-#define IRQ_GPI_04		(64 + 26)
-#define IRQ_GPI_05		(64 + 27)
-#define IRQ_GPI_06		(64 + 28)
-#define IRQ_SYSCLK		(64 + 31)
+#define IRQ_LPC32XX_GPIO_00		(64 + 0)
+#define IRQ_LPC32XX_GPIO_01		(64 + 1)
+#define IRQ_LPC32XX_GPIO_02		(64 + 2)
+#define IRQ_LPC32XX_GPIO_03		(64 + 3)
+#define IRQ_LPC32XX_GPIO_04		(64 + 4)
+#define IRQ_LPC32XX_GPIO_05		(64 + 5)
+#define IRQ_LPC32XX_SPI2_DATAIN		(64 + 6)
+#define IRQ_LPC32XX_U2_HCTS		(64 + 7)
+#define IRQ_LPC32XX_P0_P1_IRQ		(64 + 8)
+#define IRQ_LPC32XX_GPI_08		(64 + 9)
+#define IRQ_LPC32XX_GPI_09		(64 + 10)
+#define IRQ_LPC32XX_GPI_10		(64 + 11)
+#define IRQ_LPC32XX_U7_HCTS		(64 + 12)
+#define IRQ_LPC32XX_GPI_07		(64 + 15)
+#define IRQ_LPC32XX_SDIO		(64 + 18)
+#define IRQ_LPC32XX_U5_RX		(64 + 19)
+#define IRQ_LPC32XX_SPI1_DATAIN		(64 + 20)
+#define IRQ_LPC32XX_GPI_00		(64 + 22)
+#define IRQ_LPC32XX_GPI_01		(64 + 23)
+#define IRQ_LPC32XX_GPI_02		(64 + 24)
+#define IRQ_LPC32XX_GPI_03		(64 + 25)
+#define IRQ_LPC32XX_GPI_04		(64 + 26)
+#define IRQ_LPC32XX_GPI_05		(64 + 27)
+#define IRQ_LPC32XX_GPI_06		(64 + 28)
+#define IRQ_LPC32XX_SYSCLK		(64 + 31)
 
-#define NR_IRQS			96
+#define NR_IRQS				96
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index a3ea5cc..d583754 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -230,8 +230,8 @@ void __init lpc32xx_init_irq(void)
 		SIC2_APR_DEFAULT, SIC2_ATR_DEFAULT, 64);
 
 	/* mask all interrupts except SUBIRQA and SUBFIQ */
-	writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) |
-		(1 << IRQ_SUB1FIQ) | (1 << IRQ_SUB2FIQ),
+	writel((1 << IRQ_LPC32XX_SUB1IRQ) | (1 << IRQ_LPC32XX_SUB2IRQ) |
+		(1 << IRQ_LPC32XX_SUB1FIQ) | (1 << IRQ_LPC32XX_SUB2FIQ),
 		LPC32XX_INTC_MASK(io_p2v(LPC32XX_MIC_BASE)));
 	writel(0, LPC32XX_INTC_MASK(io_p2v(LPC32XX_SIC1_BASE)));
 	writel(0, LPC32XX_INTC_MASK(io_p2v(LPC32XX_SIC2_BASE)));
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bd59aa9..846bc33 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -193,7 +193,7 @@ static struct amba_device clcd_device = {
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
-	.irq				= {IRQ_LCD, NO_IRQ},
+	.irq				= {IRQ_LPC32XX_LCD, NO_IRQ},
 };
 
 /*
@@ -241,7 +241,7 @@ static struct amba_device ssp0_device = {
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
-	.irq				= {IRQ_SSP0, NO_IRQ},
+	.irq				= {IRQ_LPC32XX_SSP0, NO_IRQ},
 };
 
 /* AT25 driver registration */
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index 96d6d1b..07522db 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -41,7 +41,7 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 		.membase        =
 			(__force void __iomem *) io_p2v(LPC32XX_UART5_BASE),
 		.mapbase        = LPC32XX_UART5_BASE,
-		.irq		= IRQ_UART_IIR5,
+		.irq		= IRQ_LPC32XX_UART_IIR5,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
@@ -54,7 +54,7 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 		.membase	=
 			(__force void __iomem *) io_p2v(LPC32XX_UART3_BASE),
 		.mapbase        = LPC32XX_UART3_BASE,
-		.irq		= IRQ_UART_IIR3,
+		.irq		= IRQ_LPC32XX_UART_IIR3,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
@@ -67,7 +67,7 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 		.membase	=
 			(__force void __iomem *) io_p2v(LPC32XX_UART4_BASE),
 		.mapbase        = LPC32XX_UART4_BASE,
-		.irq		= IRQ_UART_IIR4,
+		.irq		= IRQ_LPC32XX_UART_IIR4,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
@@ -80,7 +80,7 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 		.membase	=
 			(__force void __iomem *) io_p2v(LPC32XX_UART6_BASE),
 		.mapbase        = LPC32XX_UART6_BASE,
-		.irq		= IRQ_UART_IIR6,
+		.irq		= IRQ_LPC32XX_UART_IIR6,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index cd79017..2c53365 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -164,7 +164,7 @@ static void __init lpc32xx_timer_init(void)
 		LCP32XX_TIMER_MCR(TIMER0_IOBASE));
 
 	/* Setup tick interrupt */
-	setup_irq(IRQ_TIMER0, &lpc32xx_timer_irq);
+	setup_irq(IRQ_LPC32XX_TIMER0, &lpc32xx_timer_irq);
 
 	/* Setup the clockevent structure. */
 	lpc32xx_clkevt.mult = div_sc(clkrate, NSEC_PER_SEC,
-- 
1.6.6
