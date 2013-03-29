From: mkl0301@gmail.com (Mac Lin)
Date: Fri, 29 Mar 2013 17:16:03 +0800
Subject: [PATCH 1/2] ARM: cns3xxx: remove unused virtual address and iotable
 defines
Message-ID: <CAK1hUK8T=O2ku70Hf5T1OB05iVVCkSJ6_e_t2iF+EkqptQ002g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From eb7223502ded6a8c6dda4da32b2f3ba636b08bf1 Mon Sep 17 00:00:00 2001
From: Mac Lin <mkl0301@gmail.com>
Date: Mon, 25 Mar 2013 17:24:19 +0800
Subject: [PATCH 1/2] ARM: cns3xxx: remove unused virtual address and
iotable defines

Remove unused virtual address and iotable defines.

Signed-off-by: Mac Lin <mkl0301@gmail.com>
---
 arch/arm/mach-cns3xxx/cns3xxx.h |   27 ---------------------------
 arch/arm/mach-cns3xxx/core.c    |   10 ----------
 2 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3xxx.h b/arch/arm/mach-cns3xxx/cns3xxx.h
index d7d3a8d..77b8093 100644
--- a/arch/arm/mach-cns3xxx/cns3xxx.h
+++ b/arch/arm/mach-cns3xxx/cns3xxx.h
@@ -20,22 +20,16 @@
 #define CNS3XXX_SPI_FLASH_BASE			0x60000000	/* SPI Serial Flash Memory */

 #define CNS3XXX_SWITCH_BASE			0x70000000	/* Switch and HNAT Control */
-#define CNS3XXX_SWITCH_BASE_VIRT		0xFFF00000

 #define CNS3XXX_PPE_BASE			0x70001000	/* HANT	*/
-#define CNS3XXX_PPE_BASE_VIRT			0xFFF50000

 #define CNS3XXX_EMBEDDED_SRAM_BASE		0x70002000	/* HANT Embedded SRAM */
-#define CNS3XXX_EMBEDDED_SRAM_BASE_VIRT		0xFFF60000

 #define CNS3XXX_SSP_BASE			0x71000000	/* Synchronous Serial Port -
SPI/PCM/I2C */
-#define CNS3XXX_SSP_BASE_VIRT			0xFFF01000

 #define CNS3XXX_DMC_BASE			0x72000000	/* DMC Control (DDR2 SDRAM) */
-#define CNS3XXX_DMC_BASE_VIRT			0xFFF02000

 #define CNS3XXX_SMC_BASE			0x73000000	/* SMC Control */
-#define CNS3XXX_SMC_BASE_VIRT			0xFFF03000

 #define SMC_MEMC_STATUS_OFFSET			0x000
 #define SMC_MEMIF_CFG_OFFSET			0x004
@@ -74,13 +68,10 @@
 #define SMC_PCELL_ID_3_OFFSET			0xFFC

 #define CNS3XXX_GPIOA_BASE			0x74000000	/* GPIO port A */
-#define CNS3XXX_GPIOA_BASE_VIRT			0xFFF04000

 #define CNS3XXX_GPIOB_BASE			0x74800000	/* GPIO port B */
-#define CNS3XXX_GPIOB_BASE_VIRT			0xFFF05000

 #define CNS3XXX_RTC_BASE			0x75000000	/* Real Time Clock */
-#define CNS3XXX_RTC_BASE_VIRT			0xFFF06000

 #define RTC_SEC_OFFSET				0x00
 #define RTC_MIN_OFFSET				0x04
@@ -112,22 +103,16 @@
 #define CNS3XXX_UART0_BASE_VIRT			0xFFF09000

 #define CNS3XXX_UART1_BASE			0x78400000	/* UART 1 */
-#define CNS3XXX_UART1_BASE_VIRT			0xFFF0A000

 #define CNS3XXX_UART2_BASE			0x78800000	/* UART 2 */
-#define CNS3XXX_UART2_BASE_VIRT			0xFFF0B000

 #define CNS3XXX_DMAC_BASE			0x79000000	/* Generic DMA Control */
-#define CNS3XXX_DMAC_BASE_VIRT			0xFFF0D000

 #define CNS3XXX_CORESIGHT_BASE			0x7A000000	/* CoreSight */
-#define CNS3XXX_CORESIGHT_BASE_VIRT		0xFFF0E000

 #define CNS3XXX_CRYPTO_BASE			0x7B000000	/* Crypto */
-#define CNS3XXX_CRYPTO_BASE_VIRT		0xFFF0F000

 #define CNS3XXX_I2S_BASE			0x7C000000	/* I2S */
-#define CNS3XXX_I2S_BASE_VIRT			0xFFF10000

 #define CNS3XXX_TIMER1_2_3_BASE			0x7C800000	/* Timer */
 #define CNS3XXX_TIMER1_2_3_BASE_VIRT		0xFFF10800
@@ -150,42 +135,31 @@
 #define TIMER_FREERUN_CONTROL_OFFSET		0x44

 #define CNS3XXX_HCIE_BASE			0x7D000000	/* HCIE Control */
-#define CNS3XXX_HCIE_BASE_VIRT			0xFFF30000

 #define CNS3XXX_RAID_BASE			0x7E000000	/* RAID Control */
-#define CNS3XXX_RAID_BASE_VIRT			0xFFF12000

 #define CNS3XXX_AXI_IXC_BASE			0x7F000000	/* AXI IXC */
-#define CNS3XXX_AXI_IXC_BASE_VIRT		0xFFF13000

 #define CNS3XXX_CLCD_BASE			0x80000000	/* LCD Control */
-#define CNS3XXX_CLCD_BASE_VIRT			0xFFF14000

 #define CNS3XXX_USBOTG_BASE			0x81000000	/* USB OTG Control */
-#define CNS3XXX_USBOTG_BASE_VIRT		0xFFF15000

 #define CNS3XXX_USB_BASE			0x82000000	/* USB Host Control */

 #define CNS3XXX_SATA2_BASE			0x83000000	/* SATA */
 #define CNS3XXX_SATA2_SIZE			SZ_16M
-#define CNS3XXX_SATA2_BASE_VIRT			0xFFF17000

 #define CNS3XXX_CAMERA_BASE			0x84000000	/* Camera Interface */
-#define CNS3XXX_CAMERA_BASE_VIRT		0xFFF18000

 #define CNS3XXX_SDIO_BASE			0x85000000	/* SDIO */
-#define CNS3XXX_SDIO_BASE_VIRT			0xFFF19000

 #define CNS3XXX_I2S_TDM_BASE			0x86000000	/* I2S TDM */
-#define CNS3XXX_I2S_TDM_BASE_VIRT		0xFFF1A000

 #define CNS3XXX_2DG_BASE			0x87000000	/* 2D Graphic Control */
-#define CNS3XXX_2DG_BASE_VIRT			0xFFF1B000

 #define CNS3XXX_USB_OHCI_BASE			0x88000000	/* USB OHCI */

 #define CNS3XXX_L2C_BASE			0x92000000	/* L2 Cache Control */
-#define CNS3XXX_L2C_BASE_VIRT			0xFFF27000

 #define CNS3XXX_PCIE0_MEM_BASE			0xA0000000	/* PCIe Port 0 IO/Memory Space */
 #define CNS3XXX_PCIE0_MEM_BASE_VIRT		0xE0000000
@@ -239,7 +213,6 @@
 #define CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT	0xFF001000

 #define CNS3XXX_TC11MP_L220_BASE		0x92002000	/* L220 registers */
-#define CNS3XXX_TC11MP_L220_BASE_VIRT		0xFF002000

 /*
  * Misc block
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 49e657c..4499558 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -48,16 +48,6 @@ static struct map_desc cns3xxx_io_desc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= CNS3XXX_GPIOA_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_GPIOA_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= CNS3XXX_GPIOB_BASE_VIRT,
-		.pfn		= __phys_to_pfn(CNS3XXX_GPIOB_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= CNS3XXX_MISC_BASE_VIRT,
 		.pfn		= __phys_to_pfn(CNS3XXX_MISC_BASE),
 		.length		= SZ_4K,
-- 
1.7.1
