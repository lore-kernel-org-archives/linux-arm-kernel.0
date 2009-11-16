From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:50 +0100
Subject: [PATCH 07/25] imx: add namespace prefixes for symbols in mx27.h
In-Reply-To: <1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old names are still defined using the new names.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx27.h |  201 ++++++++++++++++++++++-----------
 1 files changed, 133 insertions(+), 68 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 0104c20..b619aa4 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -24,88 +24,87 @@
 #ifndef __ASM_ARCH_MXC_MX27_H__
 #define __ASM_ARCH_MXC_MX27_H__
 
-#define MSHC_BASE_ADDR          (AIPI_BASE_ADDR + 0x18000)
-#define GPT5_BASE_ADDR          (AIPI_BASE_ADDR + 0x19000)
-#define GPT4_BASE_ADDR          (AIPI_BASE_ADDR + 0x1A000)
-#define UART5_BASE_ADDR         (AIPI_BASE_ADDR + 0x1B000)
-#define UART6_BASE_ADDR         (AIPI_BASE_ADDR + 0x1C000)
-#define I2C2_BASE_ADDR          (AIPI_BASE_ADDR + 0x1D000)
-#define SDHC3_BASE_ADDR         (AIPI_BASE_ADDR + 0x1E000)
-#define GPT6_BASE_ADDR          (AIPI_BASE_ADDR + 0x1F000)
-#define VPU_BASE_ADDR           (AIPI_BASE_ADDR + 0x23000)
-#define OTG_BASE_ADDR           USBOTG_BASE_ADDR
-#define SAHARA_BASE_ADDR        (AIPI_BASE_ADDR + 0x25000)
-#define IIM_BASE_ADDR           (AIPI_BASE_ADDR + 0x28000)
-#define RTIC_BASE_ADDR          (AIPI_BASE_ADDR + 0x2A000)
-#define FEC_BASE_ADDR           (AIPI_BASE_ADDR + 0x2B000)
-#define SCC_BASE_ADDR           (AIPI_BASE_ADDR + 0x2C000)
-#define ETB_BASE_ADDR           (AIPI_BASE_ADDR + 0x3B000)
-#define ETB_RAM_BASE_ADDR       (AIPI_BASE_ADDR + 0x3C000)
+#define MX27_MSHC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x18000)
+#define MX27_GPT5_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x19000)
+#define MX27_GPT4_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1a000)
+#define MX27_UART5_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1b000)
+#define MX27_UART6_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1c000)
+#define MX27_I2C2_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1d000)
+#define MX27_SDHC3_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1e000)
+#define MX27_GPT6_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1f000)
+#define MX27_VPU_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x23000)
+#define MX27_OTG_BASE_ADDR			MX2x_USBOTG_BASE_ADDR
+#define MX27_SAHARA_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x25000)
+#define MX27_IIM_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x28000)
+#define MX27_RTIC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x2a000)
+#define MX27_FEC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x2b000)
+#define MX27_SCC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x2c000)
+#define MX27_ETB_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x3b000)
+#define MX27_ETB_RAM_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x3c000)
 
 /* ROM patch */
-#define ROMP_BASE_ADDR          0x10041000
+#define MX27_ROMP_BASE_ADDR		0x10041000
 
-#define ATA_BASE_ADDR           (SAHB1_BASE_ADDR + 0x1000)
+#define MX27_ATA_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x1000)
 
 /* Memory regions and CS */
-#define SDRAM_BASE_ADDR         0xA0000000
-#define CSD1_BASE_ADDR          0xB0000000
+#define MX27_SDRAM_BASE_ADDR		0xa0000000
+#define MX27_CSD1_BASE_ADDR		0xb0000000
 
-#define CS0_BASE_ADDR           0xC0000000
-#define CS1_BASE_ADDR           0xC8000000
-#define CS2_BASE_ADDR           0xD0000000
-#define CS3_BASE_ADDR           0xD2000000
-#define CS4_BASE_ADDR           0xD4000000
-#define CS5_BASE_ADDR           0xD6000000
+#define MX27_CS0_BASE_ADDR		0xc0000000
+#define MX27_CS1_BASE_ADDR		0xc8000000
+#define MX27_CS2_BASE_ADDR		0xd0000000
+#define MX27_CS3_BASE_ADDR		0xd2000000
+#define MX27_CS4_BASE_ADDR		0xd4000000
+#define MX27_CS5_BASE_ADDR		0xd6000000
 
 /* NAND, SDRAM, WEIM, M3IF, EMI controllers */
-#define X_MEMC_BASE_ADDR        0xD8000000
-#define X_MEMC_BASE_ADDR_VIRT   0xF4200000
-#define X_MEMC_SIZE             SZ_1M
+#define MX27_X_MEMC_BASE_ADDR		0xd8000000
+#define MX27_X_MEMC_BASE_ADDR_VIRT	0xf4200000
+#define MX27_X_MEMC_SIZE		SZ_1M
+#define MX27_NFC_BASE_ADDR			(MX27_X_MEMC_BASE_ADDR)
+#define MX27_SDRAMC_BASE_ADDR			(MX27_X_MEMC_BASE_ADDR + 0x1000)
+#define MX27_WEIM_BASE_ADDR			(MX27_X_MEMC_BASE_ADDR + 0x2000)
+#define MX27_M3IF_BASE_ADDR			(MX27_X_MEMC_BASE_ADDR + 0x3000)
+#define MX27_PCMCIA_CTL_BASE_ADDR		(MX27_X_MEMC_BASE_ADDR + 0x4000)
 
-#define NFC_BASE_ADDR           (X_MEMC_BASE_ADDR)
-#define SDRAMC_BASE_ADDR        (X_MEMC_BASE_ADDR + 0x1000)
-#define WEIM_BASE_ADDR          (X_MEMC_BASE_ADDR + 0x2000)
-#define M3IF_BASE_ADDR          (X_MEMC_BASE_ADDR + 0x3000)
-#define PCMCIA_CTL_BASE_ADDR    (X_MEMC_BASE_ADDR + 0x4000)
-
-#define PCMCIA_MEM_BASE_ADDR    0xDC000000
+#define MX27_PCMCIA_MEM_BASE_ADDR	0xdc000000
 
 /* IRAM */
-#define IRAM_BASE_ADDR          0xFFFF4C00	/* internal ram */
+#define MX27_IRAM_BASE_ADDR		0xffff4c00	/* internal ram */
 
 /* fixed interrupt numbers */
-#define MXC_INT_I2C2		1
-#define MXC_INT_GPT6		2
-#define MXC_INT_GPT5		3
-#define MXC_INT_GPT4		4
-#define MXC_INT_RTIC		5
-#define MXC_INT_SDHC		7
-#define MXC_INT_SDHC3		9
-#define MXC_INT_ATA		30
-#define MXC_INT_UART6		48
-#define MXC_INT_UART5		49
-#define MXC_INT_FEC		50
-#define MXC_INT_VPU		53
-#define MXC_INT_USB1		54
-#define MXC_INT_USB2		55
-#define MXC_INT_USB3		56
-#define MXC_INT_SCC_SMN		57
-#define MXC_INT_SCC_SCM		58
-#define MXC_INT_SAHARA		59
-#define MXC_INT_IIM		62
-#define MXC_INT_CCM		63
+#define MX27_INT_I2C2		1
+#define MX27_INT_GPT6		2
+#define MX27_INT_GPT5		3
+#define MX27_INT_GPT4		4
+#define MX27_INT_RTIC		5
+#define MX27_INT_SDHC		7
+#define MX27_INT_SDHC3		9
+#define MX27_INT_ATA		30
+#define MX27_INT_UART6		48
+#define MX27_INT_UART5		49
+#define MX27_INT_FEC		50
+#define MX27_INT_VPU		53
+#define MX27_INT_USB1		54
+#define MX27_INT_USB2		55
+#define MX27_INT_USB3		56
+#define MX27_INT_SCC_SMN	57
+#define MX27_INT_SCC_SCM	58
+#define MX27_INT_SAHARA		59
+#define MX27_INT_IIM		62
+#define MX27_INT_CCM		63
 
 /* fixed DMA request numbers */
-#define DMA_REQ_MSHC            4
-#define DMA_REQ_ATA_TX          28
-#define DMA_REQ_ATA_RCV         29
-#define DMA_REQ_UART5_TX        32
-#define DMA_REQ_UART5_RX        33
-#define DMA_REQ_UART6_TX        34
-#define DMA_REQ_UART6_RX        35
-#define DMA_REQ_SDHC3           36
-#define DMA_REQ_NFC             37
+#define MX27_DMA_REQ_MSHC	4
+#define MX27_DMA_REQ_ATA_TX	28
+#define MX27_DMA_REQ_ATA_RCV	29
+#define MX27_DMA_REQ_UART5_TX	32
+#define MX27_DMA_REQ_UART5_RX	33
+#define MX27_DMA_REQ_UART6_TX	34
+#define MX27_DMA_REQ_UART6_RX	35
+#define MX27_DMA_REQ_SDHC3	36
+#define MX27_DMA_REQ_NFC	37
 
 /* silicon revisions specific to i.MX27 */
 #define CHIP_REV_1_0		0x00
@@ -115,6 +114,72 @@
 extern int mx27_revision(void);
 #endif
 
-/* Mandatory defines used globally */
+/* these should go away */
+#define MSHC_BASE_ADDR MX27_MSHC_BASE_ADDR
+#define GPT5_BASE_ADDR MX27_GPT5_BASE_ADDR
+#define GPT4_BASE_ADDR MX27_GPT4_BASE_ADDR
+#define UART5_BASE_ADDR MX27_UART5_BASE_ADDR
+#define UART6_BASE_ADDR MX27_UART6_BASE_ADDR
+#define I2C2_BASE_ADDR MX27_I2C2_BASE_ADDR
+#define SDHC3_BASE_ADDR MX27_SDHC3_BASE_ADDR
+#define GPT6_BASE_ADDR MX27_GPT6_BASE_ADDR
+#define VPU_BASE_ADDR MX27_VPU_BASE_ADDR
+#define OTG_BASE_ADDR MX27_OTG_BASE_ADDR
+#define SAHARA_BASE_ADDR MX27_SAHARA_BASE_ADDR
+#define IIM_BASE_ADDR MX27_IIM_BASE_ADDR
+#define RTIC_BASE_ADDR MX27_RTIC_BASE_ADDR
+#define FEC_BASE_ADDR MX27_FEC_BASE_ADDR
+#define SCC_BASE_ADDR MX27_SCC_BASE_ADDR
+#define ETB_BASE_ADDR MX27_ETB_BASE_ADDR
+#define ETB_RAM_BASE_ADDR MX27_ETB_RAM_BASE_ADDR
+#define ROMP_BASE_ADDR MX27_ROMP_BASE_ADDR
+#define ATA_BASE_ADDR MX27_ATA_BASE_ADDR
+#define SDRAM_BASE_ADDR MX27_SDRAM_BASE_ADDR
+#define CSD1_BASE_ADDR MX27_CSD1_BASE_ADDR
+#define CS0_BASE_ADDR MX27_CS0_BASE_ADDR
+#define CS1_BASE_ADDR MX27_CS1_BASE_ADDR
+#define CS2_BASE_ADDR MX27_CS2_BASE_ADDR
+#define CS3_BASE_ADDR MX27_CS3_BASE_ADDR
+#define CS4_BASE_ADDR MX27_CS4_BASE_ADDR
+#define CS5_BASE_ADDR MX27_CS5_BASE_ADDR
+#define X_MEMC_BASE_ADDR MX27_X_MEMC_BASE_ADDR
+#define X_MEMC_BASE_ADDR_VIRT MX27_X_MEMC_BASE_ADDR_VIRT
+#define X_MEMC_SIZE MX27_X_MEMC_SIZE
+#define NFC_BASE_ADDR MX27_NFC_BASE_ADDR
+#define SDRAMC_BASE_ADDR MX27_SDRAMC_BASE_ADDR
+#define WEIM_BASE_ADDR MX27_WEIM_BASE_ADDR
+#define M3IF_BASE_ADDR MX27_M3IF_BASE_ADDR
+#define PCMCIA_CTL_BASE_ADDR MX27_PCMCIA_CTL_BASE_ADDR
+#define PCMCIA_MEM_BASE_ADDR MX27_PCMCIA_MEM_BASE_ADDR
+#define IRAM_BASE_ADDR MX27_IRAM_BASE_ADDR
+#define MXC_INT_I2C2 MX27_INT_I2C2
+#define MXC_INT_GPT6 MX27_INT_GPT6
+#define MXC_INT_GPT5 MX27_INT_GPT5
+#define MXC_INT_GPT4 MX27_INT_GPT4
+#define MXC_INT_RTIC MX27_INT_RTIC
+#define MXC_INT_SDHC MX27_INT_SDHC
+#define MXC_INT_SDHC3 MX27_INT_SDHC3
+#define MXC_INT_ATA MX27_INT_ATA
+#define MXC_INT_UART6 MX27_INT_UART6
+#define MXC_INT_UART5 MX27_INT_UART5
+#define MXC_INT_FEC MX27_INT_FEC
+#define MXC_INT_VPU MX27_INT_VPU
+#define MXC_INT_USB1 MX27_INT_USB1
+#define MXC_INT_USB2 MX27_INT_USB2
+#define MXC_INT_USB3 MX27_INT_USB3
+#define MXC_INT_SCC_SMN MX27_INT_SCC_SMN
+#define MXC_INT_SCC_SCM MX27_INT_SCC_SCM
+#define MXC_INT_SAHARA MX27_INT_SAHARA
+#define MXC_INT_IIM MX27_INT_IIM
+#define MXC_INT_CCM MX27_INT_CCM
+#define DMA_REQ_MSHC MX27_DMA_REQ_MSHC
+#define DMA_REQ_ATA_TX MX27_DMA_REQ_ATA_TX
+#define DMA_REQ_ATA_RCV MX27_DMA_REQ_ATA_RCV
+#define DMA_REQ_UART5_TX MX27_DMA_REQ_UART5_TX
+#define DMA_REQ_UART5_RX MX27_DMA_REQ_UART5_RX
+#define DMA_REQ_UART6_TX MX27_DMA_REQ_UART6_TX
+#define DMA_REQ_UART6_RX MX27_DMA_REQ_UART6_RX
+#define DMA_REQ_SDHC3 MX27_DMA_REQ_SDHC3
+#define DMA_REQ_NFC MX27_DMA_REQ_NFC
 
 #endif /* __ASM_ARCH_MXC_MX27_H__ */
-- 
1.6.5.2
