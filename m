From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:04 +0200
Subject: [PATCH v2 14/23] ARM: LPC32xx: Remove mach specific ARCH_NR_GPIOS,
 use default
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-15-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_NR_GPIOS was defined statically to include exactly all SoC specific GPIOs.
Now if additional GPIOs need to be added dynamically, e.g. via DT, none are
available. Removing the mach specific setting, leaving ARCH_NR_GPIOS to the
default of 256 (currently in include/asm-generic/gpio.h).

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/mach-lpc32xx/include/mach/gpio.h |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ linux-2.6/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -3,6 +3,4 @@
 
 #include "gpio-lpc32xx.h"
 
-#define ARCH_NR_GPIOS (LPC32XX_GPO_P3_GRP + LPC32XX_GPO_P3_MAX)
-
 #endif /* __MACH_GPIO_H */
