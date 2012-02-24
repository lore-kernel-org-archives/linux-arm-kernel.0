From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 16:54:04 -0800
Subject: [PATCH 1/7] ARM: OMAP2+: Fix Kconfig dependencies for
 USB_ARCH_HAS_EHCI
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Message-ID: <20120224005403.16794.15077.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get:

warning: (ARCH_OMAP3 && ARCH_OMAP4) selects USB_ARCH_HAS_EHCI
which has unmet direct dependencies (USB_SUPPORT)

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d965da4..337f98d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -32,7 +32,7 @@ config ARCH_OMAP3
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V7
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select ARM_CPU_SUSPEND if PM
@@ -52,7 +52,7 @@ config ARCH_OMAP4
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
 
 comment "OMAP Core Type"
