From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Sep 2015 16:18:13 -0500
Subject: [PATCH 3/4] ARM: DRA7: Select missing options for SoC only build
In-Reply-To: <1441833494-32450-1-git-send-email-nm@ti.com>
References: <1441833494-32450-1-git-send-email-nm@ti.com>
Message-ID: <1441833494-32450-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7 does use OPP, uses OMAP interconnect and also does require SCU.
These are missing in the SoC only build of DRA7 breaking various PM
features in DRA7 only build.

Reported-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 07d2e100caab..403022a38607 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -70,10 +70,13 @@ config SOC_DRA7XX
 	select ARCH_OMAP2PLUS
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
+	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select IRQ_CROSSBAR
 	select ARM_ERRATA_798181 if SMP
+	select OMAP_INTERCONNECT
 	select OMAP_INTERCONNECT_BARRIER
+	select PM_OPP if PM
 
 config ARCH_OMAP2PLUS
 	bool
-- 
1.7.9.5
