From: khilman@ti.com (Kevin Hilman)
Date: Tue,  8 May 2012 15:02:55 -0700
Subject: [PATCH 2/3] ARM: OMAP2+: Kconfig: convert SOC_OMAPTI81XX to SOC_TI81XX
In-Reply-To: <1336514576-4870-1-git-send-email-khilman@ti.com>
References: <1336514576-4870-1-git-send-email-khilman@ti.com>
Message-ID: <1336514576-4870-3-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to have an OMAP prefix on these SoCs that are in the family
but arent' really called OMAP.

Simple rename: CONFIG_SOC_OMAPTI81XX --> CONFIG_SOC_TI81XX

No functional change.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    6 +++---
 arch/arm/mach-omap2/common.h |    2 +-
 arch/arm/mach-omap2/io.c     |    4 ++--
 arch/arm/mach-omap2/irq.c    |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8141b76..7f89697 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -77,7 +77,7 @@ config SOC_OMAP3430
 	default y
 	select ARCH_OMAP_OTG
 
-config SOC_OMAPTI81XX
+config SOC_TI81XX
 	bool "TI81XX support"
 	depends on ARCH_OMAP3
 	default y
@@ -319,12 +319,12 @@ config MACH_OMAP_3630SDP
 
 config MACH_TI8168EVM
 	bool "TI8168 Evaluation Module"
-	depends on SOC_OMAPTI81XX
+	depends on SOC_TI81XX
 	default y
 
 config MACH_TI8148EVM
 	bool "TI8148 Evaluation Module"
-	depends on SOC_OMAPTI81XX
+	depends on SOC_TI81XX
 	default y
 
 config MACH_OMAP_4430SDP
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 57da7f4..bc0b571 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -54,7 +54,7 @@ static inline void omap34xx_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_OMAPTI81XX
+#ifdef CONFIG_SOC_TI81XX
 extern void omapti81xx_map_common_io(void);
 #else
 static inline void omapti81xx_map_common_io(void)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 595a5dd..23063a2 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -172,7 +172,7 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 };
 #endif
 
-#ifdef CONFIG_SOC_OMAPTI81XX
+#ifdef CONFIG_SOC_TI81XX
 static struct map_desc omapti81xx_io_desc[] __initdata = {
 	{
 		.virtual	= L4_34XX_VIRT,
@@ -255,7 +255,7 @@ void __init omap34xx_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_OMAPTI81XX
+#ifdef CONFIG_SOC_TI81XX
 void __init omapti81xx_map_common_io(void)
 {
 	iotable_init(omapti81xx_io_desc, ARRAY_SIZE(omapti81xx_io_desc));
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index a5da010..8c552d6 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -231,7 +231,7 @@ static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs
 			goto out;
 
 		irqnr = readl_relaxed(base_addr + 0xd8);
-#ifdef CONFIG_SOC_OMAPTI81XX
+#ifdef CONFIG_SOC_TI81XX
 		if (irqnr)
 			goto out;
 		irqnr = readl_relaxed(base_addr + 0xf8);
-- 
1.7.9.2
