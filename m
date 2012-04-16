From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 11:20:45 +0200
Subject: [PATCH 01/12] ARM: at91: Export at91_st_base
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <9fce85c7e4357a93457c8fd2534a1cc1c3055bf5.1334567594.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

After commit 5e9cf5e (ARM: at91: make ST (System Timer) soc independent)
building at91rm9200_wdt as a module fails with following message
  ERROR: "at91_st_base" [drivers/watchdog/at91rm9200_wdt.ko] undefined!
  make[1]: *** [__modpost] Error 1
  make: *** [modules] Error 2

Export symbol to allow wdt driver to be built as a module again.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
[nicolas.ferre at atmel.com: use EXPORT_SYMBOL_GPL()]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91rm9200_time.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index dd7f782..104ca40 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/clockchips.h>
+#include <linux/export.h>
 
 #include <asm/mach/time.h>
 
@@ -176,6 +177,7 @@ static struct clock_event_device clkevt = {
 };
 
 void __iomem *at91_st_base;
+EXPORT_SYMBOL_GPL(at91_st_base);
 
 void __init at91rm9200_ioremap_st(u32 addr)
 {
-- 
1.7.10
