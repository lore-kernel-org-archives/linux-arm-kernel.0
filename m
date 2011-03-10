From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 10 Mar 2011 19:08:52 +0100
Subject: [PATCH 1/6] AT91: overall definition: add 5series support
In-Reply-To: <20110310180628.GH9351@game.jcrosoft.org>
References: <20110310180628.GH9351@game.jcrosoft.org>
Message-ID: <1299780537-16481-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Liang <dan.liang@atmel.com>

[at91sam9x5.h]
Add the definitions of peripheral and system registers for 5series chips family.

[at91sam9x5_matrix.h]
Add definitions of Matrix registers for 5series chips family.

[cpu.h]
Add ARCH_ID and basic cpu macros definition for 5series chips family.

Signed-off-by: Dan Liang <dan.liang@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/include/mach/at91sam9x5.h       |  179 ++++++++++++++++++++
 .../arm/mach-at91/include/mach/at91sam9x5_matrix.h |  139 +++++++++++++++
 arch/arm/mach-at91/include/mach/cpu.h              |   28 +++
 3 files changed, 346 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5.h
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h

diff --git a/arch/arm/mach-at91/include/mach/at91sam9x5.h b/arch/arm/mach-at91/include/mach/at91sam9x5.h
new file mode 100644
index 0000000..ae94aeb
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/at91sam9x5.h
@@ -0,0 +1,179 @@
+/*
+ * Chip-specific header file for the AT91SAM9x5 family
+ *
+ *  Copyright (C) 2009-2010 Atmel Corporation.
+ *
+ * Common definitions.
+ * Based on AT91SAM9x5 preliminary datasheet.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef AT91SAM9X5_H
+#define AT91SAM9X5_H
+
+/*
+ * Peripheral identifiers/interrupts.
+ */
+#define AT91_ID_FIQ		0	/* Advanced Interrupt Controller (FIQ) */
+#define AT91_ID_SYS		1	/* System Controller Interrupt */
+#define AT91SAM9X5_ID_PIOAB	2	/* Parallel I/O Controller A and B */
+#define AT91SAM9X5_ID_PIOCD	3	/* Parallel I/O Controller C and D */
+#define AT91SAM9X5_ID_SMD	4	/* SMD Soft Modem (SMD) */
+#define AT91SAM9X5_ID_USART0	5	/* USART 0 */
+#define AT91SAM9X5_ID_USART1	6	/* USART 1 */
+#define AT91SAM9X5_ID_USART2	7	/* USART 2 */
+#define AT91SAM9X5_ID_USART3	8	/* USART 3 */
+#define AT91SAM9X5_ID_TWI0	9	/* Two-Wire Interface 0 */
+#define AT91SAM9X5_ID_TWI1	10	/* Two-Wire Interface 1 */
+#define AT91SAM9X5_ID_TWI2	11	/* Two-Wire Interface 2 */
+#define AT91SAM9X5_ID_MCI0	12	/* High Speed Multimedia Card Interface 0 */
+#define AT91SAM9X5_ID_SPI0	13	/* Serial Peripheral Interface 0 */
+#define AT91SAM9X5_ID_SPI1	14	/* Serial Peripheral Interface 1 */
+#define AT91SAM9X5_ID_UART0	15	/* UART 0 */
+#define AT91SAM9X5_ID_UART1	16	/* UART 1 */
+#define AT91SAM9X5_ID_TCB	17	/* Timer Counter 0, 1, 2, 3, 4 and 5 */
+#define AT91SAM9X5_ID_PWM	18	/* Pulse Width Modulation Controller */
+#define AT91SAM9X5_ID_ADC	19	/* ADC Controller */
+#define AT91SAM9X5_ID_DMA0	20	/* DMA Controller 0 */
+#define AT91SAM9X5_ID_DMA1	21	/* DMA Controller 1 */
+#define AT91SAM9X5_ID_UHPHS	22	/* USB Host High Speed */
+#define AT91SAM9X5_ID_UDPHS	23	/* USB Device High Speed */
+#define AT91SAM9X5_ID_EMAC0	24	/* Ethernet MAC0 */
+#define AT91SAM9X5_ID_LCDC	25	/* LCD Controller */
+#define AT91SAM9X5_ID_ISI	25	/* Image Sensor Interface */
+#define AT91SAM9X5_ID_MCI1	26	/* High Speed Multimedia Card Interface 1 */
+#define AT91SAM9X5_ID_EMAC1	27	/* Ethernet MAC1 */
+#define AT91SAM9X5_ID_SSC	28	/* Synchronous Serial Controller */
+#define AT91SAM9X5_ID_CAN0	29	/* CAN Controller 0 */
+#define AT91SAM9X5_ID_CAN1	30	/* CAN Controller 1 */
+#define AT91SAM9X5_ID_IRQ0	31	/* Advanced Interrupt Controller */
+
+/*
+ * User Peripheral physical base addresses.
+ */
+#define AT91SAM9X5_BASE_SPI0		0xf0000000
+#define AT91SAM9X5_BASE_SPI1		0xf0004000
+#define AT91SAM9X5_BASE_MCI0		0xf0008000
+#define AT91SAM9X5_BASE_MCI1		0xf000c000
+#define AT91SAM9X5_BASE_SSC		0xf0010000
+#define AT91SAM9X5_BASE_CAN0		0xf8000000
+#define AT91SAM9X5_BASE_CAN1		0xf8004000
+#define AT91SAM9X5_BASE_TCB0		0xf8008000
+#define AT91SAM9X5_BASE_TC0		0xf8008000
+#define AT91SAM9X5_BASE_TC1		0xf8008040
+#define AT91SAM9X5_BASE_TC2		0xf8008080
+#define AT91SAM9X5_BASE_TCB1		0xf800c000
+#define AT91SAM9X5_BASE_TC3		0xf800c000
+#define AT91SAM9X5_BASE_TC4		0xf800c040
+#define AT91SAM9X5_BASE_TC5		0xf800c080
+#define AT91SAM9X5_BASE_TWI0		0xf8010000
+#define AT91SAM9X5_BASE_TWI1		0xf8014000
+#define AT91SAM9X5_BASE_TWI2		0xf8018000
+#define AT91SAM9X5_BASE_USART0		0xf801c000
+#define AT91SAM9X5_BASE_USART1		0xf8020000
+#define AT91SAM9X5_BASE_USART2		0xf8024000
+#define AT91SAM9X5_BASE_USART3		0xf8028000
+#define AT91SAM9X5_BASE_EMAC0		0xf802c000
+#define AT91SAM9X5_BASE_EMAC1		0xf8030000
+#define AT91SAM9X5_BASE_PWMC		0xf8034000
+#define AT91SAM9X5_BASE_LCDC		0xf8038000
+#define AT91SAM9X5_BASE_UDPHS		0xf803c000
+#define AT91SAM9X5_BASE_UART0		0xf8040000
+#define AT91SAM9X5_BASE_UART1		0xf8044000
+#define AT91SAM9X5_BASE_ISI		0xf8048000
+#define AT91SAM9X5_BASE_ADC		0xf804c000
+#define AT91_BASE_SYS			0xffffc000
+
+/*
+ * System Peripherals (offset from AT91_BASE_SYS)
+ */
+#define AT91_MATRIX	(0xffffde00 - AT91_BASE_SYS)
+#define AT91_PMECC	(0xffffe000 - AT91_BASE_SYS)
+#define AT91_PMERRLOC	(0xffffe600 - AT91_BASE_SYS)
+#define AT91_DDRSDRC0	(0xffffe800 - AT91_BASE_SYS)
+#define AT91_SMC	(0xffffea00 - AT91_BASE_SYS)
+#define AT91_DMA0	(0xffffec00 - AT91_BASE_SYS)
+#define AT91_DMA1	(0xffffee00 - AT91_BASE_SYS)
+#define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
+#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
+#define AT91_PIOA	(0xfffff400 - AT91_BASE_SYS)
+#define AT91_PIOB	(0xfffff600 - AT91_BASE_SYS)
+#define AT91_PIOC	(0xfffff800 - AT91_BASE_SYS)
+#define AT91_PIOD	(0xfffffa00 - AT91_BASE_SYS)
+#define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
+#define AT91_RSTC	(0xfffffe00 - AT91_BASE_SYS)
+#define AT91_SHDWC	(0xfffffe10 - AT91_BASE_SYS)
+#define AT91_PIT	(0xfffffe30 - AT91_BASE_SYS)
+#define AT91_WDT	(0xfffffe40 - AT91_BASE_SYS)
+#define AT91_GPBR	(0xfffffe60 - AT91_BASE_SYS)
+#define AT91_RTC	(0xfffffeb0 - AT91_BASE_SYS)
+
+#define AT91_USART0	AT91SAM9X5_BASE_US0
+#define AT91_USART1	AT91SAM9X5_BASE_US1
+#define AT91_USART2	AT91SAM9X5_BASE_US2
+#define AT91_USART3	AT91SAM9X5_BASE_US3
+
+/*
+ * Internal Memory.
+ */
+#define AT91SAM9X5_SRAM_BASE	0x00300000	/* Internal SRAM base address */
+#define AT91SAM9X5_SRAM_SIZE	SZ_32K		/* Internal SRAM size (32Kb) */
+
+#define AT91SAM9X5_ROM_BASE	0x00400000	/* Internal ROM base address */
+#define AT91SAM9X5_ROM_SIZE	SZ_64K		/* Internal ROM size (64Kb) */
+
+#define AT91SAM9X5_SMD_BASE	0x00400000	/* SMD Controller */
+#define AT91SAM9X5_UDPHS_FIFO	0x00500000	/* USB Device HS controller */
+#define AT91SAM9X5_OHCI_BASE	0x00600000	/* USB Host controller (OHCI) */
+#define AT91SAM9X5_EHCI_BASE	0x00700000	/* USB Host controller (EHCI) */
+
+#define CONFIG_DRAM_BASE	AT91_CHIPSELECT_1
+
+#define CONSISTENT_DMA_SIZE	SZ_4M
+
+/*
+ * DMA0 peripheral identifiers
+ * for hardware handshaking interface
+ */
+#define AT_DMA_ID_MCI0		 0
+#define AT_DMA_ID_SPI0_TX	 1
+#define AT_DMA_ID_SPI0_RX	 2
+#define AT_DMA_ID_USART0_TX	 3
+#define AT_DMA_ID_USART0_RX	 4
+#define AT_DMA_ID_USART1_TX	 5
+#define AT_DMA_ID_USART1_RX	 6
+#define AT_DMA_ID_TWI0_TX	 7
+#define AT_DMA_ID_TWI0_RX	 8
+#define AT_DMA_ID_TWI2_TX	 9
+#define AT_DMA_ID_TWI2_RX	10
+#define AT_DMA_ID_UART0_TX	11
+#define AT_DMA_ID_UART0_RX	12
+#define AT_DMA_ID_SSC_TX	13
+#define AT_DMA_ID_SSC_RX	14
+
+/*
+ * DMA1 peripheral identifiers
+ * for hardware handshaking interface
+ */
+#define AT_DMA_ID_MCI1		 0
+#define AT_DMA_ID_SPI1_TX	 1
+#define AT_DMA_ID_SPI1_RX	 2
+#define AT_DMA_ID_SMD_TX	 3
+#define AT_DMA_ID_SMD_RX	 4
+#define AT_DMA_ID_TWI1_TX	 5
+#define AT_DMA_ID_TWI1_RX	 6
+#define AT_DMA_ID_ADC_RX	 7
+#define AT_DMA_ID_DBGU_TX	 8
+#define AT_DMA_ID_DBGU_RX	 9
+#define AT_DMA_ID_UART1_TX	10
+#define AT_DMA_ID_UART1_RX	11
+#define AT_DMA_ID_USART2_TX	12
+#define AT_DMA_ID_USART2_RX	13
+#define AT_DMA_ID_USART3_TX	14
+#define AT_DMA_ID_USART3_RX	15
+
+#endif
diff --git a/arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h b/arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h
new file mode 100644
index 0000000..b070a40
--- /dev/null
+++ b/arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h
@@ -0,0 +1,139 @@
+/*
+ * Matrix-centric header file for the AT91SAM9x5 family
+ *
+ *  Copyright (C) 2009-2010 Atmel Corporation.
+ *
+ * Memory Controllers (MATRIX, EBI) - System peripherals registers.
+ * Based on AT91SAM9x5 preliminary datasheet.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef AT91SAM9X5_MATRIX_H
+#define AT91SAM9X5_MATRIX_H
+
+#define AT91_MATRIX_MCFG0	(AT91_MATRIX + 0x00)	/* Master Configuration Register 0 */
+#define AT91_MATRIX_MCFG1	(AT91_MATRIX + 0x04)	/* Master Configuration Register 1 */
+#define AT91_MATRIX_MCFG2	(AT91_MATRIX + 0x08)	/* Master Configuration Register 2 */
+#define AT91_MATRIX_MCFG3	(AT91_MATRIX + 0x0C)	/* Master Configuration Register 3 */
+#define AT91_MATRIX_MCFG4	(AT91_MATRIX + 0x10)	/* Master Configuration Register 4 */
+#define AT91_MATRIX_MCFG5	(AT91_MATRIX + 0x14)	/* Master Configuration Register 5 */
+#define AT91_MATRIX_MCFG6	(AT91_MATRIX + 0x18)	/* Master Configuration Register 6 */
+#define AT91_MATRIX_MCFG7	(AT91_MATRIX + 0x1C)	/* Master Configuration Register 7 */
+#define AT91_MATRIX_MCFG8	(AT91_MATRIX + 0x20)	/* Master Configuration Register 8 */
+#define AT91_MATRIX_MCFG9	(AT91_MATRIX + 0x24)	/* Master Configuration Register 9 */
+#define AT91_MATRIX_MCFG10	(AT91_MATRIX + 0x28)	/* Master Configuration Register 10 */
+#define AT91_MATRIX_MCFG11	(AT91_MATRIX + 0x2C)	/* Master Configuration Register 11 */
+#define		AT91_MATRIX_ULBT	(7 << 0)	/* Undefined Length Burst Type */
+#define			AT91_MATRIX_ULBT_INFINITE	(0 << 0)
+#define			AT91_MATRIX_ULBT_SINGLE		(1 << 0)
+#define			AT91_MATRIX_ULBT_FOUR		(2 << 0)
+#define			AT91_MATRIX_ULBT_EIGHT		(3 << 0)
+#define			AT91_MATRIX_ULBT_SIXTEEN	(4 << 0)
+#define			AT91_MATRIX_ULBT_THIRTYTWO	(5 << 0)
+#define			AT91_MATRIX_ULBT_SIXTYFOUR	(6 << 0)
+#define			AT91_MATRIX_ULBT_128		(7 << 0)
+
+#define AT91_MATRIX_SCFG0	(AT91_MATRIX + 0x40)	/* Slave Configuration Register 0 */
+#define AT91_MATRIX_SCFG1	(AT91_MATRIX + 0x44)	/* Slave Configuration Register 1 */
+#define AT91_MATRIX_SCFG2	(AT91_MATRIX + 0x48)	/* Slave Configuration Register 2 */
+#define AT91_MATRIX_SCFG3	(AT91_MATRIX + 0x4C)	/* Slave Configuration Register 3 */
+#define AT91_MATRIX_SCFG4	(AT91_MATRIX + 0x50)	/* Slave Configuration Register 4 */
+#define AT91_MATRIX_SCFG5	(AT91_MATRIX + 0x54)	/* Slave Configuration Register 5 */
+#define AT91_MATRIX_SCFG6	(AT91_MATRIX + 0x58)	/* Slave Configuration Register 6 */
+#define AT91_MATRIX_SCFG7	(AT91_MATRIX + 0x5C)	/* Slave Configuration Register 7 */
+#define AT91_MATRIX_SCFG8	(AT91_MATRIX + 0x60)	/* Slave Configuration Register 8 */
+#define		AT91_MATRIX_SLOT_CYCLE		(0x1ff << 0)	/* Maximum Number of Allowed Cycles for a Burst */
+#define		AT91_MATRIX_DEFMSTR_TYPE	(3    << 16)	/* Default Master Type */
+#define			AT91_MATRIX_DEFMSTR_TYPE_NONE	(0 << 16)
+#define			AT91_MATRIX_DEFMSTR_TYPE_LAST	(1 << 16)
+#define			AT91_MATRIX_DEFMSTR_TYPE_FIXED	(2 << 16)
+#define		AT91_MATRIX_FIXED_DEFMSTR	(0xf  << 18)	/* Fixed Index of Default Master */
+
+#define AT91_MATRIX_PRAS0	(AT91_MATRIX + 0x80)	/* Priority Register A for Slave 0 */
+#define AT91_MATRIX_PRBS0	(AT91_MATRIX + 0x84)	/* Priority Register B for Slave 0 */
+#define AT91_MATRIX_PRAS1	(AT91_MATRIX + 0x88)	/* Priority Register A for Slave 1 */
+#define AT91_MATRIX_PRBS1	(AT91_MATRIX + 0x8C)	/* Priority Register B for Slave 1 */
+#define AT91_MATRIX_PRAS2	(AT91_MATRIX + 0x90)	/* Priority Register A for Slave 2 */
+#define AT91_MATRIX_PRBS2	(AT91_MATRIX + 0x94)	/* Priority Register B for Slave 2 */
+#define AT91_MATRIX_PRAS3	(AT91_MATRIX + 0x98)	/* Priority Register A for Slave 3 */
+#define AT91_MATRIX_PRBS3	(AT91_MATRIX + 0x9C)	/* Priority Register B for Slave 3 */
+#define AT91_MATRIX_PRAS4	(AT91_MATRIX + 0xA0)	/* Priority Register A for Slave 4 */
+#define AT91_MATRIX_PRBS4	(AT91_MATRIX + 0xA4)	/* Priority Register B for Slave 4 */
+#define AT91_MATRIX_PRAS5	(AT91_MATRIX + 0xA8)	/* Priority Register A for Slave 5 */
+#define AT91_MATRIX_PRBS5	(AT91_MATRIX + 0xAC)	/* Priority Register B for Slave 5 */
+#define AT91_MATRIX_PRAS6	(AT91_MATRIX + 0xB0)	/* Priority Register A for Slave 6 */
+#define AT91_MATRIX_PRBS6	(AT91_MATRIX + 0xB4)	/* Priority Register B for Slave 6 */
+#define AT91_MATRIX_PRAS7	(AT91_MATRIX + 0xB8)	/* Priority Register A for Slave 7 */
+#define AT91_MATRIX_PRBS7	(AT91_MATRIX + 0xBC)	/* Priority Register B for Slave 7 */
+#define AT91_MATRIX_PRAS8	(AT91_MATRIX + 0xC0)	/* Priority Register A for Slave 8 */
+#define AT91_MATRIX_PRBS8	(AT91_MATRIX + 0xC4)	/* Priority Register B for Slave 8 */
+#define		AT91_MATRIX_M0PR		(3 << 0)	/* Master 0 Priority */
+#define		AT91_MATRIX_M1PR		(3 << 4)	/* Master 1 Priority */
+#define		AT91_MATRIX_M2PR		(3 << 8)	/* Master 2 Priority */
+#define		AT91_MATRIX_M3PR		(3 << 12)	/* Master 3 Priority */
+#define		AT91_MATRIX_M4PR		(3 << 16)	/* Master 4 Priority */
+#define		AT91_MATRIX_M5PR		(3 << 20)	/* Master 5 Priority */
+#define		AT91_MATRIX_M6PR		(3 << 24)	/* Master 6 Priority */
+#define		AT91_MATRIX_M7PR		(3 << 28)	/* Master 7 Priority */
+#define		AT91_MATRIX_M8PR		(3 << 0)	/* Master 8 Priority (in Register B) */
+#define		AT91_MATRIX_M9PR		(3 << 4)	/* Master 9 Priority (in Register B) */
+#define		AT91_MATRIX_M10PR		(3 << 8)	/* Master 10 Priority (in Register B) */
+#define		AT91_MATRIX_M11PR		(3 << 12)	/* Master 11 Priority (in Register B) */
+
+#define AT91_MATRIX_MRCR	(AT91_MATRIX + 0x100)	/* Master Remap Control Register */
+#define		AT91_MATRIX_RCB0		(1 << 0)	/* Remap Command for AHB Master 0 (ARM926EJ-S Instruction Master) */
+#define		AT91_MATRIX_RCB1		(1 << 1)	/* Remap Command for AHB Master 1 (ARM926EJ-S Data Master) */
+#define		AT91_MATRIX_RCB2		(1 << 2)
+#define		AT91_MATRIX_RCB3		(1 << 3)
+#define		AT91_MATRIX_RCB4		(1 << 4)
+#define		AT91_MATRIX_RCB5		(1 << 5)
+#define		AT91_MATRIX_RCB6		(1 << 6)
+#define		AT91_MATRIX_RCB7		(1 << 7)
+#define		AT91_MATRIX_RCB8		(1 << 8)
+#define		AT91_MATRIX_RCB9		(1 << 9)
+#define		AT91_MATRIX_RCB10		(1 << 10)
+#define		AT91_MATRIX_RCB11		(1 << 11)
+
+#define AT91_MATRIX_EBICSA	(AT91_MATRIX + 0x120)	/* EBI Chip Select Assignment Register */
+#define		AT91_MATRIX_EBI_CS1A		(1 << 1)	/* Chip Select 1 Assignment */
+#define			AT91_MATRIX_EBI_CS1A_SMC		(0 << 1)
+#define			AT91_MATRIX_EBI_CS1A_SDRAMC		(1 << 1)
+#define		AT91_MATRIX_EBI_CS3A		(1 << 3)	/* Chip Select 3 Assignment */
+#define			AT91_MATRIX_EBI_CS3A_SMC		(0 << 3)
+#define			AT91_MATRIX_EBI_CS3A_SMC_NANDFLASH	(1 << 3)
+#define		AT91_MATRIX_EBI_DBPUC		(1 << 8)	/* Data Bus Pull-up Configuration */
+#define			AT91_MATRIX_EBI_DBPU_ON			(0 << 8)
+#define			AT91_MATRIX_EBI_DBPU_OFF		(1 << 8)
+#define		AT91_MATRIX_EBI_VDDIOMSEL	(1 << 16)	/* Memory voltage selection */
+#define			AT91_MATRIX_EBI_VDDIOMSEL_1_8V		(0 << 16)
+#define			AT91_MATRIX_EBI_VDDIOMSEL_3_3V		(1 << 16)
+#define		AT91_MATRIX_EBI_EBI_IOSR	(1 << 17)	/* EBI I/O slew rate selection */
+#define			AT91_MATRIX_EBI_EBI_IOSR_REDUCED	(0 << 17)
+#define			AT91_MATRIX_EBI_EBI_IOSR_NORMAL		(1 << 17)
+#define		AT91_MATRIX_EBI_DDR_IOSR	(1 << 18)	/* DDR2 dedicated port I/O slew rate selection */
+#define			AT91_MATRIX_EBI_DDR_IOSR_REDUCED	(0 << 18)
+#define			AT91_MATRIX_EBI_DDR_IOSR_NORMAL		(1 << 18)
+#define		AT91_MATRIX_NFD0_SELECT		(1 << 24)	/* NAND Flash Data Bus Selection */
+#define			AT91_MATRIX_NFD0_ON_D0			(0 << 24)
+#define			AT91_MATRIX_NFD0_ON_D16			(1 << 24)
+#define		AT91_MATRIX_DDR_MP_EN		(1 << 25)	/* DDR Multi-port Enable */
+#define			AT91_MATRIX_MP_OFF			(0 << 25)
+#define			AT91_MATRIX_MP_ON			(1 << 25)
+
+#define AT91_MATRIX_WPMR	(AT91_MATRIX + 0x1E4)	/* Write Protect Mode Register */
+#define		AT91_MATRIX_WPMR_WPEN		(1 << 0)	/* Write Protect ENable */
+#define			AT91_MATRIX_WPMR_WP_WPDIS		(0 << 0)
+#define			AT91_MATRIX_WPMR_WP_WPEN		(1 << 0)
+#define		AT91_MATRIX_WPMR_WPKEY		(0xFFFFFF << 8)	/* Write Protect KEY */
+
+#define AT91_MATRIX_WPSR	(AT91_MATRIX + 0x1E8)	/* Write Protect Status Register */
+#define		AT91_MATRIX_WPSR_WPVS		(1 << 0)	/* Write Protect Violation Status */
+#define			AT91_MATRIX_WPSR_NO_WPV		(0 << 0)
+#define			AT91_MATRIX_WPSR_WPV		(1 << 0)
+#define		AT91_MATRIX_WPSR_WPVSRC		(0xFFFF << 8)	/* Write Protect Violation Source */
+
+#endif
diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index 3bef931..0700f21 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -27,6 +27,7 @@
 #define ARCH_ID_AT91SAM9G45	0x819b05a0
 #define ARCH_ID_AT91SAM9G45MRL	0x819b05a2	/* aka 9G45-ES2 & non ES lots */
 #define ARCH_ID_AT91SAM9G45ES	0x819b05a1	/* 9G45-ES (Engineering Sample) */
+#define ARCH_ID_AT91SAM9X5	0x819a05a0
 #define ARCH_ID_AT91CAP9	0x039A03A0
 
 #define ARCH_ID_AT91SAM9XE128	0x329973a0
@@ -55,6 +56,12 @@ static inline unsigned long at91_cpu_fully_identify(void)
 #define ARCH_EXID_AT91SAM9G46	0x00000003
 #define ARCH_EXID_AT91SAM9G45	0x00000004
 
+#define ARCH_EXID_AT91SAM9G15	0x00000000
+#define ARCH_EXID_AT91SAM9G35	0x00000001
+#define ARCH_EXID_AT91SAM9X35	0x00000002
+#define ARCH_EXID_AT91SAM9G25	0x00000003
+#define ARCH_EXID_AT91SAM9X25	0x00000004
+
 static inline unsigned long at91_exid_identify(void)
 {
 	return at91_sys_read(AT91_DBGU_EXID);
@@ -143,6 +150,27 @@ static inline unsigned long at91cap9_rev_identify(void)
 #define cpu_is_at91sam9m11()	(0)
 #endif
 
+#ifdef CONFIG_ARCH_AT91SAM9X5
+#define cpu_is_at91sam9x5()	(at91_cpu_identify() == ARCH_ID_AT91SAM9X5)
+#define cpu_is_at91sam9g15()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9G15))
+#define cpu_is_at91sam9g35()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9G35))
+#define cpu_is_at91sam9x35()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9X35))
+#define cpu_is_at91sam9g25()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9G25))
+#define cpu_is_at91sam9x25()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9X25))
+#else
+#define cpu_is_at91sam9x5()	(0)
+#define cpu_is_at91sam9g15()	(0)
+#define cpu_is_at91sam9g35()	(0)
+#define cpu_is_at91sam9x35()	(0)
+#define cpu_is_at91sam9g25()	(0)
+#define cpu_is_at91sam9x25()	(0)
+#endif
+
 #ifdef CONFIG_ARCH_AT91CAP9
 #define cpu_is_at91cap9()	(at91_cpu_identify() == ARCH_ID_AT91CAP9)
 #define cpu_is_at91cap9_revB()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_B)
-- 
1.7.4.1
