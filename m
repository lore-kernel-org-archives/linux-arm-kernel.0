From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 25 Aug 2012 14:20:42 +0200
Subject: [PATCH 2/3] ARM: S3C24XX: Remove obsolete GPIO API declarations
In-Reply-To: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1345897243-15619-3-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's safe to empty the plat-samsung/incude/plat/gpio-fns.h header
now when all users of those functions have been converted to
generic gpiolib API or to s3c_gpio_cfg().

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/plat-samsung/include/plat/gpio-fns.h |   97 -------------------------
 1 files changed, 0 insertions(+), 97 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-fns.h b/arch/arm/plat-samsung/include/plat/gpio-fns.h
index bab1392..d1ecef0 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-fns.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-fns.h
@@ -1,98 +1 @@
-/* arch/arm/mach-s3c2410/include/mach/gpio-fns.h
- *
- * Copyright (c) 2003-2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - hardware
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __MACH_GPIO_FNS_H
-#define __MACH_GPIO_FNS_H __FILE__
-
-/* These functions are in the to-be-removed category and it is strongly
- * encouraged not to use these in new code. They will be marked deprecated
- * very soon.
- *
- * Most of the functionality can be either replaced by the gpiocfg calls
- * for the s3c platform or by the generic GPIOlib API.
- *
- * As of 2.6.35-rc, these will be removed, with the few drivers using them
- * either replaced or given a wrapper until the calls can be removed.
-*/
-
 #include <plat/gpio-cfg.h>
-
-static inline void s3c2410_gpio_cfgpin(unsigned int pin, unsigned int cfg)
-{
-	/* 1:1 mapping between cfgpin and setcfg calls at the moment */
-	s3c_gpio_cfgpin(pin, cfg);
-}
-
-/* external functions for GPIO support
- *
- * These allow various different clients to access the same GPIO
- * registers without conflicting. If your driver only owns the entire
- * GPIO register, then it is safe to ioremap/__raw_{read|write} to it.
-*/
-
-extern unsigned int s3c2410_gpio_getcfg(unsigned int pin);
-
-/* s3c2410_gpio_getirq
- *
- * turn the given pin number into the corresponding IRQ number
- *
- * returns:
- *	< 0 = no interrupt for this pin
- *	>=0 = interrupt number for the pin
-*/
-
-extern int s3c2410_gpio_getirq(unsigned int pin);
-
-/* s3c2410_gpio_irqfilter
- *
- * set the irq filtering on the given pin
- *
- * on = 0 => disable filtering
- *      1 => enable filtering
- *
- * config = S3C2410_EINTFLT_PCLK or S3C2410_EINTFLT_EXTCLK orred with
- *          width of filter (0 through 63)
- *
- *
-*/
-
-extern int s3c2410_gpio_irqfilter(unsigned int pin, unsigned int on,
-				  unsigned int config);
-
-/* s3c2410_gpio_pullup
- *
- * This call should be replaced with s3c_gpio_setpull().
- *
- * As a note, there is currently no distinction between pull-up and pull-down
- * in the s3c24xx series devices with only an on/off configuration.
- */
-
-/* s3c2410_gpio_pullup
- *
- * configure the pull-up control on the given pin
- *
- * to = 1 => disable the pull-up
- *      0 => enable the pull-up
- *
- * eg;
- *
- *   s3c2410_gpio_pullup(S3C2410_GPB(0), 0);
- *   s3c2410_gpio_pullup(S3C2410_GPE(8), 0);
-*/
-
-extern void s3c2410_gpio_pullup(unsigned int pin, unsigned int to);
-
-extern void s3c2410_gpio_setpin(unsigned int pin, unsigned int to);
-
-extern unsigned int s3c2410_gpio_getpin(unsigned int pin);
-
-#endif /* __MACH_GPIO_FNS_H */
-- 
1.7.4.1
