From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  7 Apr 2012 19:30:22 +0200
Subject: [PATCH 1/2 v2] ARM: at91: Export at91_pmc_base
Message-ID: <1333819823-2279-1-git-send-email-joachim.eastwood@jotron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit b55149529d26 (ARM: at91/PMC: make register base soc independent)
building atmel_usba_udc as a module fails with following message
  ERROR: "at91_pmc_base" [drivers/usb/gadget/atmel_usba_udc.ko] undefined!
  make[1]: *** [__modpost] Error 1
  make: *** [modules] Error 2

Export symbol to allow driver to be built as a module again.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---

Now exported as GPL only symbol.

 arch/arm/mach-at91/clock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index a0f4d74..6b69282 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -35,6 +35,7 @@
 #include "generic.h"
 
 void __iomem *at91_pmc_base;
+EXPORT_SYMBOL_GPL(at91_pmc_base);
 
 /*
  * There's a lot more which can be done with clocks, including cpufreq
-- 
1.7.9.6
