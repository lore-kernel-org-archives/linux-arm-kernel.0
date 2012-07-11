From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 11 Jul 2012 14:36:25 +0100
Subject: [PATCH 3/9] ARM: versatile: Make plat-versatile clock optional
In-Reply-To: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1342013791-19516-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... in preparation for common clock coming for Integrator
and Versatile Express.

Based on Linus Walleij's "ARM: integrator: convert to common
clock" patch.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig                 |    4 ++++
 arch/arm/plat-versatile/Kconfig  |    3 +++
 arch/arm/plat-versatile/Makefile |    2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..17beb66 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -260,6 +260,7 @@ config ARCH_INTEGRATOR
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_FPGA_IRQ
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
@@ -277,6 +278,7 @@ config ARCH_REALVIEW
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_CLCD
 	select ARM_TIMER_SP804
 	select GPIO_PL061 if GPIOLIB
@@ -295,6 +297,7 @@ config ARCH_VERSATILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select NEED_MACH_IO_H if PCI
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_CLCD
 	select PLAT_VERSATILE_FPGA_IRQ
 	select ARM_TIMER_SP804
@@ -314,6 +317,7 @@ config ARCH_VEXPRESS
 	select ICST
 	select NO_IOPORT
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_CLCD
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 81ee7cc..8d5c10a 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -1,5 +1,8 @@
 if PLAT_VERSATILE
 
+config PLAT_VERSATILE_CLOCK
+	bool
+
 config PLAT_VERSATILE_CLCD
 	bool
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index a5cb194..272769a8 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,4 @@
-obj-y	:= clock.o
+obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
-- 
1.7.9.5
