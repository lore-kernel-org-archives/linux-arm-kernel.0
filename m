From: akshay.s@ti.com (Shankarmurthy, Akshay)
Date: Thu, 8 Dec 2011 14:35:51 +0530
Subject: [PATCH] ARM: davinci: add missing commas on last members of structure
 and arrays
Message-ID: <1323335151-25398-1-git-send-email-akshay.s@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing commas on last members of structure and arrays.
This makes less harder to add additional initializer at the end of the
existing initializers and avoids the conflict of more line being
modified. This was pointed out by Russell King in his pet peeves mail at
http://www.spinics.net/lists/arm-kernel/msg147268.html.

Signed-off-by: Shankarmurthy, Akshay <akshay.s@ti.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |    6 +++---
 arch/arm/mach-davinci/board-da850-evm.c     |    6 +++---
 arch/arm/mach-davinci/board-dm355-evm.c     |    6 +++---
 arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |    6 +++---
 arch/arm/mach-davinci/board-dm644x-evm.c    |   10 +++++-----
 arch/arm/mach-davinci/board-dm646x-evm.c    |    4 ++--
 arch/arm/mach-davinci/board-neuros-osd2.c   |    4 ++--
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    4 ++--
 arch/arm/mach-davinci/da830.c               |    4 ++--
 arch/arm/mach-davinci/da850.c               |    6 +++---
 arch/arm/mach-davinci/devices-tnetv107x.c   |   24 ++++++++++++------------
 arch/arm/mach-davinci/dm355.c               |    8 ++++----
 arch/arm/mach-davinci/dm365.c               |    6 +++---
 arch/arm/mach-davinci/dm644x.c              |    8 ++++----
 arch/arm/mach-davinci/dm646x.c              |    6 +++---
 arch/arm/mach-davinci/tnetv107x.c           |    8 ++++----
 17 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 26d94c0..9a5074e 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -333,7 +333,7 @@ static struct mtd_partition da830_evm_nand_partitions[] = {
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= MTDPART_SIZ_FULL,
 		.mask_flags	= 0,
-	}
+	},
 };
 
 /* flash bbt decriptors */
@@ -348,7 +348,7 @@ static struct nand_bbt_descr da830_evm_nand_bbt_main_descr = {
 	.len		= 4,
 	.veroffs	= 16,
 	.maxblocks	= 4,
-	.pattern	= da830_evm_nand_bbt_pattern
+	.pattern	= da830_evm_nand_bbt_pattern,
 };
 
 static struct nand_bbt_descr da830_evm_nand_bbt_mirror_descr = {
@@ -359,7 +359,7 @@ static struct nand_bbt_descr da830_evm_nand_bbt_mirror_descr = {
 	.len		= 4,
 	.veroffs	= 16,
 	.maxblocks	= 4,
-	.pattern	= da830_evm_nand_mirror_pattern
+	.pattern	= da830_evm_nand_mirror_pattern,
 };
 
 static struct davinci_aemif_timing da830_evm_nandflash_timing = {
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index ec21663..9d97a17 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -545,7 +545,7 @@ enum da850_evm_bb_exp_pins {
 	DA850_EVM_BB_EXP_USER_SW5,
 	DA850_EVM_BB_EXP_USER_SW6,
 	DA850_EVM_BB_EXP_USER_SW7,
-	DA850_EVM_BB_EXP_USER_SW8
+	DA850_EVM_BB_EXP_USER_SW8,
 };
 
 static const char const *da850_evm_bb_exp[] = {
@@ -642,8 +642,8 @@ static struct platform_device da850_evm_bb_leds_device = {
 	.name		= "leds-gpio",
 	.id		= -1,
 	.dev = {
-		.platform_data = &da850_evm_bb_leds_pdata
-	}
+		.platform_data = &da850_evm_bb_leds_pdata,
+	},
 };
 
 static void da850_evm_bb_leds_init(unsigned gpio)
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 6556628..d1c17ad 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -68,7 +68,7 @@ static struct mtd_partition davinci_nand_partitions[] = {
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= MTDPART_SIZ_FULL,
 		.mask_flags	= 0,
-	}
+	},
 	/* two blocks with bad block table (and mirror) at the end */
 };
 
@@ -177,7 +177,7 @@ static struct platform_device dm355evm_dm9000 = {
 static struct tvp514x_platform_data tvp5146_pdata = {
 	.clk_polarity = 0,
 	.hs_polarity = 1,
-	.vs_polarity = 1
+	.vs_polarity = 1,
 };
 
 #define TVP514X_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
@@ -230,7 +230,7 @@ static struct vpfe_subdev_info vpfe_sub_devs[] = {
 			I2C_BOARD_INFO("tvp5146", 0x5d),
 			.platform_data = &tvp5146_pdata,
 		},
-	}
+	},
 };
 
 static struct vpfe_config vpfe_cfg = {
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index b307470..dc8880f 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -65,7 +65,7 @@ static struct mtd_partition davinci_nand_partitions[] = {
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= MTDPART_SIZ_FULL,
 		.mask_flags	= 0,
-	}
+	},
 	/* two blocks with bad block table (and mirror) at the end */
 };
 
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 04c43ab..4706f81 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -130,7 +130,7 @@ static struct mtd_partition davinci_nand_partitions[] = {
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= MTDPART_SIZ_FULL,
 		.mask_flags	= 0,
-	}
+	},
 	/* two blocks with bad block table (and mirror) at the end */
 };
 
@@ -214,7 +214,7 @@ static unsigned short dm365evm_keymap[] = {
 	KEY_FASTFORWARD,
 	KEY_KPPLUS,
 	KEY_PLAYPAUSE,
-	0
+	0,
 };
 
 static struct davinci_ks_platform_data dm365evm_ks_data = {
@@ -309,7 +309,7 @@ static void dm365evm_mmc_configure(void)
 static struct tvp514x_platform_data tvp5146_pdata = {
 	.clk_polarity = 0,
 	.hs_polarity = 1,
-	.vs_polarity = 1
+	.vs_polarity = 1,
 };
 
 #define TVP514X_STD_ALL        (V4L2_STD_NTSC | V4L2_STD_PAL)
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 28fafa7..c7c0fb7 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -64,15 +64,15 @@ static struct mtd_partition davinci_evm_norflash_partitions[] = {
 		.name		= "kernel",
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= SZ_2M,
-		.mask_flags	= 0
+		.mask_flags	= 0,
 	},
 	/* file system */
 	{
 		.name		= "filesystem",
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= MTDPART_SIZ_FULL,
-		.mask_flags	= 0
-	}
+		.mask_flags	= 0,
+	},
 };
 
 static struct physmap_flash_data davinci_evm_norflash_data = {
@@ -192,7 +192,7 @@ static struct platform_device davinci_fb_device = {
 static struct tvp514x_platform_data tvp5146_pdata = {
 	.clk_polarity = 0,
 	.hs_polarity = 1,
-	.vs_polarity = 1
+	.vs_polarity = 1,
 };
 
 #define TVP514X_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
@@ -567,7 +567,7 @@ static struct davinci_mmc_config dm6446evm_mmc_config = {
 	.get_cd		= dm6444evm_mmc_get_cd,
 	.get_ro		= dm6444evm_mmc_get_ro,
 	.wires		= 4,
-	.version	= MMC_CTLR_VERSION_1
+	.version	= MMC_CTLR_VERSION_1,
 };
 
 static struct i2c_board_info __initdata i2c_info[] =  {
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index e574d7f..7cbb2ae 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -70,7 +70,7 @@ static struct mtd_partition davinci_nand_partitions[] = {
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= MTDPART_SIZ_FULL,
 		.mask_flags	= 0,
-	}
+	},
 };
 
 static struct davinci_aemif_timing dm6467tevm_nandflash_timing = {
@@ -593,7 +593,7 @@ static int setup_vpif_input_channel_mode(int mux_mode)
 static struct tvp514x_platform_data tvp5146_pdata = {
 	.clk_polarity = 0,
 	.hs_polarity = 1,
-	.vs_polarity = 1
+	.vs_polarity = 1,
 };
 
 #define TVP514X_STD_ALL (V4L2_STD_NTSC | V4L2_STD_PAL)
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 38d6f64..717ea1d 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -79,7 +79,7 @@ static struct mtd_partition davinci_ntosd2_nandflash_partition[] = {
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= MTDPART_SIZ_FULL,
 		.mask_flags	= 0,
-	}
+	},
 	/* A few blocks at end hold a flash Bad Block Table. */
 };
 
@@ -195,7 +195,7 @@ static	int ntosd2_init_i2c(void)
 
 static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
-	.version	= MMC_CTLR_VERSION_1
+	.version	= MMC_CTLR_VERSION_1,
 };
 
 
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 90ee7b5..d111a90 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -104,7 +104,7 @@ static const short uart1_pins[] __initdata = {
 static const short ssp_pins[] __initdata = {
 	TNETV107X_SSP0_0, TNETV107X_SSP0_1, TNETV107X_SSP0_2,
 	TNETV107X_SSP1_0, TNETV107X_SSP1_1, TNETV107X_SSP1_2,
-	TNETV107X_SSP1_3, -1
+	TNETV107X_SSP1_3, -1,
 };
 
 static struct mtd_partition nand_partitions[] = {
@@ -135,7 +135,7 @@ static struct mtd_partition nand_partitions[] = {
 		.offset		= MTDPART_OFS_NXTBLK,
 		.size		= MTDPART_SIZ_FULL,
 		.mask_flags	= 0,
-	}
+	},
 };
 
 static struct davinci_nand_pdata nand_config = {
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index a6bf5dc..115d836 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1113,13 +1113,13 @@ static struct map_desc da830_io_desc[] = {
 		.virtual	= IO_VIRT,
 		.pfn		= __phys_to_pfn(IO_PHYS),
 		.length		= IO_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{
 		.virtual	= DA8XX_CP_INTC_VIRT,
 		.pfn		= __phys_to_pfn(DA8XX_CP_INTC_BASE),
 		.length		= DA8XX_CP_INTC_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b047f87..bc6f769 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -737,19 +737,19 @@ static struct map_desc da850_io_desc[] = {
 		.virtual	= IO_VIRT,
 		.pfn		= __phys_to_pfn(IO_PHYS),
 		.length		= IO_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{
 		.virtual	= DA8XX_CP_INTC_VIRT,
 		.pfn		= __phys_to_pfn(DA8XX_CP_INTC_BASE),
 		.length		= DA8XX_CP_INTC_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(DA8XX_ARM_RAM_BASE),
 		.length		= SZ_8K,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 29b17f7..b3f55c2 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -169,23 +169,23 @@ static struct resource mmc0_resources[] = {
 	{ /* Memory mapped registers */
 		.start	= TNETV107X_SDIO0_BASE,
 		.end	= TNETV107X_SDIO0_BASE + 0x0ff,
-		.flags	= IORESOURCE_MEM
+		.flags	= IORESOURCE_MEM,
 	},
 	{ /* MMC interrupt */
 		.start	= IRQ_TNETV107X_MMC0,
-		.flags	= IORESOURCE_IRQ
+		.flags	= IORESOURCE_IRQ,
 	},
 	{ /* SDIO interrupt */
 		.start	= IRQ_TNETV107X_SDIO0,
-		.flags	= IORESOURCE_IRQ
+		.flags	= IORESOURCE_IRQ,
 	},
 	{ /* DMA RX */
 		.start	= EDMA_CTLR_CHAN(0, TNETV107X_DMACH_SDIO0_RX),
-		.flags	= IORESOURCE_DMA
+		.flags	= IORESOURCE_DMA,
 	},
 	{ /* DMA TX */
 		.start	= EDMA_CTLR_CHAN(0, TNETV107X_DMACH_SDIO0_TX),
-		.flags	= IORESOURCE_DMA
+		.flags	= IORESOURCE_DMA,
 	},
 };
 
@@ -193,23 +193,23 @@ static struct resource mmc1_resources[] = {
 	{ /* Memory mapped registers */
 		.start	= TNETV107X_SDIO1_BASE,
 		.end	= TNETV107X_SDIO1_BASE + 0x0ff,
-		.flags	= IORESOURCE_MEM
+		.flags	= IORESOURCE_MEM,
 	},
 	{ /* MMC interrupt */
 		.start	= IRQ_TNETV107X_MMC1,
-		.flags	= IORESOURCE_IRQ
+		.flags	= IORESOURCE_IRQ,
 	},
 	{ /* SDIO interrupt */
 		.start	= IRQ_TNETV107X_SDIO1,
-		.flags	= IORESOURCE_IRQ
+		.flags	= IORESOURCE_IRQ,
 	},
 	{ /* DMA RX */
 		.start	= EDMA_CTLR_CHAN(0, TNETV107X_DMACH_SDIO1_RX),
-		.flags	= IORESOURCE_DMA
+		.flags	= IORESOURCE_DMA,
 	},
 	{ /* DMA TX */
 		.start	= EDMA_CTLR_CHAN(0, TNETV107X_DMACH_SDIO1_TX),
-		.flags	= IORESOURCE_DMA
+		.flags	= IORESOURCE_DMA,
 	},
 };
 
@@ -225,7 +225,7 @@ static struct platform_device mmc_devices[2] = {
 			.coherent_dma_mask	= DMA_BIT_MASK(32),
 		},
 		.num_resources	= ARRAY_SIZE(mmc0_resources),
-		.resource	= mmc0_resources
+		.resource	= mmc0_resources,
 	},
 	{
 		.name		= "davinci_mmc",
@@ -235,7 +235,7 @@ static struct platform_device mmc_devices[2] = {
 			.coherent_dma_mask	= DMA_BIT_MASK(32),
 		},
 		.num_resources	= ARRAY_SIZE(mmc1_resources),
-		.resource	= mmc1_resources
+		.resource	= mmc1_resources,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index fe520d4..607a96f 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -104,7 +104,7 @@ static struct clk pll1_sysclkbp = {
 	.name = "pll1_sysclkbp",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
+	.div_reg = BPDIV,
 };
 
 static struct clk vpss_dac_clk = {
@@ -155,7 +155,7 @@ static struct clk pll2_sysclkbp = {
 	.name = "pll2_sysclkbp",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
+	.div_reg = BPDIV,
 };
 
 static struct clk clkout3_clk = {
@@ -756,7 +756,7 @@ static struct map_desc dm355_io_desc[] = {
 		.virtual	= IO_VIRT,
 		.pfn		= __phys_to_pfn(IO_PHYS),
 		.length		= IO_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{
 		.virtual	= SRAM_VIRT,
@@ -817,7 +817,7 @@ static struct plat_serial8250_port dm355_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
-		.flags		= 0
+		.flags		= 0,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 679e168..f63e055 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -74,7 +74,7 @@ static struct clk pll1_sysclkbp = {
 	.name		= "pll1_sysclkbp",
 	.parent		= &pll1_clk,
 	.flags 		= CLK_PLL | PRE_PLL,
-	.div_reg	= BPDIV
+	.div_reg	= BPDIV,
 };
 
 static struct clk clkout0_clk = {
@@ -967,7 +967,7 @@ static struct map_desc dm365_io_desc[] = {
 		.virtual	= IO_VIRT,
 		.pfn		= __phys_to_pfn(IO_PHYS),
 		.length		= IO_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{
 		.virtual	= SRAM_VIRT,
@@ -1045,7 +1045,7 @@ static struct plat_serial8250_port dm365_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
-		.flags		= 0
+		.flags		= 0,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 3470983..b8e016e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -95,7 +95,7 @@ static struct clk pll1_sysclkbp = {
 	.name = "pll1_sysclkbp",
 	.parent = &pll1_clk,
 	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
+	.div_reg = BPDIV,
 };
 
 static struct clk pll2_clk = {
@@ -123,7 +123,7 @@ static struct clk pll2_sysclkbp = {
 	.name = "pll2_sysclkbp",
 	.parent = &pll2_clk,
 	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
+	.div_reg = BPDIV,
 };
 
 static struct clk dsp_clk = {
@@ -662,7 +662,7 @@ static struct map_desc dm644x_io_desc[] = {
 		.virtual	= IO_VIRT,
 		.pfn		= __phys_to_pfn(IO_PHYS),
 		.length		= IO_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{
 		.virtual	= SRAM_VIRT,
@@ -730,7 +730,7 @@ static struct plat_serial8250_port dm644x_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
-		.flags		= 0
+		.flags		= 0,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 0b68ed5..86fe054 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -681,7 +681,7 @@ static struct resource vpif_resource[] = {
 		.start	= DAVINCI_VPIF_BASE,
 		.end	= DAVINCI_VPIF_BASE + 0x03ff,
 		.flags	= IORESOURCE_MEM,
-	}
+	},
 };
 
 static struct platform_device vpif_dev = {
@@ -750,7 +750,7 @@ static struct map_desc dm646x_io_desc[] = {
 		.virtual	= IO_VIRT,
 		.pfn		= __phys_to_pfn(IO_PHYS),
 		.length		= IO_SIZE,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{
 		.virtual	= SRAM_VIRT,
@@ -818,7 +818,7 @@ static struct plat_serial8250_port dm646x_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
-		.flags		= 0
+		.flags		= 0,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 409bb86..3a31d2c 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -101,11 +101,11 @@ static u32 bypass_mask[N_PLLS] = { BIT(0), BIT(2), BIT(1) };
 static u32 pll_ext_freq[] = {
 	OSC_FREQ_OFFCHIP_SYS,
 	OSC_FREQ_OFFCHIP_TDM,
-	OSC_FREQ_OFFCHIP_ETH
+	OSC_FREQ_OFFCHIP_ETH,
 };
 
 /* PSC control registers */
-static u32 psc_regs[] = { TNETV107X_PSC_BASE };
+static u32 psc_regs[] = { TNETV107X_PSC_BASE, };
 
 /* Host map for interrupt controller */
 static u32 intc_host_map[] = { 0x01010000, 0x01010101, -1 };
@@ -634,13 +634,13 @@ static struct map_desc io_desc[] = {
 		.virtual	= IO_VIRT,
 		.pfn		= __phys_to_pfn(TNETV107X_INTC_BASE),
 		.length		= SZ_16K,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 	{	/* Most of the rest */
 		.virtual	= TNETV107X_IO_VIRT,
 		.pfn		= __phys_to_pfn(TNETV107X_IO_BASE),
 		.length		= IO_SIZE - SZ_1M,
-		.type		= MT_DEVICE
+		.type		= MT_DEVICE,
 	},
 };
 
-- 
1.7.1
