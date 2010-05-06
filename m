From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:08 -0700
Subject: [PATCH 17/34] DaVinci: move AEMIF #define's to the proper headers
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-18-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Currently each DaVinci board file #define's its own version of the EMIFA base
addresses (all named DAVINCI_ASYNC_EMIF_*_BASE), which leads to duplication.
Move these #define's to the SoC specific headers, changing their prefixes from
'DAVINCI' to the 'DM355', 'DM644X', and 'DM646X' since all these base addresses
are SoC specific...

And while at it, rename DM646X_ASYNC_EMIF_DATA_CE0_BASE to
DM646X_ASYNC_EMIF_CS2_SPACE_BASE in order to match the DM646x datasheet.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |   11 ++++-------
 arch/arm/mach-davinci/board-dm355-leopard.c |   11 ++++-------
 arch/arm/mach-davinci/board-dm365-evm.c     |    5 -----
 arch/arm/mach-davinci/board-dm644x-evm.c    |   18 ++++++------------
 arch/arm/mach-davinci/board-dm646x-evm.c    |   11 ++++-------
 arch/arm/mach-davinci/board-neuros-osd2.c   |   11 ++++-------
 arch/arm/mach-davinci/board-sffsdr.c        |   11 ++++-------
 arch/arm/mach-davinci/include/mach/dm355.h  |    3 +++
 arch/arm/mach-davinci/include/mach/dm365.h  |    4 ++++
 arch/arm/mach-davinci/include/mach/dm644x.h |    6 ++++++
 arch/arm/mach-davinci/include/mach/dm646x.h |    3 +++
 11 files changed, 42 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index aa48e3f..a0ad7d9 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -33,9 +33,6 @@
 #include <mach/mmc.h>
 #include <mach/usb.h>
 
-#define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x01e10000
-#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-
 /* NOTE:  this is geared for the standard config, with a socketed
  * 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors.  If you
  * swap chips, maybe with a different block size, partitioning may
@@ -86,12 +83,12 @@ static struct davinci_nand_pdata davinci_nand_data = {
 
 static struct resource davinci_nand_resources[] = {
 	{
-		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_32M - 1,
+		.start		= DM355_ASYNC_EMIF_DATA_CE0_BASE,
+		.end		= DM355_ASYNC_EMIF_DATA_CE0_BASE + SZ_32M - 1,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= DAVINCI_ASYNC_EMIF_CONTROL_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.start		= DM355_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM355_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 };
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 21f32eb..c3d5a70 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -30,9 +30,6 @@
 #include <mach/mmc.h>
 #include <mach/usb.h>
 
-#define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x01e10000
-#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-
 /* NOTE:  this is geared for the standard config, with a socketed
  * 2 GByte Micron NAND (MT29F16G08FAA) using 128KB sectors.  If you
  * swap chips, maybe with a different block size, partitioning may
@@ -82,12 +79,12 @@ static struct davinci_nand_pdata davinci_nand_data = {
 
 static struct resource davinci_nand_resources[] = {
 	{
-		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_32M - 1,
+		.start		= DM355_ASYNC_EMIF_DATA_CE0_BASE,
+		.end		= DM355_ASYNC_EMIF_DATA_CE0_BASE + SZ_32M - 1,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= DAVINCI_ASYNC_EMIF_CONTROL_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.start		= DM355_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM355_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 };
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index df4ab21..b98b35c 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -54,11 +54,6 @@ static inline int have_tvp7002(void)
 	return 0;
 }
 
-
-#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01d10000
-#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000
-
 #define DM365_EVM_PHY_MASK		(0x2)
 #define DM365_EVM_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 95cef1f..d028bab 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -43,12 +43,6 @@
 
 #define DAVINCI_CFC_ATA_BASE		  0x01C66000
 
-#define DAVINCI_ASYNC_EMIF_CONTROL_BASE   0x01e00000
-#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE  0x02000000
-#define DAVINCI_ASYNC_EMIF_DATA_CE1_BASE  0x04000000
-#define DAVINCI_ASYNC_EMIF_DATA_CE2_BASE  0x06000000
-#define DAVINCI_ASYNC_EMIF_DATA_CE3_BASE  0x08000000
-
 #define LXT971_PHY_ID	(0x001378e2)
 #define LXT971_PHY_MASK	(0xfffffff0)
 
@@ -92,8 +86,8 @@ static struct physmap_flash_data davinci_evm_norflash_data = {
 /* NOTE: CFI probe will correctly detect flash part as 32M, but EMIF
  * limits addresses to 16M, so using addresses past 16M will wrap */
 static struct resource davinci_evm_norflash_resource = {
-	.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
-	.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
+	.start		= DM644X_ASYNC_EMIF_DATA_CE0_BASE,
+	.end		= DM644X_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
@@ -154,12 +148,12 @@ static struct davinci_nand_pdata davinci_evm_nandflash_data = {
 
 static struct resource davinci_evm_nandflash_resource[] = {
 	{
-		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
+		.start		= DM644X_ASYNC_EMIF_DATA_CE0_BASE,
+		.end		= DM644X_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= DAVINCI_ASYNC_EMIF_CONTROL_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.start		= DM644X_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM644X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 };
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 5ba3cb2..b22e22c 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -80,17 +80,14 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.options		= 0,
 };
 
-#define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x20008000
-#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x42000000
-
 static struct resource davinci_nand_resources[] = {
 	{
-		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_32M - 1,
+		.start		= DM646X_ASYNC_EMIF_CS2_SPACE_BASE,
+		.end		= DM646X_ASYNC_EMIF_CS2_SPACE_BASE + SZ_32M - 1,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= DAVINCI_ASYNC_EMIF_CONTROL_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.start		= DM646X_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM646X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 };
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 1fadc68..5afe37e 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -43,9 +43,6 @@
 
 #define DAVINCI_CFC_ATA_BASE		 0x01C66000
 
-#define DAVINCI_ASYNC_EMIF_CONTROL_BASE	 0x01e00000
-#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
-
 #define LXT971_PHY_ID			0x001378e2
 #define LXT971_PHY_MASK			0xfffffff0
 
@@ -98,12 +95,12 @@ static struct davinci_nand_pdata davinci_ntosd2_nandflash_data = {
 
 static struct resource davinci_ntosd2_nandflash_resource[] = {
 	{
-		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
+		.start		= DM644X_ASYNC_EMIF_DATA_CE0_BASE,
+		.end		= DM644X_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= DAVINCI_ASYNC_EMIF_CONTROL_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.start		= DM644X_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM644X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 };
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index a7cf810..1ed0662 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -45,9 +45,6 @@
 #define SFFSDR_PHY_MASK		(0x2)
 #define SFFSDR_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
 
-#define DAVINCI_ASYNC_EMIF_CONTROL_BASE   0x01e00000
-#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE  0x02000000
-
 static struct mtd_partition davinci_sffsdr_nandflash_partition[] = {
 	/* U-Boot Environment: Block 0
 	 * UBL:                Block 1
@@ -76,12 +73,12 @@ static struct flash_platform_data davinci_sffsdr_nandflash_data = {
 
 static struct resource davinci_sffsdr_nandflash_resource[] = {
 	{
-		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
+		.start		= DM644X_ASYNC_EMIF_DATA_CE0_BASE,
+		.end		= DM644X_ASYNC_EMIF_DATA_CE0_BASE + SZ_16M - 1,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= DAVINCI_ASYNC_EMIF_CONTROL_BASE,
-		.end		= DAVINCI_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.start		= DM644X_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DM644X_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
 		.flags		= IORESOURCE_MEM,
 	},
 };
diff --git a/arch/arm/mach-davinci/include/mach/dm355.h b/arch/arm/mach-davinci/include/mach/dm355.h
index 85536d8..36dff4a 100644
--- a/arch/arm/mach-davinci/include/mach/dm355.h
+++ b/arch/arm/mach-davinci/include/mach/dm355.h
@@ -15,6 +15,9 @@
 #include <mach/asp.h>
 #include <media/davinci/vpfe_capture.h>
 
+#define DM355_ASYNC_EMIF_CONTROL_BASE	0x01E10000
+#define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
+
 #define ASP1_TX_EVT_EN	1
 #define ASP1_RX_EVT_EN	2
 
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 3a37b5a..ea5df3b 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -36,6 +36,10 @@
 #define DAVINCI_DMA_VC_TX		2
 #define DAVINCI_DMA_VC_RX		3
 
+#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01D10000
+#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
+#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000
+
 void __init dm365_init(void);
 void __init dm365_init_asp(struct snd_platform_data *pdata);
 void __init dm365_init_vc(struct snd_platform_data *pdata);
diff --git a/arch/arm/mach-davinci/include/mach/dm644x.h b/arch/arm/mach-davinci/include/mach/dm644x.h
index 1a8b09c..6fca568 100644
--- a/arch/arm/mach-davinci/include/mach/dm644x.h
+++ b/arch/arm/mach-davinci/include/mach/dm644x.h
@@ -34,6 +34,12 @@
 #define DM644X_EMAC_MDIO_OFFSET		(0x4000)
 #define DM644X_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
+#define DM644X_ASYNC_EMIF_CONTROL_BASE	0x01E00000
+#define DM644X_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
+#define DM644X_ASYNC_EMIF_DATA_CE1_BASE 0x04000000
+#define DM644X_ASYNC_EMIF_DATA_CE2_BASE 0x06000000
+#define DM644X_ASYNC_EMIF_DATA_CE3_BASE 0x08000000
+
 void __init dm644x_init(void);
 void __init dm644x_init_asp(struct snd_platform_data *pdata);
 void dm644x_set_vpfe_config(struct vpfe_config *cfg);
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 846da98..4d62db7 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -27,6 +27,9 @@
 
 #define DM646X_ATA_REG_BASE		(0x01C66000)
 
+#define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
+#define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
+
 void __init dm646x_init(void);
 void __init dm646x_init_ide(void);
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
-- 
1.7.0.2
