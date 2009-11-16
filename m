From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:48 +0100
Subject: [PATCH 05/25] imx: add namespace prefixes for symbols in mx2x.h
In-Reply-To: <1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old names are still defined using the new names.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx2x.h |  339 ++++++++++++++++++++++-----------
 1 files changed, 224 insertions(+), 115 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx2x.h b/arch/arm/plat-mxc/include/mach/mx2x.h
index c0df87f..1766c7c 100644
--- a/arch/arm/plat-mxc/include/mach/mx2x.h
+++ b/arch/arm/plat-mxc/include/mach/mx2x.h
@@ -26,50 +26,48 @@
 /* The following addresses are common between i.MX21 and i.MX27 */
 
 /* Register offests */
-#define AIPI_BASE_ADDR          0x10000000
-#define AIPI_BASE_ADDR_VIRT     0xF4000000
-#define AIPI_SIZE               SZ_1M
-
-#define DMA_BASE_ADDR           (AIPI_BASE_ADDR + 0x01000)
-#define WDOG_BASE_ADDR          (AIPI_BASE_ADDR + 0x02000)
-#define GPT1_BASE_ADDR          (AIPI_BASE_ADDR + 0x03000)
-#define GPT2_BASE_ADDR          (AIPI_BASE_ADDR + 0x04000)
-#define GPT3_BASE_ADDR          (AIPI_BASE_ADDR + 0x05000)
-#define PWM_BASE_ADDR           (AIPI_BASE_ADDR + 0x06000)
-#define RTC_BASE_ADDR           (AIPI_BASE_ADDR + 0x07000)
-#define KPP_BASE_ADDR           (AIPI_BASE_ADDR + 0x08000)
-#define OWIRE_BASE_ADDR         (AIPI_BASE_ADDR + 0x09000)
-#define UART1_BASE_ADDR         (AIPI_BASE_ADDR + 0x0A000)
-#define UART2_BASE_ADDR         (AIPI_BASE_ADDR + 0x0B000)
-#define UART3_BASE_ADDR         (AIPI_BASE_ADDR + 0x0C000)
-#define UART4_BASE_ADDR         (AIPI_BASE_ADDR + 0x0D000)
-#define CSPI1_BASE_ADDR         (AIPI_BASE_ADDR + 0x0E000)
-#define CSPI2_BASE_ADDR         (AIPI_BASE_ADDR + 0x0F000)
-#define SSI1_BASE_ADDR          (AIPI_BASE_ADDR + 0x10000)
-#define SSI2_BASE_ADDR          (AIPI_BASE_ADDR + 0x11000)
-#define I2C_BASE_ADDR           (AIPI_BASE_ADDR + 0x12000)
-#define SDHC1_BASE_ADDR         (AIPI_BASE_ADDR + 0x13000)
-#define SDHC2_BASE_ADDR         (AIPI_BASE_ADDR + 0x14000)
-#define GPIO_BASE_ADDR          (AIPI_BASE_ADDR + 0x15000)
-#define AUDMUX_BASE_ADDR        (AIPI_BASE_ADDR + 0x16000)
-#define CSPI3_BASE_ADDR         (AIPI_BASE_ADDR + 0x17000)
-#define LCDC_BASE_ADDR          (AIPI_BASE_ADDR + 0x21000)
-#define SLCDC_BASE_ADDR         (AIPI_BASE_ADDR + 0x22000)
-#define USBOTG_BASE_ADDR        (AIPI_BASE_ADDR + 0x24000)
-#define EMMA_PP_BASE_ADDR       (AIPI_BASE_ADDR + 0x26000)
-#define EMMA_PRP_BASE_ADDR      (AIPI_BASE_ADDR + 0x26400)
-#define CCM_BASE_ADDR           (AIPI_BASE_ADDR + 0x27000)
-#define SYSCTRL_BASE_ADDR       (AIPI_BASE_ADDR + 0x27800)
-#define JAM_BASE_ADDR           (AIPI_BASE_ADDR + 0x3E000)
-#define MAX_BASE_ADDR           (AIPI_BASE_ADDR + 0x3F000)
-
-#define AVIC_BASE_ADDR          0x10040000
-
-#define SAHB1_BASE_ADDR         0x80000000
-#define SAHB1_BASE_ADDR_VIRT    0xF4100000
-#define SAHB1_SIZE              SZ_1M
-
-#define CSI_BASE_ADDR           (SAHB1_BASE_ADDR + 0x0000)
+#define MX2x_AIPI_BASE_ADDR		0x10000000
+#define MX2x_AIPI_BASE_ADDR_VIRT	0xf4000000
+#define MX2x_AIPI_SIZE			SZ_1M
+#define MX2x_DMA_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x01000)
+#define MX2x_WDOG_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x02000)
+#define MX2x_GPT1_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x03000)
+#define MX2x_GPT2_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x04000)
+#define MX2x_GPT3_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x05000)
+#define MX2x_PWM_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x06000)
+#define MX2x_RTC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x07000)
+#define MX2x_KPP_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x08000)
+#define MX2x_OWIRE_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x09000)
+#define MX2x_UART1_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x0a000)
+#define MX2x_UART2_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x0b000)
+#define MX2x_UART3_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x0c000)
+#define MX2x_UART4_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x0d000)
+#define MX2x_CSPI1_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x0e000)
+#define MX2x_CSPI2_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x0f000)
+#define MX2x_SSI1_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x10000)
+#define MX2x_SSI2_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x11000)
+#define MX2x_I2C_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x12000)
+#define MX2x_SDHC1_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x13000)
+#define MX2x_SDHC2_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x14000)
+#define MX2x_GPIO_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x15000)
+#define MX2x_AUDMUX_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x16000)
+#define MX2x_CSPI3_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x17000)
+#define MX2x_LCDC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x21000)
+#define MX2x_SLCDC_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x22000)
+#define MX2x_USBOTG_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x24000)
+#define MX2x_EMMA_PP_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x26000)
+#define MX2x_EMMA_PRP_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x26400)
+#define MX2x_CCM_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x27000)
+#define MX2x_SYSCTRL_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x27800)
+#define MX2x_JAM_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x3e000)
+#define MX2x_MAX_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x3f000)
+
+#define MX2x_AVIC_BASE_ADDR		0x10040000
+
+#define MX2x_SAHB1_BASE_ADDR		0x80000000
+#define MX2x_SAHB1_BASE_ADDR_VIRT	0xf4100000
+#define MX2x_SAHB1_SIZE			SZ_1M
+#define MX2x_CSI_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x0000)
 
 /*
  * This macro defines the physical to virtual address mapping for all the
@@ -105,78 +103,189 @@
 	(((x) - X_MEMC_BASE_ADDR) + X_MEMC_BASE_ADDR_VIRT)
 
 /* fixed interrupt numbers */
-#define MXC_INT_CSPI3		6
-#define MXC_INT_GPIO		8
-#define MXC_INT_SDHC2		10
-#define MXC_INT_SDHC1		11
-#define MXC_INT_I2C		12
-#define MXC_INT_SSI2		13
-#define MXC_INT_SSI1		14
-#define MXC_INT_CSPI2		15
-#define MXC_INT_CSPI1		16
-#define MXC_INT_UART4		17
-#define MXC_INT_UART3		18
-#define MXC_INT_UART2		19
-#define MXC_INT_UART1		20
-#define MXC_INT_KPP		21
-#define MXC_INT_RTC		22
-#define MXC_INT_PWM		23
-#define MXC_INT_GPT		INT_GPT1
-#define MXC_INT_GPT3		24
-#define MXC_INT_GPT2		25
-#define MXC_INT_GPT1		26
-#define MXC_INT_WDOG		27
-#define MXC_INT_PCMCIA		28
-#define MXC_INT_NANDFC		29
-#define MXC_INT_CSI		31
-#define MXC_INT_DMACH0		32
-#define MXC_INT_DMACH1		33
-#define MXC_INT_DMACH2		34
-#define MXC_INT_DMACH3		35
-#define MXC_INT_DMACH4		36
-#define MXC_INT_DMACH5		37
-#define MXC_INT_DMACH6		38
-#define MXC_INT_DMACH7		39
-#define MXC_INT_DMACH8		40
-#define MXC_INT_DMACH9		41
-#define MXC_INT_DMACH10		42
-#define MXC_INT_DMACH11		43
-#define MXC_INT_DMACH12		44
-#define MXC_INT_DMACH13		45
-#define MXC_INT_DMACH14		46
-#define MXC_INT_DMACH15		47
-#define MXC_INT_EMMAPRP		51
-#define MXC_INT_EMMAPP		52
-#define MXC_INT_SLCDC		60
-#define MXC_INT_LCDC		61
+#define MX2x_INT_CSPI3		6
+#define MX2x_INT_GPIO		8
+#define MX2x_INT_SDHC2		10
+#define MX2x_INT_SDHC1		11
+#define MX2x_INT_I2C		12
+#define MX2x_INT_SSI2		13
+#define MX2x_INT_SSI1		14
+#define MX2x_INT_CSPI2		15
+#define MX2x_INT_CSPI1		16
+#define MX2x_INT_UART4		17
+#define MX2x_INT_UART3		18
+#define MX2x_INT_UART2		19
+#define MX2x_INT_UART1		20
+#define MX2x_INT_KPP		21
+#define MX2x_INT_RTC		22
+#define MX2x_INT_PWM		23
+#define MX2x_INT_GPT3		24
+#define MX2x_INT_GPT2		25
+#define MX2x_INT_GPT1		26
+#define MX2x_INT_WDOG		27
+#define MX2x_INT_PCMCIA		28
+#define MX2x_INT_NANDFC		29
+#define MX2x_INT_CSI		31
+#define MX2x_INT_DMACH0		32
+#define MX2x_INT_DMACH1		33
+#define MX2x_INT_DMACH2		34
+#define MX2x_INT_DMACH3		35
+#define MX2x_INT_DMACH4		36
+#define MX2x_INT_DMACH5		37
+#define MX2x_INT_DMACH6		38
+#define MX2x_INT_DMACH7		39
+#define MX2x_INT_DMACH8		40
+#define MX2x_INT_DMACH9		41
+#define MX2x_INT_DMACH10	42
+#define MX2x_INT_DMACH11	43
+#define MX2x_INT_DMACH12	44
+#define MX2x_INT_DMACH13	45
+#define MX2x_INT_DMACH14	46
+#define MX2x_INT_DMACH15	47
+#define MX2x_INT_EMMAPRP	51
+#define MX2x_INT_EMMAPP		52
+#define MX2x_INT_SLCDC		60
+#define MX2x_INT_LCDC		61
 
 /* fixed DMA request numbers */
-#define DMA_REQ_CSPI3_RX        1
-#define DMA_REQ_CSPI3_TX        2
-#define DMA_REQ_EXT             3
-#define DMA_REQ_SDHC2           6
-#define DMA_REQ_SDHC1           7
-#define DMA_REQ_SSI2_RX0        8
-#define DMA_REQ_SSI2_TX0        9
-#define DMA_REQ_SSI2_RX1        10
-#define DMA_REQ_SSI2_TX1        11
-#define DMA_REQ_SSI1_RX0        12
-#define DMA_REQ_SSI1_TX0        13
-#define DMA_REQ_SSI1_RX1        14
-#define DMA_REQ_SSI1_TX1        15
-#define DMA_REQ_CSPI2_RX        16
-#define DMA_REQ_CSPI2_TX        17
-#define DMA_REQ_CSPI1_RX        18
-#define DMA_REQ_CSPI1_TX        19
-#define DMA_REQ_UART4_RX        20
-#define DMA_REQ_UART4_TX        21
-#define DMA_REQ_UART3_RX        22
-#define DMA_REQ_UART3_TX        23
-#define DMA_REQ_UART2_RX        24
-#define DMA_REQ_UART2_TX        25
-#define DMA_REQ_UART1_RX        26
-#define DMA_REQ_UART1_TX        27
-#define DMA_REQ_CSI_STAT        30
-#define DMA_REQ_CSI_RX          31
+#define MX2x_DMA_REQ_CSPI3_RX	1
+#define MX2x_DMA_REQ_CSPI3_TX	2
+#define MX2x_DMA_REQ_EXT	3
+#define MX2x_DMA_REQ_SDHC2	6
+#define MX2x_DMA_REQ_SDHC1	7
+#define MX2x_DMA_REQ_SSI2_RX0	8
+#define MX2x_DMA_REQ_SSI2_TX0	9
+#define MX2x_DMA_REQ_SSI2_RX1	10
+#define MX2x_DMA_REQ_SSI2_TX1	11
+#define MX2x_DMA_REQ_SSI1_RX0	12
+#define MX2x_DMA_REQ_SSI1_TX0	13
+#define MX2x_DMA_REQ_SSI1_RX1	14
+#define MX2x_DMA_REQ_SSI1_TX1	15
+#define MX2x_DMA_REQ_CSPI2_RX	16
+#define MX2x_DMA_REQ_CSPI2_TX	17
+#define MX2x_DMA_REQ_CSPI1_RX	18
+#define MX2x_DMA_REQ_CSPI1_TX	19
+#define MX2x_DMA_REQ_UART4_RX	20
+#define MX2x_DMA_REQ_UART4_TX	21
+#define MX2x_DMA_REQ_UART3_RX	22
+#define MX2x_DMA_REQ_UART3_TX	23
+#define MX2x_DMA_REQ_UART2_RX	24
+#define MX2x_DMA_REQ_UART2_TX	25
+#define MX2x_DMA_REQ_UART1_RX	26
+#define MX2x_DMA_REQ_UART1_TX	27
+#define MX2x_DMA_REQ_CSI_STAT	30
+#define MX2x_DMA_REQ_CSI_RX	31
+
+/* these should go away */
+#define AIPI_BASE_ADDR MX2x_AIPI_BASE_ADDR
+#define AIPI_BASE_ADDR_VIRT MX2x_AIPI_BASE_ADDR_VIRT
+#define AIPI_SIZE MX2x_AIPI_SIZE
+#define DMA_BASE_ADDR MX2x_DMA_BASE_ADDR
+#define WDOG_BASE_ADDR MX2x_WDOG_BASE_ADDR
+#define GPT1_BASE_ADDR MX2x_GPT1_BASE_ADDR
+#define GPT2_BASE_ADDR MX2x_GPT2_BASE_ADDR
+#define GPT3_BASE_ADDR MX2x_GPT3_BASE_ADDR
+#define PWM_BASE_ADDR MX2x_PWM_BASE_ADDR
+#define RTC_BASE_ADDR MX2x_RTC_BASE_ADDR
+#define KPP_BASE_ADDR MX2x_KPP_BASE_ADDR
+#define OWIRE_BASE_ADDR MX2x_OWIRE_BASE_ADDR
+#define UART1_BASE_ADDR MX2x_UART1_BASE_ADDR
+#define UART2_BASE_ADDR MX2x_UART2_BASE_ADDR
+#define UART3_BASE_ADDR MX2x_UART3_BASE_ADDR
+#define UART4_BASE_ADDR MX2x_UART4_BASE_ADDR
+#define CSPI1_BASE_ADDR MX2x_CSPI1_BASE_ADDR
+#define CSPI2_BASE_ADDR MX2x_CSPI2_BASE_ADDR
+#define SSI1_BASE_ADDR MX2x_SSI1_BASE_ADDR
+#define SSI2_BASE_ADDR MX2x_SSI2_BASE_ADDR
+#define I2C_BASE_ADDR MX2x_I2C_BASE_ADDR
+#define SDHC1_BASE_ADDR MX2x_SDHC1_BASE_ADDR
+#define SDHC2_BASE_ADDR MX2x_SDHC2_BASE_ADDR
+#define GPIO_BASE_ADDR MX2x_GPIO_BASE_ADDR
+#define AUDMUX_BASE_ADDR MX2x_AUDMUX_BASE_ADDR
+#define CSPI3_BASE_ADDR MX2x_CSPI3_BASE_ADDR
+#define LCDC_BASE_ADDR MX2x_LCDC_BASE_ADDR
+#define SLCDC_BASE_ADDR MX2x_SLCDC_BASE_ADDR
+#define USBOTG_BASE_ADDR MX2x_USBOTG_BASE_ADDR
+#define EMMA_PP_BASE_ADDR MX2x_EMMA_PP_BASE_ADDR
+#define EMMA_PRP_BASE_ADDR MX2x_EMMA_PRP_BASE_ADDR
+#define CCM_BASE_ADDR MX2x_CCM_BASE_ADDR
+#define SYSCTRL_BASE_ADDR MX2x_SYSCTRL_BASE_ADDR
+#define JAM_BASE_ADDR MX2x_JAM_BASE_ADDR
+#define MAX_BASE_ADDR MX2x_MAX_BASE_ADDR
+#define AVIC_BASE_ADDR MX2x_AVIC_BASE_ADDR
+#define SAHB1_BASE_ADDR MX2x_SAHB1_BASE_ADDR
+#define SAHB1_BASE_ADDR_VIRT MX2x_SAHB1_BASE_ADDR_VIRT
+#define SAHB1_SIZE MX2x_SAHB1_SIZE
+#define CSI_BASE_ADDR MX2x_CSI_BASE_ADDR
+#define MXC_INT_CSPI3 MX2x_INT_CSPI3
+#define MXC_INT_GPIO MX2x_INT_GPIO
+#define MXC_INT_SDHC2 MX2x_INT_SDHC2
+#define MXC_INT_SDHC1 MX2x_INT_SDHC1
+#define MXC_INT_I2C MX2x_INT_I2C
+#define MXC_INT_SSI2 MX2x_INT_SSI2
+#define MXC_INT_SSI1 MX2x_INT_SSI1
+#define MXC_INT_CSPI2 MX2x_INT_CSPI2
+#define MXC_INT_CSPI1 MX2x_INT_CSPI1
+#define MXC_INT_UART4 MX2x_INT_UART4
+#define MXC_INT_UART3 MX2x_INT_UART3
+#define MXC_INT_UART2 MX2x_INT_UART2
+#define MXC_INT_UART1 MX2x_INT_UART1
+#define MXC_INT_KPP MX2x_INT_KPP
+#define MXC_INT_RTC MX2x_INT_RTC
+#define MXC_INT_PWM MX2x_INT_PWM
+#define MXC_INT_GPT3 MX2x_INT_GPT3
+#define MXC_INT_GPT2 MX2x_INT_GPT2
+#define MXC_INT_GPT1 MX2x_INT_GPT1
+#define MXC_INT_WDOG MX2x_INT_WDOG
+#define MXC_INT_PCMCIA MX2x_INT_PCMCIA
+#define MXC_INT_NANDFC MX2x_INT_NANDFC
+#define MXC_INT_CSI MX2x_INT_CSI
+#define MXC_INT_DMACH0 MX2x_INT_DMACH0
+#define MXC_INT_DMACH1 MX2x_INT_DMACH1
+#define MXC_INT_DMACH2 MX2x_INT_DMACH2
+#define MXC_INT_DMACH3 MX2x_INT_DMACH3
+#define MXC_INT_DMACH4 MX2x_INT_DMACH4
+#define MXC_INT_DMACH5 MX2x_INT_DMACH5
+#define MXC_INT_DMACH6 MX2x_INT_DMACH6
+#define MXC_INT_DMACH7 MX2x_INT_DMACH7
+#define MXC_INT_DMACH8 MX2x_INT_DMACH8
+#define MXC_INT_DMACH9 MX2x_INT_DMACH9
+#define MXC_INT_DMACH10 MX2x_INT_DMACH10
+#define MXC_INT_DMACH11 MX2x_INT_DMACH11
+#define MXC_INT_DMACH12 MX2x_INT_DMACH12
+#define MXC_INT_DMACH13 MX2x_INT_DMACH13
+#define MXC_INT_DMACH14 MX2x_INT_DMACH14
+#define MXC_INT_DMACH15 MX2x_INT_DMACH15
+#define MXC_INT_EMMAPRP MX2x_INT_EMMAPRP
+#define MXC_INT_EMMAPP MX2x_INT_EMMAPP
+#define MXC_INT_SLCDC MX2x_INT_SLCDC
+#define MXC_INT_LCDC MX2x_INT_LCDC
+#define DMA_REQ_CSPI3_RX MX2x_DMA_REQ_CSPI3_RX
+#define DMA_REQ_CSPI3_TX MX2x_DMA_REQ_CSPI3_TX
+#define DMA_REQ_EXT MX2x_DMA_REQ_EXT
+#define DMA_REQ_SDHC2 MX2x_DMA_REQ_SDHC2
+#define DMA_REQ_SDHC1 MX2x_DMA_REQ_SDHC1
+#define DMA_REQ_SSI2_RX0 MX2x_DMA_REQ_SSI2_RX0
+#define DMA_REQ_SSI2_TX0 MX2x_DMA_REQ_SSI2_TX0
+#define DMA_REQ_SSI2_RX1 MX2x_DMA_REQ_SSI2_RX1
+#define DMA_REQ_SSI2_TX1 MX2x_DMA_REQ_SSI2_TX1
+#define DMA_REQ_SSI1_RX0 MX2x_DMA_REQ_SSI1_RX0
+#define DMA_REQ_SSI1_TX0 MX2x_DMA_REQ_SSI1_TX0
+#define DMA_REQ_SSI1_RX1 MX2x_DMA_REQ_SSI1_RX1
+#define DMA_REQ_SSI1_TX1 MX2x_DMA_REQ_SSI1_TX1
+#define DMA_REQ_CSPI2_RX MX2x_DMA_REQ_CSPI2_RX
+#define DMA_REQ_CSPI2_TX MX2x_DMA_REQ_CSPI2_TX
+#define DMA_REQ_CSPI1_RX MX2x_DMA_REQ_CSPI1_RX
+#define DMA_REQ_CSPI1_TX MX2x_DMA_REQ_CSPI1_TX
+#define DMA_REQ_UART4_RX MX2x_DMA_REQ_UART4_RX
+#define DMA_REQ_UART4_TX MX2x_DMA_REQ_UART4_TX
+#define DMA_REQ_UART3_RX MX2x_DMA_REQ_UART3_RX
+#define DMA_REQ_UART3_TX MX2x_DMA_REQ_UART3_TX
+#define DMA_REQ_UART2_RX MX2x_DMA_REQ_UART2_RX
+#define DMA_REQ_UART2_TX MX2x_DMA_REQ_UART2_TX
+#define DMA_REQ_UART1_RX MX2x_DMA_REQ_UART1_RX
+#define DMA_REQ_UART1_TX MX2x_DMA_REQ_UART1_TX
+#define DMA_REQ_CSI_STAT MX2x_DMA_REQ_CSI_STAT
+#define DMA_REQ_CSI_RX MX2x_DMA_REQ_CSI_RX
 
 #endif /* __ASM_ARCH_MXC_MX2x_H__ */
-- 
1.6.5.2
