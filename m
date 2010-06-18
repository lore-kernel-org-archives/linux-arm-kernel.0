From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Fri, 18 Jun 2010 15:58:35 +0530
Subject: [PATCH 1/2] ux500: add separate irq lists for DB8500 and DB5500
Message-ID: <1276856916-19124-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c             |    2 +-
 arch/arm/mach-ux500/devices-db8500.c           |   14 ++--
 arch/arm/mach-ux500/include/mach/irqs-db5500.h |   85 +++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/irqs-db8500.h |   96 ++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/irqs.h        |   18 +++--
 5 files changed, 201 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs-db5500.h
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs-db8500.h

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b83005e..0331e4b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -78,7 +78,7 @@ static struct spi_board_info u8500_spi_devices[] = {
 		.bus_num = 0,
 		.chip_select = 0,
 		.mode = SPI_MODE_0,
-		.irq = IRQ_AB4500,
+		.irq = IRQ_DB8500_AB8500,
 	},
 };
 
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 8229034..56197b2 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -65,7 +65,7 @@ struct amba_device u8500_ssp0_device = {
 		.end   = U8500_SSP0_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_SSP0, NO_IRQ },
+	.irq = {IRQ_DB8500_SSP0, NO_IRQ },
 	/* ST-Ericsson modified id */
 	.periphid = SSP_PER_ID,
 };
@@ -77,8 +77,8 @@ static struct resource u8500_i2c0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_I2C0,
-		.end	= IRQ_I2C0,
+		.start	= IRQ_DB8500_I2C0,
+		.end	= IRQ_DB8500_I2C0,
 		.flags	= IORESOURCE_IRQ,
 	}
 };
@@ -97,8 +97,8 @@ static struct resource u8500_i2c4_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_I2C4,
-		.end	= IRQ_I2C4,
+		.start	= IRQ_DB8500_I2C4,
+		.end	= IRQ_DB8500_I2C4,
 		.flags	= IORESOURCE_IRQ,
 	}
 };
@@ -130,8 +130,8 @@ static struct resource dma40_resources[] = {
 		.name = "lcla",
 	},
 	[3] = {
-		.start = IRQ_DMA,
-		.end = IRQ_DMA,
+		.start = IRQ_DB8500_DMA,
+		.end = IRQ_DB8500_DMA,
 		.flags = IORESOURCE_IRQ}
 };
 
diff --git a/arch/arm/mach-ux500/include/mach/irqs-db5500.h b/arch/arm/mach-ux500/include/mach/irqs-db5500.h
new file mode 100644
index 0000000..6fbfe5e
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/irqs-db5500.h
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_IRQS_DB5500_H
+#define __MACH_IRQS_DB5500_H
+
+#define IRQ_DB5500_MTU0			(IRQ_SHPI_START + 4)
+#define IRQ_DB5500_SPI2			(IRQ_SHPI_START + 6)
+#define IRQ_DB5500_PMU0			(IRQ_SHPI_START + 7)
+#define IRQ_DB5500_SPI0			(IRQ_SHPI_START + 8)
+#define IRQ_DB5500_RTT			(IRQ_SHPI_START + 9)
+#define IRQ_DB5500_PKA			(IRQ_SHPI_START + 10)
+#define IRQ_DB5500_UART0		(IRQ_SHPI_START + 11)
+#define IRQ_DB5500_I2C3			(IRQ_SHPI_START + 12)
+#define IRQ_DB5500_L2CC			(IRQ_SHPI_START + 13)
+#define IRQ_DB5500_MSP0			(IRQ_SHPI_START + 14)
+#define IRQ_DB5500_CRYP1		(IRQ_SHPI_START + 15)
+#define IRQ_DB5500_PMU1			(IRQ_SHPI_START + 16)
+#define IRQ_DB5500_MTU1			(IRQ_SHPI_START + 17)
+#define IRQ_DB5500_RTC			(IRQ_SHPI_START + 18)
+#define IRQ_DB5500_UART1		(IRQ_SHPI_START + 19)
+#define IRQ_DB5500_USB_WAKEUP		(IRQ_SHPI_START + 20)
+#define IRQ_DB5500_I2C0			(IRQ_SHPI_START + 21)
+#define IRQ_DB5500_I2C1			(IRQ_SHPI_START + 22)
+#define IRQ_DB5500_USBOTG		(IRQ_SHPI_START + 23)
+#define IRQ_DB5500_DMA_SECURE		(IRQ_SHPI_START + 24)
+#define IRQ_DB5500_DMA			(IRQ_SHPI_START + 25)
+#define IRQ_DB5500_UART2		(IRQ_SHPI_START + 26)
+#define IRQ_DB5500_ICN_PMU1		(IRQ_SHPI_START + 27)
+#define IRQ_DB5500_ICN_PMU2		(IRQ_SHPI_START + 28)
+#define IRQ_DB5500_UART3		(IRQ_SHPI_START + 29)
+#define IRQ_DB5500_SPI3			(IRQ_SHPI_START + 30)
+#define IRQ_DB5500_SDMMC4		(IRQ_SHPI_START + 31)
+#define IRQ_DB5500_IRRC			(IRQ_SHPI_START + 33)
+#define IRQ_DB5500_IRDA_FT		(IRQ_SHPI_START + 34)
+#define IRQ_DB5500_IRDA_SD		(IRQ_SHPI_START + 35)
+#define IRQ_DB5500_IRDA_FI		(IRQ_SHPI_START + 36)
+#define IRQ_DB5500_IRDA_FD		(IRQ_SHPI_START + 37)
+#define IRQ_DB5500_FSMC_CODEREADY	(IRQ_SHPI_START + 38)
+#define IRQ_DB5500_FSMC_NANDWAIT	(IRQ_SHPI_START + 39)
+#define IRQ_DB5500_AB5500		(IRQ_SHPI_START + 40)
+#define IRQ_DB5500_SDMMC2		(IRQ_SHPI_START + 41)
+#define IRQ_DB5500_SIA			(IRQ_SHPI_START + 42)
+#define IRQ_DB5500_SIA2			(IRQ_SHPI_START + 43)
+#define IRQ_DB5500_HVA			(IRQ_SHPI_START + 44)
+#define IRQ_DB5500_HVA2			(IRQ_SHPI_START + 45)
+#define IRQ_DB5500_PRCMU0		(IRQ_SHPI_START + 46)
+#define IRQ_DB5500_PRCMU1		(IRQ_SHPI_START + 47)
+#define IRQ_DB5500_DISP			(IRQ_SHPI_START + 48)
+#define IRQ_DB5500_SDMMC1		(IRQ_SHPI_START + 50)
+#define IRQ_DB5500_MSP1			(IRQ_SHPI_START + 52)
+#define IRQ_DB5500_KBD			(IRQ_SHPI_START + 53)
+#define IRQ_DB5500_I2C2			(IRQ_SHPI_START + 55)
+#define IRQ_DB5500_B2R2			(IRQ_SHPI_START + 56)
+#define IRQ_DB5500_CRYP0		(IRQ_SHPI_START + 57)
+#define IRQ_DB5500_SDMMC3		(IRQ_SHPI_START + 59)
+#define IRQ_DB5500_SDMMC0		(IRQ_SHPI_START + 60)
+#define IRQ_DB5500_HSEM			(IRQ_SHPI_START + 61)
+#define IRQ_DB5500_SBAG			(IRQ_SHPI_START + 63)
+#define IRQ_DB5500_SPI1			(IRQ_SHPI_START + 96)
+#define IRQ_DB5500_MSP2			(IRQ_SHPI_START + 98)
+#define IRQ_DB5500_SRPTIMER		(IRQ_SHPI_START + 101)
+#define IRQ_DB5500_CTI0			(IRQ_SHPI_START + 108)
+#define IRQ_DB5500_CTI1			(IRQ_SHPI_START + 109)
+#define IRQ_DB5500_ICN_ERR		(IRQ_SHPI_START + 110)
+#define IRQ_DB5500_MALI_PPMMU		(IRQ_SHPI_START + 112)
+#define IRQ_DB5500_MALI_PP		(IRQ_SHPI_START + 113)
+#define IRQ_DB5500_MALI_GPMMU		(IRQ_SHPI_START + 114)
+#define IRQ_DB5500_MALI_GP		(IRQ_SHPI_START + 115)
+#define IRQ_DB5500_MALI			(IRQ_SHPI_START + 116)
+#define IRQ_DB5500_PRCMU_SEM		(IRQ_SHPI_START + 118)
+#define IRQ_DB5500_GPIO0		(IRQ_SHPI_START + 119)
+#define IRQ_DB5500_GPIO1		(IRQ_SHPI_START + 120)
+#define IRQ_DB5500_GPIO2		(IRQ_SHPI_START + 121)
+#define IRQ_DB5500_GPIO3		(IRQ_SHPI_START + 122)
+#define IRQ_DB5500_GPIO4		(IRQ_SHPI_START + 123)
+#define IRQ_DB5500_GPIO5		(IRQ_SHPI_START + 124)
+#define IRQ_DB5500_GPIO6		(IRQ_SHPI_START + 125)
+#define IRQ_DB5500_GPIO7		(IRQ_SHPI_START + 126)
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs-db8500.h b/arch/arm/mach-ux500/include/mach/irqs-db8500.h
new file mode 100644
index 0000000..8b5d9f0
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/irqs-db8500.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_IRQS_DB8500_H
+#define __MACH_IRQS_DB8500_H
+
+#define IRQ_DB8500_MTU0			(IRQ_SHPI_START + 4)
+#define IRQ_DB8500_SPI2			(IRQ_SHPI_START + 6)
+#define IRQ_DB8500_PMU			(IRQ_SHPI_START + 7)
+#define IRQ_DB8500_SPI0			(IRQ_SHPI_START + 8)
+#define IRQ_DB8500_RTT			(IRQ_SHPI_START + 9)
+#define IRQ_DB8500_PKA			(IRQ_SHPI_START + 10)
+#define IRQ_DB8500_UART0		(IRQ_SHPI_START + 11)
+#define IRQ_DB8500_I2C3			(IRQ_SHPI_START + 12)
+#define IRQ_DB8500_L2CC			(IRQ_SHPI_START + 13)
+#define IRQ_DB8500_SSP0			(IRQ_SHPI_START + 14)
+#define IRQ_DB8500_CRYP1		(IRQ_SHPI_START + 15)
+#define IRQ_DB8500_MSP1_RX		(IRQ_SHPI_START + 16)
+#define IRQ_DB8500_MTU1			(IRQ_SHPI_START + 17)
+#define IRQ_DB8500_RTC			(IRQ_SHPI_START + 18)
+#define IRQ_DB8500_UART1		(IRQ_SHPI_START + 19)
+#define IRQ_DB8500_USB_WAKEUP		(IRQ_SHPI_START + 20)
+#define IRQ_DB8500_I2C0			(IRQ_SHPI_START + 21)
+#define IRQ_DB8500_I2C1			(IRQ_SHPI_START + 22)
+#define IRQ_DB8500_USBOTG		(IRQ_SHPI_START + 23)
+#define IRQ_DB8500_DMA_SECURE		(IRQ_SHPI_START + 24)
+#define IRQ_DB8500_DMA			(IRQ_SHPI_START + 25)
+#define IRQ_DB8500_UART2		(IRQ_SHPI_START + 26)
+#define IRQ_DB8500_ICN_PMU1		(IRQ_SHPI_START + 27)
+#define IRQ_DB8500_ICN_PMU2		(IRQ_SHPI_START + 28)
+#define IRQ_DB8500_HSIR_EXCEP		(IRQ_SHPI_START + 29)
+#define IRQ_DB8500_MSP0			(IRQ_SHPI_START + 31)
+#define IRQ_DB8500_HSIR_CH0_OVRRUN	(IRQ_SHPI_START + 32)
+#define IRQ_DB8500_HSIR_CH1_OVRRUN	(IRQ_SHPI_START + 33)
+#define IRQ_DB8500_HSIR_CH2_OVRRUN	(IRQ_SHPI_START + 34)
+#define IRQ_DB8500_HSIR_CH3_OVRRUN	(IRQ_SHPI_START + 35)
+#define IRQ_DB8500_HSIR_CH4_OVRRUN	(IRQ_SHPI_START + 36)
+#define IRQ_DB8500_HSIR_CH5_OVRRUN	(IRQ_SHPI_START + 37)
+#define IRQ_DB8500_HSIR_CH6_OVRRUN	(IRQ_SHPI_START + 38)
+#define IRQ_DB8500_HSIR_CH7_OVRRUN	(IRQ_SHPI_START + 39)
+#define IRQ_DB8500_AB8500		(IRQ_SHPI_START + 40)
+#define IRQ_DB8500_SDMMC2		(IRQ_SHPI_START + 41)
+#define IRQ_DB8500_SIA			(IRQ_SHPI_START + 42)
+#define IRQ_DB8500_SIA2			(IRQ_SHPI_START + 43)
+#define IRQ_DB8500_SVA			(IRQ_SHPI_START + 44)
+#define IRQ_DB8500_SVA2			(IRQ_SHPI_START + 45)
+#define IRQ_DB8500_PRCMU0		(IRQ_SHPI_START + 46)
+#define IRQ_DB8500_PRCMU1		(IRQ_SHPI_START + 47)
+#define IRQ_DB8500_DISP			(IRQ_SHPI_START + 48)
+#define IRQ_DB8500_SPI3			(IRQ_SHPI_START + 49)
+#define IRQ_DB8500_SDMMC1		(IRQ_SHPI_START + 50)
+#define IRQ_DB8500_I2C4			(IRQ_SHPI_START + 51)
+#define IRQ_DB8500_SSP1			(IRQ_SHPI_START + 52)
+#define IRQ_DB8500_SKE			(IRQ_SHPI_START + 53)
+#define IRQ_DB8500_KB			(IRQ_SHPI_START + 54)
+#define IRQ_DB8500_I2C2			(IRQ_SHPI_START + 55)
+#define IRQ_DB8500_B2R2			(IRQ_SHPI_START + 56)
+#define IRQ_DB8500_CRYP0		(IRQ_SHPI_START + 57)
+#define IRQ_DB8500_SDMMC3		(IRQ_SHPI_START + 59)
+#define IRQ_DB8500_SDMMC0		(IRQ_SHPI_START + 60)
+#define IRQ_DB8500_HSEM			(IRQ_SHPI_START + 61)
+#define IRQ_DB8500_MSP1			(IRQ_SHPI_START + 62)
+#define IRQ_DB8500_SBAG			(IRQ_SHPI_START + 63)
+#define IRQ_DB8500_SPI1			(IRQ_SHPI_START + 96)
+#define IRQ_DB8500_SRPTIMER		(IRQ_SHPI_START + 97)
+#define IRQ_DB8500_MSP2			(IRQ_SHPI_START + 98)
+#define IRQ_DB8500_SDMMC4		(IRQ_SHPI_START + 99)
+#define IRQ_DB8500_SDMMC5		(IRQ_SHPI_START + 100)
+#define IRQ_DB8500_HSIRD0		(IRQ_SHPI_START + 104)
+#define IRQ_DB8500_HSIRD1		(IRQ_SHPI_START + 105)
+#define IRQ_DB8500_HSITD0		(IRQ_SHPI_START + 106)
+#define IRQ_DB8500_HSITD1		(IRQ_SHPI_START + 107)
+#define IRQ_DB8500_CTI0			(IRQ_SHPI_START + 108)
+#define IRQ_DB8500_CTI1			(IRQ_SHPI_START + 109)
+#define IRQ_DB8500_ICN_ERR		(IRQ_SHPI_START + 110)
+#define IRQ_DB8500_MALI_PPMMU		(IRQ_SHPI_START + 112)
+#define IRQ_DB8500_MALI_PP		(IRQ_SHPI_START + 113)
+#define IRQ_DB8500_MALI_GPMMU		(IRQ_SHPI_START + 114)
+#define IRQ_DB8500_MALI_GP		(IRQ_SHPI_START + 115)
+#define IRQ_DB8500_MALI			(IRQ_SHPI_START + 116)
+#define IRQ_DB8500_PRCMU_SEM		(IRQ_SHPI_START + 118)
+#define IRQ_DB8500_GPIO0		(IRQ_SHPI_START + 119)
+#define IRQ_DB8500_GPIO1		(IRQ_SHPI_START + 120)
+#define IRQ_DB8500_GPIO2		(IRQ_SHPI_START + 121)
+#define IRQ_DB8500_GPIO3		(IRQ_SHPI_START + 122)
+#define IRQ_DB8500_GPIO4		(IRQ_SHPI_START + 123)
+#define IRQ_DB8500_GPIO5		(IRQ_SHPI_START + 124)
+#define IRQ_DB8500_GPIO6		(IRQ_SHPI_START + 125)
+#define IRQ_DB8500_GPIO7		(IRQ_SHPI_START + 126)
+#define IRQ_DB8500_GPIO8		(IRQ_SHPI_START + 127)
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 7970684..a6fb1fc 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -10,7 +10,8 @@
 #ifndef ASM_ARCH_IRQS_H
 #define ASM_ARCH_IRQS_H
 
-#include <mach/hardware.h>
+#include <mach/irqs-db5500.h>
+#include <mach/irqs-db8500.h>
 
 #define IRQ_LOCALTIMER                  29
 #define IRQ_LOCALWDOG                   30
@@ -67,12 +68,17 @@
 /* There are 128 shared peripheral interrupts assigned to
  * INTID[160:32]. The first 32 interrupts are reserved.
  */
-#define U8500_SOC_NR_IRQS		161
+#define DBX500_NR_INTERNAL_IRQS		161
 
 /* After chip-specific IRQ numbers we have the GPIO ones */
 #define NOMADIK_NR_GPIO			288
-#define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + U8500_SOC_NR_IRQS)
-#define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - U8500_SOC_NR_IRQS)
-#define NR_IRQS				NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
+#define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + DBX500_NR_INTERNAL_IRQS)
+#define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - DBX500_NR_INTERNAL_IRQS)
+#define IRQ_BOARD_START			NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
 
-#endif /*ASM_ARCH_IRQS_H*/
+/* This will be overridden by board-specific irq headers */
+#define IRQ_BOARD_END			IRQ_BOARD_START
+
+#define NR_IRQS				IRQ_BOARD_END
+
+#endif /* ASM_ARCH_IRQS_H */
-- 
1.7.0
