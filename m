From: peter.chubb@nicta.com.au (Peter Chubb)
Date: Wed, 14 Jul 2010 09:20:22 +1000
Subject: AT91 NOMMU fails to compile 2.6.35-rc5
Message-ID: <w4d3urj7ex.wl%peter@chubb.wattle.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>From Linus's tree, 2.6.35-rc5, attempting to compile gives errors in
system.h, because the AT91x40 does not have useful performance
management counters.  This patch avoids that problem.

Signed-off-by: Peter Chubb <peter.chubb@nicta.com.au>

Index: linux-2.6.x/arch/arm/mach-at91/include/mach/system.h
===================================================================
--- linux-2.6.x.orig/arch/arm/mach-at91/include/mach/system.h	2010-07-14 09:07:21.046719584 +1000
+++ linux-2.6.x/arch/arm/mach-at91/include/mach/system.h	2010-07-14 09:07:50.426638015 +1000
@@ -28,7 +28,7 @@
 
 static inline void arch_idle(void)
 {
-#ifndef CONFIG_DEBUG_KERNEL
+#if !defined(CONFIG_DEBUG_KERNEL) && defined(AT91_PMC)
 	/*
 	 * Disable the processor clock.  The processor will be automatically
 	 * re-enabled by an interrupt or by a reset.



--
Dr Peter Chubb                                  peter DOT chubb AT nicta.com.au
http://www.ertos.nicta.com.au               ERTOS within National ICT Australia
All things shall perish from under the sky/Music alone shall live, never to die
