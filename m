From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:25:09 -0600
Subject: [PATCH 5/7] ARM: tegra: remove much of iomap.h
In-Reply-To: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1379096711-26875-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

iomap.h defines the base address of Tegra peripherals. Most of this
information comes from device tree now, and hence can be deleted.
Entries are kept for various system peripherals that low-level code
(such as initial boot, system suspend/resume, debug) still requires.

Removing the values removes the temptation for someone to use them.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/iomap.h | 150 --------------------------------------------
 1 file changed, 150 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 7e0c180..cbee57f 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -24,42 +24,12 @@
 #define TEGRA_IRAM_BASE			0x40000000
 #define TEGRA_IRAM_SIZE			SZ_256K
 
-#define TEGRA_HOST1X_BASE		0x50000000
-#define TEGRA_HOST1X_SIZE		0x24000
-
 #define TEGRA_ARM_PERIF_BASE		0x50040000
 #define TEGRA_ARM_PERIF_SIZE		SZ_8K
 
-#define TEGRA_ARM_PL310_BASE		0x50043000
-#define TEGRA_ARM_PL310_SIZE		SZ_4K
-
 #define TEGRA_ARM_INT_DIST_BASE		0x50041000
 #define TEGRA_ARM_INT_DIST_SIZE		SZ_4K
 
-#define TEGRA_MPE_BASE			0x54040000
-#define TEGRA_MPE_SIZE			SZ_256K
-
-#define TEGRA_VI_BASE			0x54080000
-#define TEGRA_VI_SIZE			SZ_256K
-
-#define TEGRA_ISP_BASE			0x54100000
-#define TEGRA_ISP_SIZE			SZ_256K
-
-#define TEGRA_DISPLAY_BASE		0x54200000
-#define TEGRA_DISPLAY_SIZE		SZ_256K
-
-#define TEGRA_DISPLAY2_BASE		0x54240000
-#define TEGRA_DISPLAY2_SIZE		SZ_256K
-
-#define TEGRA_HDMI_BASE			0x54280000
-#define TEGRA_HDMI_SIZE			SZ_256K
-
-#define TEGRA_GART_BASE			0x58000000
-#define TEGRA_GART_SIZE			SZ_32M
-
-#define TEGRA_RES_SEMA_BASE		0x60001000
-#define TEGRA_RES_SEMA_SIZE		SZ_4K
-
 #define TEGRA_PRIMARY_ICTLR_BASE	0x60004000
 #define TEGRA_PRIMARY_ICTLR_SIZE	SZ_64
 
@@ -96,51 +66,15 @@
 #define TEGRA_FLOW_CTRL_BASE		0x60007000
 #define TEGRA_FLOW_CTRL_SIZE		20
 
-#define TEGRA_AHB_DMA_BASE		0x60008000
-#define TEGRA_AHB_DMA_SIZE		SZ_4K
-
-#define TEGRA_AHB_DMA_CH0_BASE		0x60009000
-#define TEGRA_AHB_DMA_CH0_SIZE		32
-
-#define TEGRA_APB_DMA_BASE		0x6000A000
-#define TEGRA_APB_DMA_SIZE		SZ_4K
-
-#define TEGRA_APB_DMA_CH0_BASE		0x6000B000
-#define TEGRA_APB_DMA_CH0_SIZE		32
-
-#define TEGRA_AHB_GIZMO_BASE		0x6000C004
-#define TEGRA_AHB_GIZMO_SIZE		0x10C
-
 #define TEGRA_SB_BASE			0x6000C200
 #define TEGRA_SB_SIZE			256
 
-#define TEGRA_STATMON_BASE		0x6000C400
-#define TEGRA_STATMON_SIZE		SZ_1K
-
-#define TEGRA_GPIO_BASE			0x6000D000
-#define TEGRA_GPIO_SIZE			SZ_4K
-
 #define TEGRA_EXCEPTION_VECTORS_BASE    0x6000F000
 #define TEGRA_EXCEPTION_VECTORS_SIZE    SZ_4K
 
 #define TEGRA_APB_MISC_BASE		0x70000000
 #define TEGRA_APB_MISC_SIZE		SZ_4K
 
-#define TEGRA_APB_MISC_DAS_BASE		0x70000c00
-#define TEGRA_APB_MISC_DAS_SIZE		SZ_128
-
-#define TEGRA_AC97_BASE			0x70002000
-#define TEGRA_AC97_SIZE			SZ_512
-
-#define TEGRA_SPDIF_BASE		0x70002400
-#define TEGRA_SPDIF_SIZE		SZ_512
-
-#define TEGRA_I2S1_BASE			0x70002800
-#define TEGRA_I2S1_SIZE			SZ_256
-
-#define TEGRA_I2S2_BASE			0x70002A00
-#define TEGRA_I2S2_SIZE			SZ_256
-
 #define TEGRA_UARTA_BASE		0x70006000
 #define TEGRA_UARTA_SIZE		SZ_64
 
@@ -156,87 +90,15 @@
 #define TEGRA_UARTE_BASE		0x70006400
 #define TEGRA_UARTE_SIZE		SZ_256
 
-#define TEGRA_NAND_BASE			0x70008000
-#define TEGRA_NAND_SIZE			SZ_256
-
-#define TEGRA_HSMMC_BASE		0x70008500
-#define TEGRA_HSMMC_SIZE		SZ_256
-
-#define TEGRA_SNOR_BASE			0x70009000
-#define TEGRA_SNOR_SIZE			SZ_4K
-
-#define TEGRA_PWFM_BASE			0x7000A000
-#define TEGRA_PWFM_SIZE			SZ_256
-
-#define TEGRA_PWFM0_BASE		0x7000A000
-#define TEGRA_PWFM0_SIZE		4
-
-#define TEGRA_PWFM1_BASE		0x7000A010
-#define TEGRA_PWFM1_SIZE		4
-
-#define TEGRA_PWFM2_BASE		0x7000A020
-#define TEGRA_PWFM2_SIZE		4
-
-#define TEGRA_PWFM3_BASE		0x7000A030
-#define TEGRA_PWFM3_SIZE		4
-
-#define TEGRA_MIPI_BASE			0x7000B000
-#define TEGRA_MIPI_SIZE			SZ_256
-
-#define TEGRA_I2C_BASE			0x7000C000
-#define TEGRA_I2C_SIZE			SZ_256
-
-#define TEGRA_TWC_BASE			0x7000C100
-#define TEGRA_TWC_SIZE			SZ_256
-
-#define TEGRA_SPI_BASE			0x7000C380
-#define TEGRA_SPI_SIZE			48
-
-#define TEGRA_I2C2_BASE			0x7000C400
-#define TEGRA_I2C2_SIZE			SZ_256
-
-#define TEGRA_I2C3_BASE			0x7000C500
-#define TEGRA_I2C3_SIZE			SZ_256
-
-#define TEGRA_OWR_BASE			0x7000C600
-#define TEGRA_OWR_SIZE			80
-
-#define TEGRA_DVC_BASE			0x7000D000
-#define TEGRA_DVC_SIZE			SZ_512
-
-#define TEGRA_SPI1_BASE			0x7000D400
-#define TEGRA_SPI1_SIZE			SZ_512
-
-#define TEGRA_SPI2_BASE			0x7000D600
-#define TEGRA_SPI2_SIZE			SZ_512
-
-#define TEGRA_SPI3_BASE			0x7000D800
-#define TEGRA_SPI3_SIZE			SZ_512
-
-#define TEGRA_SPI4_BASE			0x7000DA00
-#define TEGRA_SPI4_SIZE			SZ_512
-
-#define TEGRA_RTC_BASE			0x7000E000
-#define TEGRA_RTC_SIZE			SZ_256
-
-#define TEGRA_KBC_BASE			0x7000E200
-#define TEGRA_KBC_SIZE			SZ_256
-
 #define TEGRA_PMC_BASE			0x7000E400
 #define TEGRA_PMC_SIZE			SZ_256
 
-#define TEGRA_MC_BASE			0x7000F000
-#define TEGRA_MC_SIZE			SZ_1K
-
 #define TEGRA_EMC_BASE			0x7000F400
 #define TEGRA_EMC_SIZE			SZ_1K
 
 #define TEGRA_FUSE_BASE			0x7000F800
 #define TEGRA_FUSE_SIZE			SZ_1K
 
-#define TEGRA_KFUSE_BASE		0x7000FC00
-#define TEGRA_KFUSE_SIZE		SZ_1K
-
 #define TEGRA_EMC0_BASE			0x7001A000
 #define TEGRA_EMC0_SIZE			SZ_2K
 
@@ -246,18 +108,6 @@
 #define TEGRA_CSITE_BASE		0x70040000
 #define TEGRA_CSITE_SIZE		SZ_256K
 
-#define TEGRA_SDMMC1_BASE		0xC8000000
-#define TEGRA_SDMMC1_SIZE		SZ_512
-
-#define TEGRA_SDMMC2_BASE		0xC8000200
-#define TEGRA_SDMMC2_SIZE		SZ_512
-
-#define TEGRA_SDMMC3_BASE		0xC8000400
-#define TEGRA_SDMMC3_SIZE		SZ_512
-
-#define TEGRA_SDMMC4_BASE		0xC8000600
-#define TEGRA_SDMMC4_SIZE		SZ_512
-
 /* On TEGRA, many peripherals are very closely packed in
  * two 256MB io windows (that actually only use about 64KB
  * at the start of each).
-- 
1.8.1.5
