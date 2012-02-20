From: stigge@antcom.de (Roland Stigge)
Date: Mon, 20 Feb 2012 22:39:07 +0100
Subject: [PATCH 1/2] GPIO: LPC32xx: Fix missing bit selection mask
Message-ID: <1329773948-4655-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing mask to pin bit selection in gpio-lpc32xx.c
(#define GPIO3_PIN_IN_SEL)

A table indentation change was necessary due to line length restrictions, but
the only relevant change is the definition of GPIO3_PIN_IN_SEL.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/gpio/gpio-lpc32xx.c |   70 ++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

--- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
+++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
@@ -26,42 +26,42 @@
 #include <mach/platform.h>
 #include <mach/gpio-lpc32xx.h>
 
-#define LPC32XX_GPIO_P3_INP_STATE		_GPREG(0x000)
-#define LPC32XX_GPIO_P3_OUTP_SET		_GPREG(0x004)
-#define LPC32XX_GPIO_P3_OUTP_CLR		_GPREG(0x008)
-#define LPC32XX_GPIO_P3_OUTP_STATE		_GPREG(0x00C)
-#define LPC32XX_GPIO_P2_DIR_SET			_GPREG(0x010)
-#define LPC32XX_GPIO_P2_DIR_CLR			_GPREG(0x014)
-#define LPC32XX_GPIO_P2_DIR_STATE		_GPREG(0x018)
-#define LPC32XX_GPIO_P2_INP_STATE		_GPREG(0x01C)
-#define LPC32XX_GPIO_P2_OUTP_SET		_GPREG(0x020)
-#define LPC32XX_GPIO_P2_OUTP_CLR		_GPREG(0x024)
-#define LPC32XX_GPIO_P2_MUX_SET			_GPREG(0x028)
-#define LPC32XX_GPIO_P2_MUX_CLR			_GPREG(0x02C)
-#define LPC32XX_GPIO_P2_MUX_STATE		_GPREG(0x030)
-#define LPC32XX_GPIO_P0_INP_STATE		_GPREG(0x040)
-#define LPC32XX_GPIO_P0_OUTP_SET		_GPREG(0x044)
-#define LPC32XX_GPIO_P0_OUTP_CLR		_GPREG(0x048)
-#define LPC32XX_GPIO_P0_OUTP_STATE		_GPREG(0x04C)
-#define LPC32XX_GPIO_P0_DIR_SET			_GPREG(0x050)
-#define LPC32XX_GPIO_P0_DIR_CLR			_GPREG(0x054)
-#define LPC32XX_GPIO_P0_DIR_STATE		_GPREG(0x058)
-#define LPC32XX_GPIO_P1_INP_STATE		_GPREG(0x060)
-#define LPC32XX_GPIO_P1_OUTP_SET		_GPREG(0x064)
-#define LPC32XX_GPIO_P1_OUTP_CLR		_GPREG(0x068)
-#define LPC32XX_GPIO_P1_OUTP_STATE		_GPREG(0x06C)
-#define LPC32XX_GPIO_P1_DIR_SET			_GPREG(0x070)
-#define LPC32XX_GPIO_P1_DIR_CLR			_GPREG(0x074)
-#define LPC32XX_GPIO_P1_DIR_STATE		_GPREG(0x078)
+#define LPC32XX_GPIO_P3_INP_STATE	_GPREG(0x000)
+#define LPC32XX_GPIO_P3_OUTP_SET	_GPREG(0x004)
+#define LPC32XX_GPIO_P3_OUTP_CLR	_GPREG(0x008)
+#define LPC32XX_GPIO_P3_OUTP_STATE	_GPREG(0x00C)
+#define LPC32XX_GPIO_P2_DIR_SET		_GPREG(0x010)
+#define LPC32XX_GPIO_P2_DIR_CLR		_GPREG(0x014)
+#define LPC32XX_GPIO_P2_DIR_STATE	_GPREG(0x018)
+#define LPC32XX_GPIO_P2_INP_STATE	_GPREG(0x01C)
+#define LPC32XX_GPIO_P2_OUTP_SET	_GPREG(0x020)
+#define LPC32XX_GPIO_P2_OUTP_CLR	_GPREG(0x024)
+#define LPC32XX_GPIO_P2_MUX_SET		_GPREG(0x028)
+#define LPC32XX_GPIO_P2_MUX_CLR		_GPREG(0x02C)
+#define LPC32XX_GPIO_P2_MUX_STATE	_GPREG(0x030)
+#define LPC32XX_GPIO_P0_INP_STATE	_GPREG(0x040)
+#define LPC32XX_GPIO_P0_OUTP_SET	_GPREG(0x044)
+#define LPC32XX_GPIO_P0_OUTP_CLR	_GPREG(0x048)
+#define LPC32XX_GPIO_P0_OUTP_STATE	_GPREG(0x04C)
+#define LPC32XX_GPIO_P0_DIR_SET		_GPREG(0x050)
+#define LPC32XX_GPIO_P0_DIR_CLR		_GPREG(0x054)
+#define LPC32XX_GPIO_P0_DIR_STATE	_GPREG(0x058)
+#define LPC32XX_GPIO_P1_INP_STATE	_GPREG(0x060)
+#define LPC32XX_GPIO_P1_OUTP_SET	_GPREG(0x064)
+#define LPC32XX_GPIO_P1_OUTP_CLR	_GPREG(0x068)
+#define LPC32XX_GPIO_P1_OUTP_STATE	_GPREG(0x06C)
+#define LPC32XX_GPIO_P1_DIR_SET		_GPREG(0x070)
+#define LPC32XX_GPIO_P1_DIR_CLR		_GPREG(0x074)
+#define LPC32XX_GPIO_P1_DIR_STATE	_GPREG(0x078)
 
-#define GPIO012_PIN_TO_BIT(x)			(1 << (x))
-#define GPIO3_PIN_TO_BIT(x)			(1 << ((x) + 25))
-#define GPO3_PIN_TO_BIT(x)			(1 << (x))
-#define GPIO012_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
-#define GPIO3_PIN_IN_SHIFT(x)			((x) == 5 ? 24 : 10 + (x))
-#define GPIO3_PIN_IN_SEL(x, y)			((x) >> GPIO3_PIN_IN_SHIFT(y))
-#define GPIO3_PIN5_IN_SEL(x)			(((x) >> 24) & 1)
-#define GPI3_PIN_IN_SEL(x, y)			(((x) >> (y)) & 1)
+#define GPIO012_PIN_TO_BIT(x)		(1 << (x))
+#define GPIO3_PIN_TO_BIT(x)		(1 << ((x) + 25))
+#define GPO3_PIN_TO_BIT(x)		(1 << (x))
+#define GPIO012_PIN_IN_SEL(x, y)	(((x) >> (y)) & 1)
+#define GPIO3_PIN_IN_SHIFT(x)		((x) == 5 ? 24 : 10 + (x))
+#define GPIO3_PIN_IN_SEL(x, y)		(((x) >> GPIO3_PIN_IN_SHIFT(y)) & 1)
+#define GPIO3_PIN5_IN_SEL(x)		(((x) >> 24) & 1)
+#define GPI3_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
 
 struct gpio_regs {
 	void __iomem *inp_state;
