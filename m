From: leochen@broadcom.com (Leo Chen)
Date: Wed, 7 Oct 2009 11:43:05 -0700
Subject: [PATCH] bcmring: gpio addition to Kconfig and Makefile
Message-ID: <mailman.62.1255122757.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/Kconfig                   |    3 ++-
 arch/arm/mach-bcmring/Makefile     |    3 ++-
 arch/arm/mach-bcmring/csp/Makefile |    2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..d22af37 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -695,10 +695,11 @@ config ARCH_BCMRING
 	depends on MMU
 	select CPU_V6
 	select ARM_AMBA
+	select GENERIC_GPIO
 	select COMMON_CLKDEV
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for Broadcom's BCMRing platform.
 
diff --git a/arch/arm/mach-bcmring/Makefile b/arch/arm/mach-bcmring/Makefile
index f8d9fce..b629869 100644
--- a/arch/arm/mach-bcmring/Makefile
+++ b/arch/arm/mach-bcmring/Makefile
@@ -4,5 +4,6 @@
 
 # Object file lists.
 
-obj-y := arch.o mm.o irq.o clock.o core.o timer.o dma.o
+obj-y := arch.o mm.o irq.o clock.o core.o timer.o dma.o gpio_irq.o
 obj-y += csp/
+obj-$(CONFIG_ARCH_REQUIRE_GPIOLIB)	+= gpio.o
diff --git a/arch/arm/mach-bcmring/csp/Makefile b/arch/arm/mach-bcmring/csp/Makefile
index 648c037..65c6abc 100644
--- a/arch/arm/mach-bcmring/csp/Makefile
+++ b/arch/arm/mach-bcmring/csp/Makefile
@@ -1,3 +1,5 @@
 obj-y += dmac/
 obj-y += tmr/
 obj-y += chipc/
+obj-y += gpio/
+obj-y += gpiomux/
-- 
1.6.0.6

Leo Chen
