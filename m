From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Apr 2016 11:17:48 -0700
Subject: [PATCH] bus: brcmstb_gisb: Rework dependencies
Message-ID: <1460571469-20201-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not have the machine Kconfig entry point need to select
BRCMSTB_GISB_ARB, instead, just let it be default ARCH_BRCMSTB which is
a better way to deal with this. While at it, also make it default
BMIPS_GENERIC so the legacy MIPS-based STB platforms can benefit from
the same thing.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 -
 drivers/bus/Kconfig       | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef121472cdd..af10ff27a2ed 100644
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
index d4a3a3133da5..85c66e5028c1 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -58,6 +58,8 @@ config ARM_CCN
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
 	depends on ARM || MIPS
+	default ARCH_BRCMSTB
+	default BMIPS_GENERIC
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
 	  arbiter. This driver provides timeout and target abort error handling
-- 
2.1.0
