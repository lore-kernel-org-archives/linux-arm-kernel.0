From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 18 Feb 2013 17:08:04 +0530
Subject: [PATCH, RFC 5/8] ARM: OMAP2+: am43: Kconfig
In-Reply-To: <cover.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
Message-ID: <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361186097.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Kconfig option for AM43 family of SoC's, these are ARM Cortex A9
based (SMP configuration with 1 core).

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 49ac3df..683fbaa 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -141,6 +141,17 @@ config SOC_AM33XX
 	select MULTI_IRQ_HANDLER
 	select COMMON_CLK
 
+config SOC_AM43
+	bool "TI AM43"
+	depends on ARCH_OMAP2PLUS
+	default y
+	select CPU_V7
+	select HAVE_SMP
+	select LOCAL_TIMERS if SMP
+	select MULTI_IRQ_HANDLER
+	select ARM_GIC
+	select COMMON_CLK
+
 config OMAP_PACKAGE_ZAF
        bool
 
-- 
1.7.12
