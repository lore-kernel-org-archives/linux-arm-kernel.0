From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 14:15:10 +0100
Subject: [PATCH 3/4] ARM: realview: imply Device Tree config
In-Reply-To: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
References: <1456406111-18579-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1456406111-18579-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cuts the RealView DT Kconfig to be the same as
CONFIG_ARCH_REALVIEW and rids one Kconfig option.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/Kconfig  | 23 ++++++++---------------
 arch/arm/mach-realview/Makefile |  2 +-
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index cfb4c573638f..1706adc5513a 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,22 +1,12 @@
 menuconfig ARCH_REALVIEW
 	bool "ARM Ltd. RealView family" if ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select ARM_AMBA
-	select ARM_TIMER_SP804
-	select COMMON_CLK_VERSATILE
-	select GPIO_PL061 if GPIOLIB
-	select ICST
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_SCHED_CLOCK
-	help
-	  This enables support for ARM Ltd RealView boards.
-
-if ARCH_REALVIEW
-
-config REALVIEW_DT
-	bool "Support RealView(R) Device Tree based boot"
 	select ARM_GIC
+	select ARM_TIMER_SP804
 	select CLK_SP810
+	select COMMON_CLK_VERSATILE
 	select CPU_ARM926T if ARCH_MULTI_V5
+	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
@@ -24,6 +14,8 @@ config REALVIEW_DT
 	select HAVE_TCM
 	select ICST
 	select MFD_SYSCON
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_SCHED_CLOCK
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
@@ -32,8 +24,9 @@ config REALVIEW_DT
 	select USE_OF
 	select ZONE_DMA
 	help
-	  Include support for booting the ARM(R) RealView(R) evaluation
-	  boards using a device tree machine description.
+	  This enables support for ARM Ltd RealView boards.
+
+if ARCH_REALVIEW
 
 config REALVIEW_HIGH_PHYS_OFFSET
 	bool "High physical base address for the RealView platform"
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 97dab53daaf1..75826b2be82e 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -4,6 +4,6 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-versatile/include
 
-obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
+obj-$(CONFIG_ARCH_REALVIEW)		+= realview-dt.o
 obj-$(CONFIG_SMP)			+= platsmp-dt.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
-- 
2.4.3
