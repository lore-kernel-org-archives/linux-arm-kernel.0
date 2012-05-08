From: khilman@ti.com (Kevin Hilman)
Date: Tue,  8 May 2012 15:02:56 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: Kconfig: convert SOC_OMAPAM33XX to SOC_AM33XX
In-Reply-To: <1336514576-4870-1-git-send-email-khilman@ti.com>
References: <1336514576-4870-1-git-send-email-khilman@ti.com>
Message-ID: <1336514576-4870-4-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to have an OMAP prefix on these SoCs that are in the family
but arent' really called OMAP.

Simple rename: CONFIG_SOC_OMAPAM33XX --> CONFIG_SOC_AM33XX

No functional change.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    2 +-
 arch/arm/mach-omap2/common.h |    2 +-
 arch/arm/mach-omap2/io.c     |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 7f89697..61bf3c3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -82,7 +82,7 @@ config SOC_TI81XX
 	depends on ARCH_OMAP3
 	default y
 
-config SOC_OMAPAM33XX
+config SOC_AM33XX
 	bool "AM33XX support"
 	depends on ARCH_OMAP3
 	default y
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index bc0b571..22825db 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -62,7 +62,7 @@ static inline void omapti81xx_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_OMAPAM33XX
+#ifdef CONFIG_SOC_AM33XX
 extern void omapam33xx_map_common_io(void);
 #else
 static inline void omapam33xx_map_common_io(void)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 23063a2..bafa592 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -183,7 +183,7 @@ static struct map_desc omapti81xx_io_desc[] __initdata = {
 };
 #endif
 
-#ifdef CONFIG_SOC_OMAPAM33XX
+#ifdef CONFIG_SOC_AM33XX
 static struct map_desc omapam33xx_io_desc[] __initdata = {
 	{
 		.virtual	= L4_34XX_VIRT,
@@ -262,7 +262,7 @@ void __init omapti81xx_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_SOC_OMAPAM33XX
+#ifdef CONFIG_SOC_AM33XX
 void __init omapam33xx_map_common_io(void)
 {
 	iotable_init(omapam33xx_io_desc, ARRAY_SIZE(omapam33xx_io_desc));
-- 
1.7.9.2
