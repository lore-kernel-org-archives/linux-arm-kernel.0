From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:18 -0500
Subject: [RFC PATCH 04/10] mx51: remove unused static mappings
Message-ID: <1271446524-26450-5-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rob Herring <r.herring@freescale.com>
---
 arch/arm/mach-mx5/mm.c                |   20 -----------------
 arch/arm/plat-mxc/include/mach/mx51.h |   38 +++++++-------------------------
 2 files changed, 9 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 9c9ae3b..fedacac 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -26,30 +26,10 @@
  */
 static struct map_desc mxc_io_desc[] __initdata = {
 	{
-		.virtual = MX51_IRAM_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_IRAM_BASE_ADDR),
-		.length = MX51_IRAM_SIZE,
-		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_DEBUG_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_DEBUG_BASE_ADDR),
-		.length = MX51_DEBUG_SIZE,
-		.type = MT_DEVICE
-	}, {
 		.virtual = MX51_AIPS1_BASE_ADDR_VIRT,
 		.pfn = __phys_to_pfn(MX51_AIPS1_BASE_ADDR),
 		.length = MX51_AIPS1_SIZE,
 		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_SPBA0_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_SPBA0_BASE_ADDR),
-		.length = MX51_SPBA0_SIZE,
-		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_AIPS2_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_AIPS2_BASE_ADDR),
-		.length = MX51_AIPS2_SIZE,
-		.type = MT_DEVICE
 	},
 };
 
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 5aad344..b83963f 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -7,14 +7,14 @@
  *
  * Virt		Phys		Size	What
  * ---------------------------------------------------------------------------
- * FA3E0000	1FFE0000	128K	IRAM (SCCv2 RAM)
+ *         	1FFE0000	128K	IRAM (SCCv2 RAM)
  *         	30000000	256M	GPU
  *         	40000000	512M	IPU
- * FA200000	60000000	1M	DEBUG
- * FB100000	70000000	1M	SPBA 0
- * FB000000	73F00000	1M	AIPS 1
- * FB200000	83F00000	1M	AIPS 2
- *		8FFFC000	16K	TZIC (interrupt controller)
+ *         	60000000	1M	DEBUG
+ *         	70000000	1M	SPBA 0
+ * F7D00000	73F00000	1M	AIPS 1
+ *         	83F00000	1M	AIPS 2
+ *         	8FFFC000	16K	TZIC (interrupt controller)
  *         	90000000	256M	CSD0 SDRAM/DDR
  *         	A0000000	256M	CSD1 SDRAM/DDR
  *         	B0000000	128M	CS0 Flash
@@ -37,7 +37,6 @@
  * IRAM
  */
 #define MX51_IRAM_BASE_ADDR		0x1FFE0000	/* internal ram */
-#define MX51_IRAM_BASE_ADDR_VIRT	0xFA3E0000
 #define MX51_IRAM_PARTITIONS		16
 #define MX51_IRAM_PARTITIONS_TO1	12
 #define MX51_IRAM_SIZE		(MX51_IRAM_PARTITIONS * SZ_8K)	/* 128KB */
@@ -58,8 +57,7 @@
 #define MX51_TZIC_BASE_ADDR		0xE0000000
 
 #define MX51_DEBUG_BASE_ADDR		0x60000000
-#define MX51_DEBUG_BASE_ADDR_VIRT	0xFA200000
-#define MX51_DEBUG_SIZE			SZ_1M
+#define MX51_DEBUG_SIZE			(36 * SZ_1K)
 #define MX51_ETB_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x00001000)
 #define MX51_ETM_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x00002000)
 #define MX51_TPIU_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x00003000)
@@ -73,7 +71,6 @@
  * SPBA global module enabled #0
  */
 #define MX51_SPBA0_BASE_ADDR 		0x70000000
-#define MX51_SPBA0_BASE_ADDR_VIRT	0xFB100000
 #define MX51_SPBA0_SIZE			SZ_1M
 
 #define MX51_MMC_SDHC1_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x00004000)
@@ -109,7 +106,7 @@
  * AIPS 1
  */
 #define MX51_AIPS1_BASE_ADDR 	0x73F00000
-#define MX51_AIPS1_BASE_ADDR_VIRT	0xFB000000
+#define MX51_AIPS1_BASE_ADDR_VIRT	0xF7D00000
 #define MX51_AIPS1_SIZE		SZ_1M
 
 #define MX51_OTG_BASE_ADDR	(MX51_AIPS1_BASE_ADDR + 0x00080000)
@@ -168,7 +165,6 @@
  * AIPS 2
  */
 #define MX51_AIPS2_BASE_ADDR		0x83F00000
-#define MX51_AIPS2_BASE_ADDR_VIRT	0xFB200000
 #define MX51_AIPS2_SIZE			SZ_1M
 
 #define MX51_PLL1_BASE_ADDR	(MX51_AIPS2_BASE_ADDR + 0x00080000)
@@ -235,31 +231,15 @@
 
 #define MX51_IO_ADDRESS(x)					\
 	(void __iomem *)					\
-	(MX51_IS_MODULE(x, IRAM) ? MX51_IRAM_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, DEBUG) ? MX51_DEBUG_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, SPBA0) ? MX51_SPBA0_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, AIPS1) ? MX51_AIPS1_IO_ADDRESS(x) :	\
-	MX51_IS_MODULE(x, AIPS2) ? MX51_AIPS2_IO_ADDRESS(x) : \
+	(MX51_IS_MODULE(x, AIPS1) ? MX51_AIPS1_IO_ADDRESS(x) :	\
 	0xDEADBEEF)
 
 /*
  * define the address mapping macros: in physical address order
  */
-#define MX51_IRAM_IO_ADDRESS(x)  \
-	(((x) - MX51_IRAM_BASE_ADDR) + MX51_IRAM_BASE_ADDR_VIRT)
-
-#define MX51_DEBUG_IO_ADDRESS(x)  \
-	(((x) - MX51_DEBUG_BASE_ADDR) + MX51_DEBUG_BASE_ADDR_VIRT)
-
-#define MX51_SPBA0_IO_ADDRESS(x)  \
-	(((x) - MX51_SPBA0_BASE_ADDR) + MX51_SPBA0_BASE_ADDR_VIRT)
-
 #define MX51_AIPS1_IO_ADDRESS(x)  \
 	(((x) - MX51_AIPS1_BASE_ADDR) + MX51_AIPS1_BASE_ADDR_VIRT)
 
-#define MX51_AIPS2_IO_ADDRESS(x)  \
-	(((x) - MX51_AIPS2_BASE_ADDR) + MX51_AIPS2_BASE_ADDR_VIRT)
-
 #define MX51_IS_MEM_DEVICE_NONSHARED(x)		0
 
 /*
-- 
1.6.0.4
