From: manabian@gmail.com (manabian at gmail.com)
Date: Fri, 30 Mar 2012 23:03:50 +0200
Subject: [PATCH] ARM: at91: Export at91_ramc_base
Message-ID: <4f761fd8.8843cc0a.22b0.6caa@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <joachim.eastwood@jotron.com>

After commit f363c407b42c4 building at91_cf as a module fails with:
  ERROR: "at91_ramc_base" [drivers/pcmcia/at91_cf.ko] undefined!
  make[1]: *** [__modpost] Error 1
  make: *** [modules] Error 2

Export at91_ramc_base symbol to allow drivers using at91_ramc_*
functions to be built as modules again.

Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---

This makes at91_cf compile again but it still doesn't work. Still
trying to figure out why.

 arch/arm/mach-at91/setup.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 1083739..aa010a9 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -53,6 +53,7 @@ void __init at91_init_interrupts(unsigned int *priority)
 }
 
 void __iomem *at91_ramc_base[2];
+EXPORT_SYMBOL(at91_ramc_base);
 
 void __init at91_ioremap_ramc(int id, u32 addr, u32 size)
 {
-- 
1.7.9.2
