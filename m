From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 11:20:47 +0200
Subject: [PATCH 03/12] ARM: at91: Export at91_pmc_base
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <f19b797c08017c9b03d81986b2efc4c5cf4bc453.1334567594.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

After commit b55149529d26 (ARM: at91/PMC: make register base soc independent)
building atmel_usba_udc as a module fails with following message
  ERROR: "at91_pmc_base" [drivers/usb/gadget/atmel_usba_udc.ko] undefined!
  make[1]: *** [__modpost] Error 1
  make: *** [modules] Error 2

Export symbol to allow driver to be built as a module again.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
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
1.7.10
