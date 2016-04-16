From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 16 Apr 2016 13:46:14 -0700
Subject: [PATCH v2] bus: brcmstb_gisb: Rework dependencies
Message-ID: <1460839575-16869-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not have the machine Kconfig entry point need to select
BRCMSTB_GISB_ARB, instead, just let it be default ARCH_BRCMSTB which is
a better way to deal with this. While at it, also make it default
BMIPS_GENERIC so the legacy MIPS-based STB platforms can benefit from
the same thing.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- put conditional on the same line, do not use two default lines

 arch/arm/mach-bcm/Kconfig | 1 -
 drivers/bus/Kconfig       | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index b95ea1135ef9..68ab6412392a 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -173,7 +173,6 @@ config ARCH_BRCMSTB
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
-	select BRCMSTB_GISB_ARB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d4a3a3133da5..8807495e0efd 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -58,6 +58,7 @@ config ARM_CCN
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
 	depends on ARM || MIPS
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
 	  arbiter. This driver provides timeout and target abort error handling
-- 
2.5.0
