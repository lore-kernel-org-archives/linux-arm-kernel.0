From: nm@ti.com (Nishanth Menon)
Date: Wed, 15 Jan 2014 14:00:38 -0600
Subject: [PATCH] ARM: OMAP2+: add missing ARCH_HAS_OPP
Message-ID: <1389816038-17363-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5, DRA7, AM43xx all have OPPs. So select the same to allow SoC
only configuration boot to work with OPP.

Reported-by: Nikhil Devshatwar <nikhil.nd@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

For DRA7, depends on: https://patchwork.kernel.org/patch/3465411/

 arch/arm/mach-omap2/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 35c23e5..66a9c4a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -50,6 +50,7 @@ config SOC_OMAP5
 	bool "TI OMAP5"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
+	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select CPU_V7
@@ -63,6 +64,7 @@ config SOC_AM33XX
 	bool "TI AM33XX"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
+	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
 	select CPU_V7
 	select MULTI_IRQ_HANDLER
@@ -72,6 +74,7 @@ config SOC_AM43XX
 	depends on ARCH_MULTI_V7
 	select CPU_V7
 	select ARCH_OMAP2PLUS
+	select ARCH_HAS_OPP
 	select MULTI_IRQ_HANDLER
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
@@ -80,6 +83,7 @@ config SOC_DRA7XX
 	bool "TI DRA7XX"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
+	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select CPU_V7
-- 
1.7.9.5
