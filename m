From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 14:41:17 -0500
Subject: [PATCH 2/3] ARM: bcm: clean-up unneeded kconfig selects
In-Reply-To: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
Message-ID: <1398195678-28787-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Multi-platform support implies all these options are already selected and
individual platforms don't need to select them.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Christian Daudt <bcm@fixthebug.org>
Cc: Matt Porter <mporter@linaro.org>
Cc: bcm-kernel-feedback-list at broadcom.com
---
 arch/arm/mach-bcm/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 49c914c..9f19636 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -11,7 +11,6 @@ menu "Broadcom SoC Selection"
 
 config ARCH_BCM_MOBILE
 	bool "Broadcom Mobile SoC" if ARCH_MULTI_V7
-	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
@@ -33,10 +32,7 @@ config ARCH_BCM2835
 	select ARM_AMBA
 	select ARM_ERRATA_411920
 	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
 	select CLKSRC_OF
-	select CPU_V6
-	select GENERIC_CLOCKEVENTS
 	select PINCTRL
 	select PINCTRL_BCM2835
 	help
@@ -45,14 +41,10 @@ config ARCH_BCM2835
 
 config ARCH_BCM_5301X
 	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
-	depends on MMU
 	select ARM_GIC
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_SMP
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	select MIGHT_HAVE_PCI
-- 
1.9.1
