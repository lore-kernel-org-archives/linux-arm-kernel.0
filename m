From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:49 +0800
Subject: [PATCH 13/13] ARM: mxs: remove unused headers
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-14-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the stuff in the headers are used nowhere now.  Move a few
things that are useful for mach-mxs.c into there and remove the headers.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/digctl.h |   22 ---
 arch/arm/mach-mxs/include/mach/mx23.h   |  169 -----------------------
 arch/arm/mach-mxs/include/mach/mx28.h   |  225 -------------------------------
 arch/arm/mach-mxs/include/mach/mxs.h    |  115 ----------------
 arch/arm/mach-mxs/mach-mxs.c            |   29 +++-
 5 files changed, 27 insertions(+), 533 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mx23.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mx28.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mxs.h

diff --git a/arch/arm/mach-mxs/include/mach/digctl.h b/arch/arm/mach-mxs/include/mach/digctl.h
deleted file mode 100644
index 1796406..0000000
--- a/arch/arm/mach-mxs/include/mach/digctl.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_DIGCTL_H__
-#define __MACH_DIGCTL_H__
-
-/* MXS DIGCTL SAIF CLKMUX */
-#define MXS_DIGCTL_SAIF_CLKMUX_DIRECT		0x0
-#define MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT	0x1
-#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
-#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
-
-#define HW_DIGCTL_CTRL			0x0
-#define  BP_DIGCTL_CTRL_SAIF_CLKMUX	10
-#define  BM_DIGCTL_CTRL_SAIF_CLKMUX	(0x3 << 10)
-#define HW_DIGCTL_CHIPID		0x310
-#endif
diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
deleted file mode 100644
index 599094b..0000000
--- a/arch/arm/mach-mxs/include/mach/mx23.h
+++ /dev/null
@@ -1,169 +0,0 @@
-/*
- * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef __MACH_MX23_H__
-#define __MACH_MX23_H__
-
-#include <mach/mxs.h>
-
-/*
- * OCRAM
- */
-#define MX23_OCRAM_BASE_ADDR		0x00000000
-#define MX23_OCRAM_SIZE			SZ_32K
-
-/*
- * IO
- */
-#define MX23_IO_BASE_ADDR		0x80000000
-#define MX23_IO_SIZE			SZ_1M
-
-#define MX23_ICOLL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x000000)
-#define MX23_APBH_DMA_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x004000)
-#define MX23_BCH_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x00a000)
-#define MX23_GPMI_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x00c000)
-#define MX23_SSP1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x010000)
-#define MX23_PINCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x018000)
-#define MX23_DIGCTL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x01c000)
-#define MX23_ETM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x020000)
-#define MX23_APBX_DMA_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x024000)
-#define MX23_DCP_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x028000)
-#define MX23_PXP_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x02a000)
-#define MX23_OCOTP_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x02c000)
-#define MX23_AXI_AHB0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x02e000)
-#define MX23_LCDIF_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x030000)
-#define MX23_SSP2_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x034000)
-#define MX23_TVENC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x038000)
-#define MX23_CLKCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x040000)
-#define MX23_SAIF0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x042000)
-#define MX23_POWER_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x044000)
-#define MX23_SAIF1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x046000)
-#define MX23_AUDIOOUT_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x048000)
-#define MX23_AUDIOIN_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x04c000)
-#define MX23_LRADC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x050000)
-#define MX23_SPDIF_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x054000)
-#define MX23_I2C_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x058000)
-#define MX23_RTC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x05c000)
-#define MX23_PWM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x064000)
-#define MX23_TIMROT_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x068000)
-#define MX23_AUART1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06c000)
-#define MX23_AUART2_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06e000)
-#define MX23_DUART_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x070000)
-#define MX23_USBPHY_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x07c000)
-#define MX23_USBCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x080000)
-#define MX23_DRAM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x0e0000)
-
-#define MX23_IO_P2V(x)			MXS_IO_P2V(x)
-#define MX23_IO_ADDRESS(x)		IOMEM(MX23_IO_P2V(x))
-
-/*
- * IRQ
- */
-#define MX23_INT_DUART			0
-#define MX23_INT_COMMS_RX		1
-#define MX23_INT_COMMS_TX		1
-#define MX23_INT_SSP2_ERROR		2
-#define MX23_INT_VDD5V			3
-#define MX23_INT_HEADPHONE_SHORT	4
-#define MX23_INT_DAC_DMA		5
-#define MX23_INT_DAC_ERROR		6
-#define MX23_INT_ADC_DMA		7
-#define MX23_INT_ADC_ERROR		8
-#define MX23_INT_SPDIF_DMA		9
-#define MX23_INT_SAIF2_DMA		9
-#define MX23_INT_SPDIF_ERROR		10
-#define MX23_INT_SAIF1_IRQ		10
-#define MX23_INT_SAIF2_IRQ		10
-#define MX23_INT_USB_CTRL		11
-#define MX23_INT_USB_WAKEUP		12
-#define MX23_INT_GPMI_DMA		13
-#define MX23_INT_SSP1_DMA		14
-#define MX23_INT_SSP1_ERROR		15
-#define MX23_INT_GPIO0			16
-#define MX23_INT_GPIO1			17
-#define MX23_INT_GPIO2			18
-#define MX23_INT_SAIF1_DMA		19
-#define MX23_INT_SSP2_DMA		20
-#define MX23_INT_ECC8_IRQ		21
-#define MX23_INT_RTC_ALARM		22
-#define MX23_INT_AUART1_TX_DMA		23
-#define MX23_INT_AUART1			24
-#define MX23_INT_AUART1_RX_DMA		25
-#define MX23_INT_I2C_DMA		26
-#define MX23_INT_I2C_ERROR		27
-#define MX23_INT_TIMER0			28
-#define MX23_INT_TIMER1			29
-#define MX23_INT_TIMER2			30
-#define MX23_INT_TIMER3			31
-#define MX23_INT_BATT_BRNOUT		32
-#define MX23_INT_VDDD_BRNOUT		33
-#define MX23_INT_VDDIO_BRNOUT		34
-#define MX23_INT_VDD18_BRNOUT		35
-#define MX23_INT_TOUCH_DETECT		36
-#define MX23_INT_LRADC_CH0		37
-#define MX23_INT_LRADC_CH1		38
-#define MX23_INT_LRADC_CH2		39
-#define MX23_INT_LRADC_CH3		40
-#define MX23_INT_LRADC_CH4		41
-#define MX23_INT_LRADC_CH5		42
-#define MX23_INT_LRADC_CH6		43
-#define MX23_INT_LRADC_CH7		44
-#define MX23_INT_LCDIF_DMA		45
-#define MX23_INT_LCDIF_ERROR		46
-#define MX23_INT_DIGCTL_DEBUG_TRAP	47
-#define MX23_INT_RTC_1MSEC		48
-#define MX23_INT_DRI_DMA		49
-#define MX23_INT_DRI_ATTENTION		50
-#define MX23_INT_GPMI_ATTENTION		51
-#define MX23_INT_IR			52
-#define MX23_INT_DCP_VMI		53
-#define MX23_INT_DCP			54
-#define MX23_INT_BCH			56
-#define MX23_INT_PXP			57
-#define MX23_INT_AUART2_TX_DMA		58
-#define MX23_INT_AUART2			59
-#define MX23_INT_AUART2_RX_DMA		60
-#define MX23_INT_VDAC_DETECT		61
-#define MX23_INT_VDD5V_DROOP		64
-#define MX23_INT_DCDC4P2_BO		65
-
-/*
- * APBH DMA
- */
-#define MX23_DMA_SSP1			1
-#define MX23_DMA_SSP2			2
-#define MX23_DMA_GPMI0			4
-#define MX23_DMA_GPMI1			5
-#define MX23_DMA_GPMI2			6
-#define MX23_DMA_GPMI3			7
-
-/*
- * APBX DMA
- */
-#define MX23_DMA_ADC			0
-#define MX23_DMA_DAC			1
-#define MX23_DMA_SPDIF			2
-#define MX23_DMA_I2C			3
-#define MX23_DMA_SAIF0			4
-#define MX23_DMA_UART0_RX		6
-#define MX23_DMA_UART0_TX		7
-#define MX23_DMA_UART1_RX		8
-#define MX23_DMA_UART1_TX		9
-#define MX23_DMA_SAIF1			10
-
-#endif /* __MACH_MX23_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
deleted file mode 100644
index 30c7990..0000000
--- a/arch/arm/mach-mxs/include/mach/mx28.h
+++ /dev/null
@@ -1,225 +0,0 @@
-/*
- * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef __MACH_MX28_H__
-#define __MACH_MX28_H__
-
-#include <mach/mxs.h>
-
-/*
- * OCRAM
- */
-#define MX28_OCRAM_BASE_ADDR		0x00000000
-#define MX28_OCRAM_SIZE			SZ_128K
-
-/*
- * IO
- */
-#define MX28_IO_BASE_ADDR		0x80000000
-#define MX28_IO_SIZE			SZ_1M
-
-#define MX28_ICOLL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x000000)
-#define MX28_HSADC_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x002000)
-#define MX28_APBH_DMA_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x004000)
-#define MX28_PERFMON_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x006000)
-#define MX28_BCH_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x00a000)
-#define MX28_GPMI_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x00c000)
-#define MX28_SSP0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x010000)
-#define MX28_SSP1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x012000)
-#define MX28_SSP2_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x014000)
-#define MX28_SSP3_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x016000)
-#define MX28_PINCTRL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x018000)
-#define MX28_DIGCTL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x01c000)
-#define MX28_ETM_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x022000)
-#define MX28_APBX_DMA_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x024000)
-#define MX28_DCP_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x028000)
-#define MX28_PXP_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x02a000)
-#define MX28_OCOTP_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x02c000)
-#define MX28_AXI_AHB0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x02e000)
-#define MX28_LCDIF_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x030000)
-#define MX28_CAN0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x032000)
-#define MX28_CAN1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x034000)
-#define MX28_SIMDBG_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c000)
-#define MX28_SIMGPMISEL_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x03c200)
-#define MX28_SIMSSPSEL_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x03c300)
-#define MX28_SIMMEMSEL_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x03c400)
-#define MX28_GPIOMON_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c500)
-#define MX28_SIMENET_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c700)
-#define MX28_ARMJTAG_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c800)
-#define MX28_CLKCTRL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x040000)
-#define MX28_SAIF0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x042000)
-#define MX28_POWER_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x044000)
-#define MX28_SAIF1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x046000)
-#define MX28_LRADC_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x050000)
-#define MX28_SPDIF_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x054000)
-#define MX28_RTC_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x056000)
-#define MX28_I2C0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x058000)
-#define MX28_I2C1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x05a000)
-#define MX28_PWM_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x064000)
-#define MX28_TIMROT_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x068000)
-#define MX28_AUART0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x06a000)
-#define MX28_AUART1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x06c000)
-#define MX28_AUART2_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x06e000)
-#define MX28_AUART3_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x070000)
-#define MX28_AUART4_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x072000)
-#define MX28_DUART_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x074000)
-#define MX28_USBPHY0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x07C000)
-#define MX28_USBPHY1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x07e000)
-#define MX28_USBCTRL0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x080000)
-#define MX28_USBCTRL1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x090000)
-#define MX28_DFLPT_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x0c0000)
-#define MX28_DRAM_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x0e0000)
-#define MX28_ENET_MAC0_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x0f0000)
-#define MX28_ENET_MAC1_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x0f4000)
-
-#define MX28_IO_P2V(x)			MXS_IO_P2V(x)
-#define MX28_IO_ADDRESS(x)		IOMEM(MX28_IO_P2V(x))
-
-/*
- * IRQ
- */
-#define MX28_INT_BATT_BRNOUT		0
-#define MX28_INT_VDDD_BRNOUT		1
-#define MX28_INT_VDDIO_BRNOUT		2
-#define MX28_INT_VDDA_BRNOUT		3
-#define MX28_INT_VDD5V_DROOP		4
-#define MX28_INT_DCDC4P2_BRNOUT		5
-#define MX28_INT_VDD5V			6
-#define MX28_INT_CAN0			8
-#define MX28_INT_CAN1			9
-#define MX28_INT_LRADC_TOUCH		10
-#define MX28_INT_HSADC			13
-#define MX28_INT_LRADC_THRESH0		14
-#define MX28_INT_LRADC_THRESH1		15
-#define MX28_INT_LRADC_CH0		16
-#define MX28_INT_LRADC_CH1		17
-#define MX28_INT_LRADC_CH2		18
-#define MX28_INT_LRADC_CH3		19
-#define MX28_INT_LRADC_CH4		20
-#define MX28_INT_LRADC_CH5		21
-#define MX28_INT_LRADC_CH6		22
-#define MX28_INT_LRADC_CH7		23
-#define MX28_INT_LRADC_BUTTON0		24
-#define MX28_INT_LRADC_BUTTON1		25
-#define MX28_INT_PERFMON		27
-#define MX28_INT_RTC_1MSEC		28
-#define MX28_INT_RTC_ALARM		29
-#define MX28_INT_COMMS			31
-#define MX28_INT_EMI_ERR		32
-#define MX28_INT_LCDIF			38
-#define MX28_INT_PXP			39
-#define MX28_INT_BCH			41
-#define MX28_INT_GPMI			42
-#define MX28_INT_SPDIF_ERROR		45
-#define MX28_INT_DUART			47
-#define MX28_INT_TIMER0			48
-#define MX28_INT_TIMER1			49
-#define MX28_INT_TIMER2			50
-#define MX28_INT_TIMER3			51
-#define MX28_INT_DCP_VMI		52
-#define MX28_INT_DCP			53
-#define MX28_INT_DCP_SECURE		54
-#define MX28_INT_SAIF1			58
-#define MX28_INT_SAIF0			59
-#define MX28_INT_SPDIF_DMA		66
-#define MX28_INT_I2C0_DMA		68
-#define MX28_INT_I2C1_DMA		69
-#define MX28_INT_AUART0_RX_DMA		70
-#define MX28_INT_AUART0_TX_DMA		71
-#define MX28_INT_AUART1_RX_DMA		72
-#define MX28_INT_AUART1_TX_DMA		73
-#define MX28_INT_AUART2_RX_DMA		74
-#define MX28_INT_AUART2_TX_DMA		75
-#define MX28_INT_AUART3_RX_DMA		76
-#define MX28_INT_AUART3_TX_DMA		77
-#define MX28_INT_AUART4_RX_DMA		78
-#define MX28_INT_AUART4_TX_DMA		79
-#define MX28_INT_SAIF0_DMA		80
-#define MX28_INT_SAIF1_DMA		81
-#define MX28_INT_SSP0_DMA		82
-#define MX28_INT_SSP1_DMA		83
-#define MX28_INT_SSP2_DMA		84
-#define MX28_INT_SSP3_DMA		85
-#define MX28_INT_LCDIF_DMA		86
-#define MX28_INT_HSADC_DMA		87
-#define MX28_INT_GPMI_DMA		88
-#define MX28_INT_DIGCTL_DEBUG_TRAP	89
-#define MX28_INT_USB1			92
-#define MX28_INT_USB0			93
-#define MX28_INT_USB1_WAKEUP		94
-#define MX28_INT_USB0_WAKEUP		95
-#define MX28_INT_SSP0_ERROR		96
-#define MX28_INT_SSP1_ERROR		97
-#define MX28_INT_SSP2_ERROR		98
-#define MX28_INT_SSP3_ERROR		99
-#define MX28_INT_ENET_SWI		100
-#define MX28_INT_ENET_MAC0		101
-#define MX28_INT_ENET_MAC1		102
-#define MX28_INT_ENET_MAC0_1588		103
-#define MX28_INT_ENET_MAC1_1588		104
-#define MX28_INT_I2C1_ERROR		110
-#define MX28_INT_I2C0_ERROR		111
-#define MX28_INT_AUART0			112
-#define MX28_INT_AUART1			113
-#define MX28_INT_AUART2			114
-#define MX28_INT_AUART3			115
-#define MX28_INT_AUART4			116
-#define MX28_INT_GPIO4			123
-#define MX28_INT_GPIO3			124
-#define MX28_INT_GPIO2			125
-#define MX28_INT_GPIO1			126
-#define MX28_INT_GPIO0			127
-
-/*
- * APBH DMA
- */
-#define MX28_DMA_SSP0			0
-#define MX28_DMA_SSP1			1
-#define MX28_DMA_SSP2			2
-#define MX28_DMA_SSP3			3
-#define MX28_DMA_GPMI0			4
-#define MX28_DMA_GPMI1			5
-#define MX28_DMA_GPMI2			6
-#define MX28_DMA_GPMI3			7
-#define MX28_DMA_GPMI4			8
-#define MX28_DMA_GPMI5			9
-#define MX28_DMA_GPMI6			10
-#define MX28_DMA_GPMI7			11
-#define MX28_DMA_HSADC			12
-#define MX28_DMA_LCDIF			13
-
-/*
- * APBX DMA
- */
-#define MX28_DMA_AUART4_RX		0
-#define MX28_DMA_AUART4_TX		1
-#define MX28_DMA_SPDIF_TX		2
-#define MX28_DMA_SAIF0			4
-#define MX28_DMA_SAIF1			5
-#define MX28_DMA_I2C0			6
-#define MX28_DMA_I2C1			7
-#define MX28_DMA_AUART0_RX		8
-#define MX28_DMA_AUART0_TX		9
-#define MX28_DMA_AUART1_RX		10
-#define MX28_DMA_AUART1_TX		11
-#define MX28_DMA_AUART2_RX		12
-#define MX28_DMA_AUART2_TX		13
-#define MX28_DMA_AUART3_RX		14
-#define MX28_DMA_AUART3_TX		15
-
-#endif /* __MACH_MX28_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
deleted file mode 100644
index 5820b04..0000000
--- a/arch/arm/mach-mxs/include/mach/mxs.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef __MACH_MXS_H__
-#define __MACH_MXS_H__
-
-#ifndef __ASSEMBLER__
-#include <linux/io.h>
-#endif
-#include <mach/digctl.h>
-
-/*
- * IO addresses common to MXS-based
- */
-#define MXS_IO_BASE_ADDR		0x80000000
-#define MXS_IO_SIZE			SZ_1M
-
-#define MXS_ICOLL_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x000000)
-#define MXS_APBH_DMA_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x004000)
-#define MXS_BCH_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x00a000)
-#define MXS_GPMI_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x00c000)
-#define MXS_PINCTRL_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x018000)
-#define MXS_DIGCTL_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x01c000)
-#define MXS_APBX_DMA_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x024000)
-#define MXS_DCP_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x028000)
-#define MXS_PXP_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x02a000)
-#define MXS_OCOTP_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x02c000)
-#define MXS_AXI_AHB0_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x02e000)
-#define MXS_LCDIF_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x030000)
-#define MXS_CLKCTRL_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x040000)
-#define MXS_SAIF0_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x042000)
-#define MXS_POWER_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x044000)
-#define MXS_SAIF1_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x046000)
-#define MXS_LRADC_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x050000)
-#define MXS_SPDIF_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x054000)
-#define MXS_I2C0_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x058000)
-#define MXS_PWM_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x064000)
-#define MXS_TIMROT_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x068000)
-#define MXS_AUART1_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x06c000)
-#define MXS_AUART2_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x06e000)
-#define MXS_DRAM_BASE_ADDR		(MXS_IO_BASE_ADDR + 0x0e0000)
-
-/*
- * It maps the whole address space to [0xf4000000, 0xf50fffff].
- *
- *	OCRAM	0x00000000+0x020000	->	0xf4000000+0x020000
- *	IO	0x80000000+0x100000	->	0xf5000000+0x100000
- */
-#define MXS_IO_P2V(x)	(0xf4000000 +					\
-			(((x) & 0x80000000) >> 7) +			\
-			(((x) & 0x000fffff)))
-
-#define MXS_IO_ADDRESS(x)	IOMEM(MXS_IO_P2V(x))
-
-#define mxs_map_entry(soc, name, _type)	{				\
-	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
-	.pfn = __phys_to_pfn(soc ## _ ## name ## _BASE_ADDR),		\
-	.length = soc ## _ ## name ## _SIZE,				\
-	.type = _type,							\
-}
-
-#define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
-
-#define MXS_SET_ADDR		0x4
-#define MXS_CLR_ADDR		0x8
-#define MXS_TOG_ADDR		0xc
-
-#ifndef __ASSEMBLER__
-static inline void __mxs_setl(u32 mask, void __iomem *reg)
-{
-	__raw_writel(mask, reg + MXS_SET_ADDR);
-}
-
-static inline void __mxs_clrl(u32 mask, void __iomem *reg)
-{
-	__raw_writel(mask, reg + MXS_CLR_ADDR);
-}
-
-static inline void __mxs_togl(u32 mask, void __iomem *reg)
-{
-	__raw_writel(mask, reg + MXS_TOG_ADDR);
-}
-
-/*
- * MXS CPU types
- */
-#define MXS_CHIPID (MXS_IO_ADDRESS(MXS_DIGCTL_BASE_ADDR) + HW_DIGCTL_CHIPID)
-
-static inline int cpu_is_mx23(void)
-{
-	return ((__raw_readl(MXS_CHIPID) >> 16) == 0x3780);
-}
-
-static inline int cpu_is_mx28(void)
-{
-	return ((__raw_readl(MXS_CHIPID) >> 16) == 0x2800);
-}
-#endif
-
-#endif /* __MACH_MXS_H__ */
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index b74f450..2d93376 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -31,8 +31,33 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
-#include <mach/digctl.h>
-#include <mach/mxs.h>
+
+/* MXS DIGCTL SAIF CLKMUX */
+#define MXS_DIGCTL_SAIF_CLKMUX_DIRECT		0x0
+#define MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT	0x1
+#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0		0x2
+#define MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1		0x3
+
+#define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
+
+#define MXS_SET_ADDR		0x4
+#define MXS_CLR_ADDR		0x8
+#define MXS_TOG_ADDR		0xc
+
+static inline void __mxs_setl(u32 mask, void __iomem *reg)
+{
+	__raw_writel(mask, reg + MXS_SET_ADDR);
+}
+
+static inline void __mxs_clrl(u32 mask, void __iomem *reg)
+{
+	__raw_writel(mask, reg + MXS_CLR_ADDR);
+}
+
+static inline void __mxs_togl(u32 mask, void __iomem *reg)
+{
+	__raw_writel(mask, reg + MXS_TOG_ADDR);
+}
 
 static struct fb_videomode mx23evk_video_modes[] = {
 	{
-- 
1.7.9.5
