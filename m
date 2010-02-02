From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:19 -0800
Subject: [PATCH 07/16] ARM: LPC32XX: Added LPC32XX identifier to UART register
	field macros
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-8-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The UART macros and associated code have been updated with the
LPC32XX identifier.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/include/mach/platform.h |   56 ++++++++++++------------
 arch/arm/mach-lpc32xx/serial.c                |   37 +++++++++-------
 2 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index 1ee148c..9de37ee 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -642,48 +642,48 @@
  * Standard UART register offsets
  *
  */
-#define UART_DLL_FIFO(x)		((x) + 0x00)
-#define UART_DLM_IER(x)			((x) + 0x04)
-#define UART_IIR_FCR(x)			((x) + 0x08)
-#define UART_LCR_(x)			((x) + 0x0C)
-#define UART_MODEM_CTRL(x)		((x) + 0x10)
-#define UART_LSR_(x)			((x) + 0x14)
-#define UART_MODEM_STATUS(x)		((x) + 0x18)
-#define UART_RXLEV(x)			((x) + 0x1C)
+#define LPC32XX_UART_DLL_FIFO(x)		((x) + 0x00)
+#define LPC32XX_UART_DLM_IER(x)			((x) + 0x04)
+#define LPC32XX_UART_IIR_FCR(x)			((x) + 0x08)
+#define LPC32XX_UART_LCR_(x)			((x) + 0x0C)
+#define LPC32XX_UART_MODEM_CTRL(x)		((x) + 0x10)
+#define LPC32XX_UART_LSR_(x)			((x) + 0x14)
+#define LPC32XX_UART_MODEM_STATUS(x)		((x) + 0x18)
+#define LPC32XX_UART_RXLEV(x)			((x) + 0x1C)
 
 /*
  *
  * UART control structure offsets
  *
  */
-#define UARTCTL_CTRL(x)			((x) + 0x00)
-#define UARTCTL_CLKMODE(x)		((x) + 0x04)
-#define UARTCTL_CLOOP(x)		((x) + 0x08)
+#define LPC32XX_UARTCTL_CTRL(x)			((x) + 0x00)
+#define LPC32XX_UARTCTL_CLKMODE(x)		((x) + 0x04)
+#define LPC32XX_UARTCTL_CLOOP(x)		((x) + 0x08)
 
 /*
  * ctrl register definitions
  */
-#define UART_U3_MD_CTRL_EN		_BIT(11)
-#define UART_IRRX6_INV_EN		_BIT(10)
-#define UART_HDPX_EN			_BIT(9)
-#define UART_UART6_IRDAMOD_BYPASS	_BIT(5)
-#define RT_IRTX6_INV_EN			_BIT(4)
-#define RT_IRTX6_INV_MIR_EN		_BIT(3)
-#define RT_RX_IRPULSE_3_16_115K		_BIT(2)
-#define RT_TX_IRPULSE_3_16_115K		_BIT(1)
-#define UART_U5_ROUTE_TO_USB		_BIT(0)
+#define LPC32XX_UART_U3_MD_CTRL_EN		_BIT(11)
+#define LPC32XX_UART_IRRX6_INV_EN		_BIT(10)
+#define LPC32XX_UART_HDPX_EN			_BIT(9)
+#define LPC32XX_UART_UART6_IRDAMOD_BYPASS	_BIT(5)
+#define LPC32XX_RT_IRTX6_INV_EN			_BIT(4)
+#define LPC32XX_RT_IRTX6_INV_MIR_EN		_BIT(3)
+#define LPC32XX_RT_RX_IRPULSE_3_16_115K		_BIT(2)
+#define LPC32XX_RT_TX_IRPULSE_3_16_115K		_BIT(1)
+#define LPC32XX_UART_U5_ROUTE_TO_USB		_BIT(0)
 
 /*
  * clkmode register definitions
  */
-#define UART_ENABLED_CLOCKS(n)		(((n) >> 16) & 0x7F)
-#define UART_ENABLED_CLOCK(n, u)	(((n) >> (16 + (u))) & 0x1)
-#define UART_ENABLED_CLKS_ANY		_BIT(14)
-#define UART_CLKMODE_OFF		0x0
-#define UART_CLKMODE_ON			0x1
-#define UART_CLKMODE_AUTO		0x2
-#define UART_CLKMODE_MASK(u)		(0x3 << ((((u) - 3) * 2) + 4))
-#define UART_CLKMODE_LOAD(m, u)		((m) << ((((u) - 3) * 2) + 4))
+#define LPC32XX_UART_ENABLED_CLOCKS(n)		(((n) >> 16) & 0x7F)
+#define LPC32XX_UART_ENABLED_CLOCK(n, u)	(((n) >> (16 + (u))) & 0x1)
+#define LPC32XX_UART_ENABLED_CLKS_ANY		_BIT(14)
+#define LPC32XX_UART_CLKMODE_OFF		0x0
+#define LPC32XX_UART_CLKMODE_ON			0x1
+#define LPC32XX_UART_CLKMODE_AUTO		0x2
+#define LPC32XX_UART_CLKMODE_MASK(u)		(0x3 << ((((u) - 3) * 2) + 4))
+#define LPC32XX_UART_CLKMODE_LOAD(m, u)		((m) << ((((u) - 3) * 2) + 4))
 
 /*
  *
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index def5003..3a0acfd 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -97,28 +97,32 @@ static struct uartinit uartinit_data[] __initdata = {
 #ifdef CONFIG_ARCH_LPC32XX_UART5_ENABLE
 	{
 		.uart_ck_name = "uart5_ck",
-		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 5),
+		.ck_mode_mask =
+			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 5),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART5_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
 	{
 		.uart_ck_name = "uart3_ck",
-		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 3),
+		.ck_mode_mask =
+			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 3),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART3_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
 	{
 		.uart_ck_name = "uart4_ck",
-		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 4),
+		.ck_mode_mask =
+			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 4),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART4_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
 	{
 		.uart_ck_name = "uart6_ck",
-		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 6),
+		.ck_mode_mask =
+			LPC32XX_UART_CLKMODE_LOAD(LPC32XX_UART_CLKMODE_ON, 6),
 		.pdiv_clk_reg = LPC32XX_CLKPWR_UART6_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
@@ -169,31 +173,32 @@ void __init lpc32xx_serial_init(void)
 	}
 
 	/* This needs to be done after all UART clocks are setup */
-	writel(clkmodes, UARTCTL_CLKMODE(io_p2v(LPC32XX_UART_CTRL_BASE)));
+	writel(clkmodes,
+		LPC32XX_UARTCTL_CLKMODE(io_p2v(LPC32XX_UART_CTRL_BASE)));
 	for (i = 0; i < ARRAY_SIZE(uartinit_data) - 1; i++) {
 		/* Force a flush of the RX FIFOs to work around a HW bug */
 		puart = serial_std_platform_data[i].membase;
-		writel(0xC1, UART_IIR_FCR(puart));
-		writel(0x00, UART_DLL_FIFO(puart));
+		writel(0xC1, LPC32XX_UART_IIR_FCR(puart));
+		writel(0x00, LPC32XX_UART_DLL_FIFO(puart));
 		clkmodes = 64;
 		while (clkmodes--)
-			tmp = readl(UART_DLL_FIFO(puart));
-		writel(0, UART_IIR_FCR(puart));
+			tmp = readl(LPC32XX_UART_DLL_FIFO(puart));
+		writel(0, LPC32XX_UART_IIR_FCR(puart));
 	}
 
 	/* IrDA pulsing support on UART6. This only enables the IrDA mux */
-	tmp = readl(UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
+	tmp = readl(LPC32XX_UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
 #ifdef CONFIG_ARCH_LPC32XX_UART6_IRDAMODE
-	tmp &= ~UART_UART6_IRDAMOD_BYPASS;
+	tmp &= ~LPC32XX_UART_UART6_IRDAMOD_BYPASS;
 #else
-	tmp |= UART_UART6_IRDAMOD_BYPASS;
+	tmp |= LPC32XX_UART_UART6_IRDAMOD_BYPASS;
 #endif
-	writel(tmp, UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
+	writel(tmp, LPC32XX_UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
 
 	/* Disable UART5->USB transparent mode or USB won't work */
-	tmp = readl(UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
-	tmp &= ~UART_U5_ROUTE_TO_USB;
-	writel(tmp, UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
+	tmp = readl(LPC32XX_UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
+	tmp &= ~LPC32XX_UART_U5_ROUTE_TO_USB;
+	writel(tmp, LPC32XX_UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
 
 	platform_add_devices(lpc32xx_serial_devs,
 		ARRAY_SIZE(lpc32xx_serial_devs));
-- 
1.6.6
