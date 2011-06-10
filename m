From: nm@ti.com (Nishanth Menon)
Date: Fri, 10 Jun 2011 10:14:33 -0500
Subject: [PATCH] OMAP3+: Kconfig: has EHCI only if USB present
Message-ID: <1307718873-27652-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Attempting to disable USB generates the following warning at the moment:
warning: (ARCH_OMAP3 && ARCH_OMAP4) selects USB_ARCH_HAS_EHCI which has unmet direct dependencies (USB_SUPPORT)

Signed-off-by: Nishanth Menon <nm@ti.com>
---
based on 3.0-rc2
 arch/arm/mach-omap2/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ef7e12f..d5cf1a8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -33,7 +33,7 @@ config ARCH_OMAP3
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V7
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
@@ -50,7 +50,7 @@ config ARCH_OMAP4
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
-- 
1.7.1
