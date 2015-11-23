From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 22 Nov 2015 22:44:19 -0500 (EST)
Subject: [PATCH] ARM: mach-orion5x: fix legacy get_irqnr_and_base
Message-ID: <alpine.LFD.2.20.1511222240150.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5be9fc23cd ("ARM: orion5x: fix legacy orion5x IRQ numbers") shifted
IRQ numbers by one but didn't update the get_irqnr_and_base macro
accordingly.  This macro is involved when CONFIG_MULTI_IRQ_HANDLER
is not defined.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mach-orion5x/include/mach/entry-macro.S b/arch/arm/mach-orion5x/include/mach/entry-macro.S
index 79eb502a1e..73919a36b5 100644
--- a/arch/arm/mach-orion5x/include/mach/entry-macro.S
+++ b/arch/arm/mach-orion5x/include/mach/entry-macro.S
@@ -21,5 +21,5 @@
 	@ find cause bits that are unmasked
 	ands	\irqstat, \irqstat, \tmp	@ clear Z flag if any
 	clzne	\irqnr,	\irqstat		@ calc irqnr
-	rsbne	\irqnr, \irqnr, #31
+	rsbne	\irqnr, \irqnr, #32
 	.endm
