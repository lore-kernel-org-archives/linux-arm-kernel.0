From: stigge@antcom.de (Roland Stigge)
Date: Tue, 21 Feb 2012 18:37:07 +0100
Subject: [PATCH v2 1/2] GPIO: LPC32xx: Fix missing bit selection mask
Message-ID: <1329845828-26497-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing mask to pin bit selection in gpio-lpc32xx.c
(#define GPIO3_PIN_IN_SEL)

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 drivers/gpio/gpio-lpc32xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
+++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
@@ -59,7 +59,7 @@
 #define GPO3_PIN_TO_BIT(x)			(1 << (x))
 #define GPIO012_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
 #define GPIO3_PIN_IN_SHIFT(x)			((x) == 5 ? 24 : 10 + (x))
-#define GPIO3_PIN_IN_SEL(x, y)			((x) >> GPIO3_PIN_IN_SHIFT(y))
+#define GPIO3_PIN_IN_SEL(x, y)			(((x) >> GPIO3_PIN_IN_SHIFT(y)) & 1)
 #define GPIO3_PIN5_IN_SEL(x)			(((x) >> 24) & 1)
 #define GPI3_PIN_IN_SEL(x, y)			(((x) >> (y)) & 1)
 
