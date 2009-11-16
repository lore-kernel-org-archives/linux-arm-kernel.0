From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:56 +0100
Subject: [PATCH 13/25] imx: copy constants from mx2x.h to mx27.h using the
	appropriate namespace
In-Reply-To: <1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx27.h |  147 +++++++++++++++++++++++++++++----
 1 files changed, 129 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index b619aa4..e2ae19f 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -24,28 +24,69 @@
 #ifndef __ASM_ARCH_MXC_MX27_H__
 #define __ASM_ARCH_MXC_MX27_H__
 
-#define MX27_MSHC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x18000)
-#define MX27_GPT5_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x19000)
-#define MX27_GPT4_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1a000)
-#define MX27_UART5_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1b000)
-#define MX27_UART6_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1c000)
-#define MX27_I2C2_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1d000)
-#define MX27_SDHC3_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1e000)
-#define MX27_GPT6_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x1f000)
-#define MX27_VPU_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x23000)
-#define MX27_OTG_BASE_ADDR			MX2x_USBOTG_BASE_ADDR
-#define MX27_SAHARA_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x25000)
-#define MX27_IIM_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x28000)
-#define MX27_RTIC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x2a000)
-#define MX27_FEC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x2b000)
-#define MX27_SCC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x2c000)
-#define MX27_ETB_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x3b000)
-#define MX27_ETB_RAM_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x3c000)
+#define MX27_AIPI_BASE_ADDR		0x10000000
+#define MX27_AIPI_BASE_ADDR_VIRT	0xf4000000
+#define MX27_AIPI_SIZE			SZ_1M
+#define MX27_DMA_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x01000)
+#define MX27_WDOG_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x02000)
+#define MX27_GPT1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x03000)
+#define MX27_GPT2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x04000)
+#define MX27_GPT3_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x05000)
+#define MX27_PWM_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x06000)
+#define MX27_RTC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x07000)
+#define MX27_KPP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x08000)
+#define MX27_OWIRE_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x09000)
+#define MX27_UART1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x0a000)
+#define MX27_UART2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x0b000)
+#define MX27_UART3_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x0c000)
+#define MX27_UART4_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x0d000)
+#define MX27_CSPI1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x0e000)
+#define MX27_CSPI2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x0f000)
+#define MX27_SSI1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x10000)
+#define MX27_SSI2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x11000)
+#define MX27_I2C_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x12000)
+#define MX27_SDHC1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x13000)
+#define MX27_SDHC2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x14000)
+#define MX27_GPIO_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x15000)
+#define MX27_AUDMUX_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x16000)
+#define MX27_CSPI3_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x17000)
+#define MX27_MSHC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x18000)
+#define MX27_GPT5_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x19000)
+#define MX27_GPT4_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1a000)
+#define MX27_UART5_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1b000)
+#define MX27_UART6_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1c000)
+#define MX27_I2C2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1d000)
+#define MX27_SDHC3_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1e000)
+#define MX27_GPT6_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x1f000)
+#define MX27_LCDC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x21000)
+#define MX27_SLCDC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x22000)
+#define MX27_VPU_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x23000)
+#define MX27_USBOTG_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x24000)
+#define MX27_OTG_BASE_ADDR			MX27_USBOTG_BASE_ADDR
+#define MX27_SAHARA_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x25000)
+#define MX27_EMMA_PP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26000)
+#define MX27_EMMA_PRP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26400)
+#define MX27_CCM_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x27000)
+#define MX27_SYSCTRL_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x27800)
+#define MX27_IIM_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x28000)
+#define MX27_RTIC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x2a000)
+#define MX27_FEC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x2b000)
+#define MX27_SCC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x2c000)
+#define MX27_ETB_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x3b000)
+#define MX27_ETB_RAM_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x3c000)
+#define MX27_JAM_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x3e000)
+#define MX27_MAX_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x3f000)
+
+#define MX27_AVIC_BASE_ADDR		0x10040000
 
 /* ROM patch */
 #define MX27_ROMP_BASE_ADDR		0x10041000
 
-#define MX27_ATA_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x1000)
+#define MX27_SAHB1_BASE_ADDR		0x80000000
+#define MX27_SAHB1_BASE_ADDR_VIRT	0xf4100000
+#define MX27_SAHB1_SIZE			SZ_1M
+#define MX27_CSI_BASE_ADDR			(MX27_SAHB1_BASE_ADDR + 0x0000)
+#define MX27_ATA_BASE_ADDR			(MX27_SAHB1_BASE_ADDR + 0x1000)
 
 /* Memory regions and CS */
 #define MX27_SDRAM_BASE_ADDR		0xa0000000
@@ -79,12 +120,53 @@
 #define MX27_INT_GPT5		3
 #define MX27_INT_GPT4		4
 #define MX27_INT_RTIC		5
+#define MX27_INT_CSPI3		6
 #define MX27_INT_SDHC		7
+#define MX27_INT_GPIO		8
 #define MX27_INT_SDHC3		9
+#define MX27_INT_SDHC2		10
+#define MX27_INT_SDHC1		11
+#define MX27_INT_I2C		12
+#define MX27_INT_SSI2		13
+#define MX27_INT_SSI1		14
+#define MX27_INT_CSPI2		15
+#define MX27_INT_CSPI1		16
+#define MX27_INT_UART4		17
+#define MX27_INT_UART3		18
+#define MX27_INT_UART2		19
+#define MX27_INT_UART1		20
+#define MX27_INT_KPP		21
+#define MX27_INT_RTC		22
+#define MX27_INT_PWM		23
+#define MX27_INT_GPT3		24
+#define MX27_INT_GPT2		25
+#define MX27_INT_GPT1		26
+#define MX27_INT_WDOG		27
+#define MX27_INT_PCMCIA		28
+#define MX27_INT_NANDFC		29
 #define MX27_INT_ATA		30
+#define MX27_INT_CSI		31
+#define MX27_INT_DMACH0		32
+#define MX27_INT_DMACH1		33
+#define MX27_INT_DMACH2		34
+#define MX27_INT_DMACH3		35
+#define MX27_INT_DMACH4		36
+#define MX27_INT_DMACH5		37
+#define MX27_INT_DMACH6		38
+#define MX27_INT_DMACH7		39
+#define MX27_INT_DMACH8		40
+#define MX27_INT_DMACH9		41
+#define MX27_INT_DMACH10	42
+#define MX27_INT_DMACH11	43
+#define MX27_INT_DMACH12	44
+#define MX27_INT_DMACH13	45
+#define MX27_INT_DMACH14	46
+#define MX27_INT_DMACH15	47
 #define MX27_INT_UART6		48
 #define MX27_INT_UART5		49
 #define MX27_INT_FEC		50
+#define MX27_INT_EMMAPRP	51
+#define MX27_INT_EMMAPP		52
 #define MX27_INT_VPU		53
 #define MX27_INT_USB1		54
 #define MX27_INT_USB2		55
@@ -92,13 +174,42 @@
 #define MX27_INT_SCC_SMN	57
 #define MX27_INT_SCC_SCM	58
 #define MX27_INT_SAHARA		59
+#define MX27_INT_SLCDC		60
+#define MX27_INT_LCDC		61
 #define MX27_INT_IIM		62
 #define MX27_INT_CCM		63
 
 /* fixed DMA request numbers */
+#define MX27_DMA_REQ_CSPI3_RX	1
+#define MX27_DMA_REQ_CSPI3_TX	2
+#define MX27_DMA_REQ_EXT	3
 #define MX27_DMA_REQ_MSHC	4
+#define MX27_DMA_REQ_SDHC2	6
+#define MX27_DMA_REQ_SDHC1	7
+#define MX27_DMA_REQ_SSI2_RX0	8
+#define MX27_DMA_REQ_SSI2_TX0	9
+#define MX27_DMA_REQ_SSI2_RX1	10
+#define MX27_DMA_REQ_SSI2_TX1	11
+#define MX27_DMA_REQ_SSI1_RX0	12
+#define MX27_DMA_REQ_SSI1_TX0	13
+#define MX27_DMA_REQ_SSI1_RX1	14
+#define MX27_DMA_REQ_SSI1_TX1	15
+#define MX27_DMA_REQ_CSPI2_RX	16
+#define MX27_DMA_REQ_CSPI2_TX	17
+#define MX27_DMA_REQ_CSPI1_RX	18
+#define MX27_DMA_REQ_CSPI1_TX	19
+#define MX27_DMA_REQ_UART4_RX	20
+#define MX27_DMA_REQ_UART4_TX	21
+#define MX27_DMA_REQ_UART3_RX	22
+#define MX27_DMA_REQ_UART3_TX	23
+#define MX27_DMA_REQ_UART2_RX	24
+#define MX27_DMA_REQ_UART2_TX	25
+#define MX27_DMA_REQ_UART1_RX	26
+#define MX27_DMA_REQ_UART1_TX	27
 #define MX27_DMA_REQ_ATA_TX	28
 #define MX27_DMA_REQ_ATA_RCV	29
+#define MX27_DMA_REQ_CSI_STAT	30
+#define MX27_DMA_REQ_CSI_RX	31
 #define MX27_DMA_REQ_UART5_TX	32
 #define MX27_DMA_REQ_UART5_RX	33
 #define MX27_DMA_REQ_UART6_TX	34
-- 
1.6.5.2
