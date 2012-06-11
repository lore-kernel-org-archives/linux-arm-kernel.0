From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 13:02:17 +0200
Subject: [PATCH 14/14] ARM: LPC32xx: Remove mach specific ARCH_NR_GPIOS,
 use default
In-Reply-To: <1339412537-24485-1-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
Message-ID: <1339412537-24485-15-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_NR_GPIOS was defined statically to include exactly all SoC specific GPIOs.
Now if additional GPIOs need to be added dynamically, e.g. via DT, none are
available. Removing the mach specific setting, leaving ARCH_NR_GPIOS to the
default of 256 (currently in include/asm-generic/gpio.h).

Signed-off-by: Roland Stigge <stigge@antcom.de>

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
