From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 25 Jul 2012 11:49:34 +0100
Subject: [PATCH] ARM: versatile: Don't use platform clock for Integrator & VE
Message-ID: <1343213374-30088-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to automatic merge of a613163dff04cbfcb7d66b06ef4a5f65498ee59b
"ARM: integrator: convert to common clock" and
56a34b03ff427046494db87f05fc810aaedd23a5 "ARM: versatile: Make
plat-versatile clock optional" two platforms: Integrator and
Versatile Express now select both COMMON_CLK and
PLAT_VERSATILE_CLOCK which breaks building them. Fixed now.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig |    2 --
 1 file changed, 2 deletions(-)

Arnd, Olof,

Would you consider adding this patch to one of your late pull
requests for 3.6 or do you want me to wait till 3.6-rc1?

Regards

Pawel

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b25c9d3..9124ff7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -279,7 +279,6 @@ config ARCH_INTEGRATOR
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_FPGA_IRQ
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
@@ -336,7 +335,6 @@ config ARCH_VEXPRESS
 	select ICST
 	select NO_IOPORT
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_CLCD
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
-- 
1.7.9.5
