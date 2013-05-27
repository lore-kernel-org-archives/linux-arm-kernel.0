From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 27 May 2013 20:05:31 +0530
Subject: [PATCH v2 02/14] ARM: OMAP2+: AM43x: Kconfig
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Message-ID: <7642e0c701680ea94a8cc84059ff19e500813bf1.1369658705.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kconfig for AM43x (Cortex A9) family of SoC's.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v2: Remove reliance on SMP, TWD, select MACH_OMAP_GENERIC

 arch/arm/mach-omap2/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..8f555f8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -149,6 +149,16 @@ config SOC_AM33XX
 	select MULTI_IRQ_HANDLER
 	select COMMON_CLK
 
+config SOC_AM43XX
+	bool "TI AM43x"
+	depends on ARCH_OMAP2PLUS
+	default y
+	select CPU_V7
+	select MULTI_IRQ_HANDLER
+	select ARM_GIC
+	select COMMON_CLK
+	select MACH_OMAP_GENERIC
+
 config OMAP_PACKAGE_ZAF
        bool
 
-- 
1.7.12
