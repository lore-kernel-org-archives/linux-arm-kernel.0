From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 11 Nov 2014 10:47:02 +0530
Subject: [PATCH] ARM: EXYNOS: Remove unused static iomapping
Message-ID: <1415683022-21771-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all unused static iomapping from
exynos4/5_iodesc table, and at the same time removes
related macros from map.h and map-s5p.h.
All such mappings are present in exynos.c but not currently
there are no users of these mappings, so its safe to remove these.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
This patch has been compiled tested for exynos_defconfig; multi_v7_defconfig;
s5pv210_defconfig; s3c6400_defconfig; and s3c2410_defconfig.

I have verified system booting on SMDK5250 and Exynos3250 based board.

 arch/arm/mach-exynos/exynos.c                |   50 --------------------------
 arch/arm/mach-exynos/include/mach/map.h      |   23 ------------
 arch/arm/plat-samsung/include/plat/map-s5p.h |   21 -----------
 3 files changed, 94 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a487e59..a36e4cf 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -41,41 +41,11 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S3C_VA_TIMER,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_TIMER),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_WATCHDOG),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_SROMC,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSTIMER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_COMBINER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_CPU),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_DIST),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_CMU,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
 		.length		= SZ_128K,
@@ -86,11 +56,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_8K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_L2CC,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_L2CC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_DMC0,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC0),
 		.length		= SZ_64K,
@@ -100,11 +65,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC1),
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_HSPHY),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
 	},
 };
 
@@ -115,16 +75,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S3C_VA_TIMER,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_TIMER),
-		.length		= SZ_16K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_WATCHDOG),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_SROMC,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_SROMC),
 		.length		= SZ_4K,
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index f0b7e92..1ad3f49 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -30,40 +30,17 @@
 #define EXYNOS4_PA_CMU			0x10030000
 #define EXYNOS5_PA_CMU			0x10010000
 
-#define EXYNOS4_PA_SYSTIMER		0x10050000
-
-#define EXYNOS4_PA_WATCHDOG		0x10060000
-#define EXYNOS5_PA_WATCHDOG		0x101D0000
-
 #define EXYNOS4_PA_DMC0			0x10400000
 #define EXYNOS4_PA_DMC1			0x10410000
 
-#define EXYNOS4_PA_COMBINER		0x10440000
-#define EXYNOS5_PA_COMBINER		0x10440000
-
-#define EXYNOS4_PA_GIC_CPU		0x10480000
-#define EXYNOS4_PA_GIC_DIST		0x10490000
-#define EXYNOS5_PA_GIC_CPU		0x10482000
-#define EXYNOS5_PA_GIC_DIST		0x10481000
-
 #define EXYNOS4_PA_COREPERI		0x10500000
 #define EXYNOS4_PA_L2CC			0x10502000
 
 #define EXYNOS4_PA_SROMC		0x12570000
 #define EXYNOS5_PA_SROMC		0x12250000
 
-#define EXYNOS4_PA_HSPHY		0x125B0000
-
-#define EXYNOS4_PA_UART			0x13800000
-#define EXYNOS5_PA_UART			0x12C00000
-
-#define EXYNOS4_PA_TIMER		0x139D0000
-#define EXYNOS5_PA_TIMER		0x12DD0000
-
 /* Compatibility UART */
 
 #define EXYNOS5440_PA_UART0		0x000B0000
 
-#define S3C_VA_UARTx(x)			(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
-
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index f5b9d3f..f5cf2bd 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -15,43 +15,22 @@
 
 #define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
 #define S5P_VA_CMU		S3C_ADDR(0x02100000)
-#define S5P_VA_GPIO		S3C_ADDR(0x02200000)
-#define S5P_VA_GPIO1		S5P_VA_GPIO
-#define S5P_VA_GPIO2		S3C_ADDR(0x02240000)
-#define S5P_VA_GPIO3		S3C_ADDR(0x02280000)
 
-#define S5P_VA_SYSRAM		S3C_ADDR(0x02400000)
-#define S5P_VA_SYSRAM_NS	S3C_ADDR(0x02410000)
 #define S5P_VA_DMC0		S3C_ADDR(0x02440000)
 #define S5P_VA_DMC1		S3C_ADDR(0x02480000)
 #define S5P_VA_SROMC		S3C_ADDR(0x024C0000)
 
-#define S5P_VA_SYSTIMER		S3C_ADDR(0x02500000)
-#define S5P_VA_L2CC		S3C_ADDR(0x02600000)
-
-#define S5P_VA_COMBINER_BASE	S3C_ADDR(0x02700000)
-#define S5P_VA_COMBINER(x)	(S5P_VA_COMBINER_BASE + ((x) >> 2) * 0x10)
-
 #define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
 #define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
 #define S5P_VA_TWD		S5P_VA_COREPERI(0x600)
 
-#define S5P_VA_GIC_CPU		S3C_ADDR(0x02810000)
-#define S5P_VA_GIC_DIST		S3C_ADDR(0x02820000)
-
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
 #define VA_VIC2			VA_VIC(2)
 #define VA_VIC3			VA_VIC(3)
 
-#define S5P_VA_UART(x)		(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
-#define S5P_VA_UART0		S5P_VA_UART(0)
-#define S5P_VA_UART1		S5P_VA_UART(1)
-#define S5P_VA_UART2		S5P_VA_UART(2)
-#define S5P_VA_UART3		S5P_VA_UART(3)
-
 #ifndef S3C_UART_OFFSET
 #define S3C_UART_OFFSET		(0x400)
 #endif
-- 
1.7.9.5
