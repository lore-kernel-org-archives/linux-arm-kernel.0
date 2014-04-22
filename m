From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 14:41:16 -0500
Subject: [PATCH 1/3] ARM: mvebu: clean-up unneeded kconfig selects
In-Reply-To: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
Message-ID: <1398195678-28787-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Multi-platform support implies all these options are already selected and
individual platforms don't need to select them.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 3f73eec..bfc5af1 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -3,7 +3,6 @@ config ARCH_MVEBU
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
 	select PINCTRL
 	select PLAT_ORION
 	select MVEBU_MBUS
@@ -11,7 +10,6 @@ config ARCH_MVEBU
 	select ARCH_REQUIRE_GPIOLIB
 	select MIGHT_HAVE_PCI
 	select PCI_QUIRKS if PCI
-	select OF_ADDRESS_PCI
 
 if ARCH_MVEBU
 
@@ -38,7 +36,6 @@ config MACH_ARMADA_375
 	select ARM_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_375_CLK
-	select CPU_V7
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_375
 	help
@@ -51,7 +48,6 @@ config MACH_ARMADA_38X
 	select ARM_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_38X_CLK
-	select CPU_V7
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_38X
 	help
@@ -86,13 +82,11 @@ config MACH_KIRKWOOD
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select KIRKWOOD_CLK
-	select OF_IRQ
 	select ORION_IRQCHIP
 	select ORION_TIMER
 	select PCI
 	select PCI_QUIRKS
 	select PINCTRL_KIRKWOOD
-	select USE_OF
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Kirkwood device tree.
-- 
1.9.1
