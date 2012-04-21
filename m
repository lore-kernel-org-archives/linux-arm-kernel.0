From: viresh.linux@gmail.com (Viresh Kumar)
Date: Sat, 21 Apr 2012 17:45:57 +0530
Subject: [PATCH V2 02/10] SPEAr13xx: Add header files
In-Reply-To: <cover.1335010373.git.viresh.kumar@st.com>
References: <cover.1335010373.git.viresh.kumar@st.com>
Message-ID: <87e909ab051e249dc3ff9de65058c9beec2c9cc9.1335010373.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic header files for SPEAr13xx Machines.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |   14 ++
 arch/arm/mach-spear13xx/include/mach/dma.h         |  128 ++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/generic.h     |   49 ++++++
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   19 +++
 arch/arm/mach-spear13xx/include/mach/hardware.h    |    1 +
 arch/arm/mach-spear13xx/include/mach/irqs.h        |   20 +++
 arch/arm/mach-spear13xx/include/mach/spear.h       |  161 ++++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 +++
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 +++
 9 files changed, 430 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/dma.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1310_misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1340_misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h

diff --git a/arch/arm/mach-spear13xx/include/mach/debug-macro.S b/arch/arm/mach-spear13xx/include/mach/debug-macro.S
new file mode 100644
index 0000000..ea15646
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/debug-macro.S
@@ -0,0 +1,14 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/debug-macro.S
+ *
+ * Debugging macro include header spear13xx machine family
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-spear13xx/include/mach/dma.h b/arch/arm/mach-spear13xx/include/mach/dma.h
new file mode 100644
index 0000000..383ab04
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/dma.h
@@ -0,0 +1,128 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/dma.h
+ *
+ * DMA information for SPEAr13xx machine family
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_DMA_H
+#define __MACH_DMA_H
+
+/* request id of all the peripherals */
+enum dma_master_info {
+	/* Accessible from only one master */
+	DMA_MASTER_MCIF = 0,
+	DMA_MASTER_FSMC = 1,
+	/* Accessible from both 0 & 1 */
+	DMA_MASTER_MEMORY = 0,
+	DMA_MASTER_ADC = 0,
+	DMA_MASTER_UART0 = 0,
+	DMA_MASTER_SSP0 = 0,
+	DMA_MASTER_I2C0 = 0,
+
+#ifdef CONFIG_MACH_SPEAR1310
+	/* Accessible from only one master */
+	SPEAR1310_DMA_MASTER_JPEG = 1,
+
+	/* Accessible from both 0 & 1 */
+	SPEAR1310_DMA_MASTER_I2S = 0,
+	SPEAR1310_DMA_MASTER_UART1 = 0,
+	SPEAR1310_DMA_MASTER_UART2 = 0,
+	SPEAR1310_DMA_MASTER_UART3 = 0,
+	SPEAR1310_DMA_MASTER_UART4 = 0,
+	SPEAR1310_DMA_MASTER_UART5 = 0,
+	SPEAR1310_DMA_MASTER_I2C1 = 0,
+	SPEAR1310_DMA_MASTER_I2C2 = 0,
+	SPEAR1310_DMA_MASTER_I2C3 = 0,
+	SPEAR1310_DMA_MASTER_I2C4 = 0,
+	SPEAR1310_DMA_MASTER_I2C5 = 0,
+	SPEAR1310_DMA_MASTER_I2C6 = 0,
+	SPEAR1310_DMA_MASTER_I2C7 = 0,
+	SPEAR1310_DMA_MASTER_SSP1 = 0,
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+	/* Accessible from only one master */
+	SPEAR1340_DMA_MASTER_I2S_PLAY = 1,
+	SPEAR1340_DMA_MASTER_I2S_REC = 1,
+	SPEAR1340_DMA_MASTER_I2C1 = 1,
+	SPEAR1340_DMA_MASTER_UART1 = 1,
+
+	/* following are accessible from both master 0 & 1 */
+	SPEAR1340_DMA_MASTER_SPDIF = 0,
+	SPEAR1340_DMA_MASTER_CAM = 1,
+	SPEAR1340_DMA_MASTER_VIDEO_IN = 0,
+	SPEAR1340_DMA_MASTER_MALI = 0,
+#endif
+};
+
+enum request_id {
+	DMA_REQ_ADC = 0,
+	DMA_REQ_SSP0_TX = 4,
+	DMA_REQ_SSP0_RX = 5,
+	DMA_REQ_UART0_TX = 6,
+	DMA_REQ_UART0_RX = 7,
+	DMA_REQ_I2C0_TX = 8,
+	DMA_REQ_I2C0_RX = 9,
+
+#ifdef CONFIG_MACH_SPEAR1310
+	SPEAR1310_DMA_REQ_FROM_JPEG = 2,
+	SPEAR1310_DMA_REQ_TO_JPEG = 3,
+	SPEAR1310_DMA_REQ_I2S_TX = 10,
+	SPEAR1310_DMA_REQ_I2S_RX = 11,
+
+	SPEAR1310_DMA_REQ_I2C1_RX = 0,
+	SPEAR1310_DMA_REQ_I2C1_TX = 1,
+	SPEAR1310_DMA_REQ_I2C2_RX = 2,
+	SPEAR1310_DMA_REQ_I2C2_TX = 3,
+	SPEAR1310_DMA_REQ_I2C3_RX = 4,
+	SPEAR1310_DMA_REQ_I2C3_TX = 5,
+	SPEAR1310_DMA_REQ_I2C4_RX = 6,
+	SPEAR1310_DMA_REQ_I2C4_TX = 7,
+	SPEAR1310_DMA_REQ_I2C5_RX = 8,
+	SPEAR1310_DMA_REQ_I2C5_TX = 9,
+	SPEAR1310_DMA_REQ_I2C6_RX = 10,
+	SPEAR1310_DMA_REQ_I2C6_TX = 11,
+	SPEAR1310_DMA_REQ_UART1_RX = 12,
+	SPEAR1310_DMA_REQ_UART1_TX = 13,
+	SPEAR1310_DMA_REQ_UART2_RX = 14,
+	SPEAR1310_DMA_REQ_UART2_TX = 15,
+	SPEAR1310_DMA_REQ_UART5_RX = 16,
+	SPEAR1310_DMA_REQ_UART5_TX = 17,
+	SPEAR1310_DMA_REQ_SSP1_RX = 18,
+	SPEAR1310_DMA_REQ_SSP1_TX = 19,
+	SPEAR1310_DMA_REQ_I2C7_RX = 20,
+	SPEAR1310_DMA_REQ_I2C7_TX = 21,
+	SPEAR1310_DMA_REQ_UART3_RX = 28,
+	SPEAR1310_DMA_REQ_UART3_TX = 29,
+	SPEAR1310_DMA_REQ_UART4_RX = 30,
+	SPEAR1310_DMA_REQ_UART4_TX = 31,
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+	SPEAR1340_DMA_REQ_SPDIF_TX = 2,
+	SPEAR1340_DMA_REQ_SPDIF_RX = 3,
+	SPEAR1340_DMA_REQ_I2S_TX = 10,
+	SPEAR1340_DMA_REQ_I2S_RX = 11,
+	SPEAR1340_DMA_REQ_UART1_TX = 12,
+	SPEAR1340_DMA_REQ_UART1_RX = 13,
+	SPEAR1340_DMA_REQ_I2C1_TX = 14,
+	SPEAR1340_DMA_REQ_I2C1_RX = 15,
+	SPEAR1340_DMA_REQ_CAM0_EVEN = 0,
+	SPEAR1340_DMA_REQ_CAM0_ODD = 1,
+	SPEAR1340_DMA_REQ_CAM1_EVEN = 2,
+	SPEAR1340_DMA_REQ_CAM1_ODD = 3,
+	SPEAR1340_DMA_REQ_CAM2_EVEN = 4,
+	SPEAR1340_DMA_REQ_CAM2_ODD = 5,
+	SPEAR1340_DMA_REQ_CAM3_EVEN = 6,
+	SPEAR1340_DMA_REQ_CAM3_ODD = 7,
+#endif
+};
+
+#endif /* __MACH_DMA_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
new file mode 100644
index 0000000..6d8c45b
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -0,0 +1,49 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/generic.h
+ *
+ * spear13xx machine family generic header file
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_GENERIC_H
+#define __MACH_GENERIC_H
+
+#include <linux/dmaengine.h>
+#include <asm/mach/time.h>
+
+/* Add spear13xx structure declarations here */
+extern struct sys_timer spear13xx_timer;
+extern struct pl022_ssp_controller pl022_plat_data;
+extern struct dw_dma_platform_data dmac_plat_data;
+extern struct dw_dma_slave cf_dma_priv;
+extern struct dw_dma_slave nand_read_dma_priv;
+extern struct dw_dma_slave nand_write_dma_priv;
+
+/* Add spear13xx family function declarations here */
+void __init spear_setup_of_timer(void);
+void __init spear13xx_map_io(void);
+void __init spear13xx_dt_init_irq(void);
+void __init spear13xx_l2x0_init(void);
+bool dw_dma_filter(struct dma_chan *chan, void *slave);
+void spear_restart(char, const char *);
+void spear13xx_secondary_startup(void);
+
+#ifdef CONFIG_MACH_SPEAR1310
+void __init spear1310_clk_init(void);
+#else
+static inline void spear1310_clk_init(void) {}
+#endif
+
+#ifdef CONFIG_MACH_SPEAR1340
+void __init spear1340_clk_init(void);
+#else
+static inline void spear1340_clk_init(void) {}
+#endif
+
+#endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/gpio.h b/arch/arm/mach-spear13xx/include/mach/gpio.h
new file mode 100644
index 0000000..cd6f4f8
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/gpio.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/gpio.h
+ *
+ * GPIO macros for SPEAr13xx machine family
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_GPIO_H
+#define __MACH_GPIO_H
+
+#include <plat/gpio.h>
+
+#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/hardware.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
new file mode 100644
index 0000000..f542a24
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -0,0 +1,20 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/irqs.h
+ *
+ * IRQ helper macros for spear13xx machine family
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_IRQS_H
+#define __MACH_IRQS_H
+
+#define IRQ_GIC_END			160
+#define NR_IRQS				IRQ_GIC_END
+
+#endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
new file mode 100644
index 0000000..57fb960
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -0,0 +1,161 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/spear.h
+ *
+ * spear13xx Machine family specific definition
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_SPEAR13XX_H
+#define __MACH_SPEAR13XX_H
+
+#include <asm/memory.h>
+
+#define PERIP_GRP2_BASE				UL(0xB3000000)
+#define VA_PERIP_GRP2_BASE			UL(0xFE000000)
+#define MCIF_SDHCI_BASE				UL(0xB3000000)
+#define SYSRAM0_BASE				UL(0xB3800000)
+#define VA_SYSRAM0_BASE				UL(0xFE800000)
+#define SYS_LOCATION				(VA_SYSRAM0_BASE + 0x600)
+
+#define PERIP_GRP1_BASE				UL(0xE0000000)
+#define VA_PERIP_GRP1_BASE			UL(0xFD000000)
+#define UART_BASE				UL(0xE0000000)
+#define VA_UART_BASE				UL(0xFD000000)
+#define SSP_BASE				UL(0xE0100000)
+#define MISC_BASE				UL(0xE0700000)
+#define VA_MISC_BASE				IOMEM(UL(0xFD700000))
+
+#define A9SM_AND_MPMC_BASE			UL(0xEC000000)
+#define VA_A9SM_AND_MPMC_BASE			UL(0xFC000000)
+
+/* A9SM peripheral offsets */
+#define A9SM_PERIP_BASE				UL(0xEC800000)
+#define VA_A9SM_PERIP_BASE			UL(0xFC800000)
+#define VA_SCU_BASE				(VA_A9SM_PERIP_BASE + 0x00)
+
+#define L2CC_BASE				UL(0xED000000)
+#define VA_L2CC_BASE				IOMEM(UL(0xFB000000))
+
+/* others */
+#define DMAC0_BASE				UL(0xEA800000)
+#define DMAC1_BASE				UL(0xEB000000)
+#define MCIF_CF_BASE				UL(0xB2800000)
+
+/* Devices present in SPEAr1310 */
+#ifdef CONFIG_MACH_SPEAR1310
+#define SPEAR1310_RAS_GRP1_BASE			UL(0xD8000000)
+#define VA_SPEAR1310_RAS_GRP1_BASE		UL(0xFA000000)
+#define SPEAR1310_RAS_BASE			UL(0xD8400000)
+#define VA_SPEAR1310_RAS_BASE			IOMEM(UL(0xFA400000))
+
+/* RAS Area Control Register */
+#define SPEAR1310_RAS_CTRL_REG0			(VA_SPEAR1310_RAS_BASE + 0x000)
+	#define SPEAR1310_GPT64_SYNC_ENB		0
+	#define SPEAR1310_GPT64_SYNC_ENB_MASK		1
+	#define SPEAR1310_GPT64_SYNC_ENB_SHIFT		31
+	#define SPEAR1310_SSP1_CS_SEL_CS0		0
+	#define SPEAR1310_SSP1_CS_SEL_CS1		1
+	#define SPEAR1310_SSP1_CS_SEL_MASK		3
+	#define SPEAR1310_SSP1_CS_SEL_SHIFT		30
+	#define SPEAR1310_SSP1_CS_VAL_MASK		1
+	#define SPEAR1310_SSP1_CS_VAL_SHIFT		28
+	#define SPEAR1310_SSP1_CS_CTL_HW		0
+	#define SPEAR1310_SSP1_CS_CTL_SW		1
+	#define SPEAR1310_SSP1_CS_CTL_MASK		1
+	#define SPEAR1310_SSP1_CS_CTL_SHIFT		27
+	#define SPEAR1310_SSP1_CLK_PCLK_VAL		0
+	#define SPEAR1310_SSP1_CLK_RAS_SYNT1_VAL	1
+	#define SPEAR1310_SSP1_CLK_RAS_PLCLK0_VAL	2
+	#define SPEAR1310_SSP1_CLK_MASK			3
+	#define SPEAR1310_SSP1_CLK_SHIFT		26
+	#define SPEAR1310_TDM_CLK_PLL3_VAL		0
+	#define SPEAR1310_TDM_CLK_RAS_SYNT1_VAL		1
+	#define SPEAR1310_TDM_CLK_MASK			1
+	#define SPEAR1310_TDM2_CLK_SHIFT		24
+	#define SPEAR1310_TDM1_CLK_SHIFT		23
+	#define SPEAR1310_I2C_CLK_PCLK_VAL		0
+	#define SPEAR1310_I2C_CLK_RAS_SYNT1_VAL		1
+	#define SPEAR1310_I2C_CLK_MASK			1
+	#define SPEAR1310_I2C7_CLK_SHIFT		22
+	#define SPEAR1310_I2C6_CLK_SHIFT		21
+	#define SPEAR1310_I2C5_CLK_SHIFT		20
+	#define SPEAR1310_I2C4_CLK_SHIFT		19
+	#define SPEAR1310_I2C3_CLK_SHIFT		18
+	#define SPEAR1310_I2C2_CLK_SHIFT		17
+	#define SPEAR1310_I2C1_CLK_SHIFT		16
+	#define SPEAR1310_GPT64_CLK_RAS_48M_VAL		0
+	#define SPEAR1310_GPT64_CLK_PCLK_VAL		1
+	#define SPEAR1310_GPT64_CLK_MASK		1
+	#define SPEAR1310_GPT64_CLK_SHIFT		15
+	#define SPEAR1310_UART_CLK_PCLK_VAL		0
+	#define SPEAR1310_UART_CLK_RAS_CLK_SYNT3	1
+	#define SPEAR1310_RAS_UART_CLK_MASK		1
+	#define SPEAR1310_UART5_CLK_SHIFT		14
+	#define SPEAR1310_UART4_CLK_SHIFT		13
+	#define SPEAR1310_UART3_CLK_SHIFT		12
+	#define SPEAR1310_UART2_CLK_SHIFT		11
+	#define SPEAR1310_UART1_CLK_SHIFT		10
+	#define SPEAR1310_PMX_GMAC_PCI_SEL_MASK		9 /* 0: GMAC, 1: PCI */
+	#define SPEAR1310_PCI_EXT_ARBITER_ENB		(1 << 8)
+	#define SPEAR1310_PCI_BUS_INT_ENB		7
+	#define SPEAR1310_PCI_INTR_STATUS		6
+	#define SPEAR1310_PCI_INTRX_ENB			5 /* 0: enb, 1: dsb */
+	#define SPEAR1310_PCI_PWR_STATE_CHG_ACK		4 /* 1: can change */
+	#define SPEAR1310_PCI_PME_VOLT_LEVEL		3 /* 0: Vaux, 1: Vcc */
+	#define SPEAR1310_PCI_INT_ARBITER_ENB		(1 << 2)
+	#define SPEAR1310_PCI_PME_STATUS		1
+	#define SPEAR1310_PCI_CLK_PLL3_VAL		0
+	#define SPEAR1310_PCI_CLK_RAS_SYNT2_VAL		1
+	#define SPEAR1310_PCI_CLK_MASK			1
+	#define SPEAR1310_PCI_CLK_SHIFT			0
+
+#define SPEAR1310_RAS_CTRL_REG1			(VA_SPEAR1310_RAS_BASE + 0x004)
+	#define SPEAR1310_RAS_TX50M_VAL			0x0	/* Only RMII */
+	#define SPEAR1310_RAS_TX125M_PAD_VAL		0x1	/* Only SMII */
+	#define SPEAR1310_RAS_PLL2_VAL			0x2
+	#define SPEAR1310_RAS_SYNTH0_VAL		0x3
+	#define SPEAR1310_PHY_CLK_MASK			0x3
+	#define SPEAR1310_RMII_PHY_CLK_SHIFT		0
+	#define SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT	2
+
+#define SPEAR1310_RAS_SW_CLK_CTRL		(VA_SPEAR1310_RAS_BASE + 0x0148)
+	#define SPEAR1310_CAN1_CLK_ENB			25
+	#define SPEAR1310_CAN0_CLK_ENB			24
+	#define SPEAR1310_GPT64_CLK_ENB			23
+	#define SPEAR1310_SSP1_CLK_ENB			22
+	#define SPEAR1310_I2C7_CLK_ENB			21
+	#define SPEAR1310_I2C6_CLK_ENB			20
+	#define SPEAR1310_I2C5_CLK_ENB			19
+	#define SPEAR1310_I2C4_CLK_ENB			18
+	#define SPEAR1310_I2C3_CLK_ENB			17
+	#define SPEAR1310_I2C2_CLK_ENB			16
+	#define SPEAR1310_I2C1_CLK_ENB			15
+	#define SPEAR1310_UART5_CLK_ENB			14
+	#define SPEAR1310_UART4_CLK_ENB			13
+	#define SPEAR1310_UART3_CLK_ENB			12
+	#define SPEAR1310_UART2_CLK_ENB			11
+	#define SPEAR1310_UART1_CLK_ENB			10
+	#define SPEAR1310_RS485_1_CLK_ENB		9
+	#define SPEAR1310_RS485_0_CLK_ENB		8
+	#define SPEAR1310_TDM2_CLK_ENB			7
+	#define SPEAR1310_TDM1_CLK_ENB			6
+	#define SPEAR1310_PCI_CLK_ENB			5
+	#define SPEAR1310_GMII_CLK_ENB			4
+	#define SPEAR1310_MII2_CLK_ENB			3
+	#define SPEAR1310_MII1_CLK_ENB			2
+	#define SPEAR1310_MII0_CLK_ENB			1
+	#define SPEAR1310_ESRAM_CLK_ENB			0
+
+#endif /* CONFIG_MACH_SPEAR1310 */
+
+/* Debug uart for linux, will be used for debug and uncompress messages */
+#define SPEAR_DBG_UART_BASE			UART_BASE
+#define VA_SPEAR_DBG_UART_BASE			VA_UART_BASE
+
+#endif /* __MACH_SPEAR13XX_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1310_misc_regs.h b/arch/arm/mach-spear13xx/include/mach/spear1310_misc_regs.h
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1340_misc_regs.h b/arch/arm/mach-spear13xx/include/mach/spear1340_misc_regs.h
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/mach-spear13xx/include/mach/timex.h b/arch/arm/mach-spear13xx/include/mach/timex.h
new file mode 100644
index 0000000..31af3e8
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/timex.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear3xx/include/mach/timex.h
+ *
+ * SPEAr3XX machine family specific timex definitions
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_TIMEX_H
+#define __MACH_TIMEX_H
+
+#include <plat/timex.h>
+
+#endif /* __MACH_TIMEX_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/uncompress.h b/arch/arm/mach-spear13xx/include/mach/uncompress.h
new file mode 100644
index 0000000..c784089
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/uncompress.h
@@ -0,0 +1,19 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/uncompress.h
+ *
+ * Serial port stubs for kernel decompress status messages
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_UNCOMPRESS_H
+#define __MACH_UNCOMPRESS_H
+
+#include <plat/uncompress.h>
+
+#endif /* __MACH_UNCOMPRESS_H */
-- 
1.7.9
