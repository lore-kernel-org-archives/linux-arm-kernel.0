From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 15:09:19 -0800
Subject: [PATCH] ARM: BCM63XX: Enable reset controller support
Message-ID: <20181105230920.26270-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow BCM63xx to compile support for reset controllers since we will
require a specific reset controller to release resets for on-chip
peripherals.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 25aac6ee2ab1..005f4e98dfb7 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -189,6 +189,7 @@ config ARCH_BCM_63XX
 	bool "Broadcom BCM63xx DSL SoC"
 	depends on ARCH_MULTI_V7
 	depends on MMU
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
-- 
2.17.1
