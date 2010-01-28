From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 27 Jan 2010 17:43:30 -0800
Subject: [PATCH 12/13] ARM: LPC32XX: architecture header files
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1264643011-17390-13-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Header files used for the LCP32XX arch and support platforms

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/include/mach/board.h      |   27 +
 arch/arm/mach-lpc32xx/include/mach/clkdev.h     |   29 +
 arch/arm/mach-lpc32xx/include/mach/gpio.h       |   78 +++
 arch/arm/mach-lpc32xx/include/mach/hardware.h   |   41 ++
 arch/arm/mach-lpc32xx/include/mach/i2c.h        |   63 ++
 arch/arm/mach-lpc32xx/include/mach/io.h         |   31 +
 arch/arm/mach-lpc32xx/include/mach/irqs.h       |  118 ++++
 arch/arm/mach-lpc32xx/include/mach/memory.h     |   32 +
 arch/arm/mach-lpc32xx/include/mach/platform.h   |  735 +++++++++++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/system.h     |   56 ++
 arch/arm/mach-lpc32xx/include/mach/timex.h      |   33 +
 arch/arm/mach-lpc32xx/include/mach/uncompress.h |  114 ++++
 arch/arm/mach-lpc32xx/include/mach/vmalloc.h    |   28 +
 13 files changed, 1385 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/board.h b/arch/arm/mach-lpc32xx/include/mach/board.h
new file mode 100644
index 0000000..057774a
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/board.h
@@ -0,0 +1,27 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/board.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifndef __ASM_ARCH_BOARD_H
+#define __ASM_ARCH_BOARD_H
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/clkdev.h b/arch/arm/mach-lpc32xx/include/mach/clkdev.h
new file mode 100644
index 0000000..3dd9d0d
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/clkdev.h
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/clkdev.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_CLKDEV_H
+#define __ASM_ARCH_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
new file mode 100644
index 0000000..8df2198
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -0,0 +1,78 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/gpio.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+/*
+ * Note!
+ * Muxed GP pins need to be setup to the GP state in the board level
+ * code prior to using this driver.
+ * GPI pins : 28xP3 group
+ * GPO pins : 24xP3 group
+ * GPIO pins: 8xP0 group, 24xP1 group, 13xP2 group, 6xP3 group
+ */
+
+#define GPIO_P0_MAX 8
+#define GPIO_P1_MAX 24
+#define GPIO_P2_MAX 13
+#define GPIO_P3_MAX 6
+#define GPI_P3_MAX 28
+#define GPO_P3_MAX 24
+
+#define GPIO_P0_GRP 0
+#define GPIO_P1_GRP (GPIO_P0_GRP + GPIO_P0_MAX)
+#define GPIO_P2_GRP (GPIO_P1_GRP + GPIO_P1_MAX)
+#define GPIO_P3_GRP (GPIO_P2_GRP + GPIO_P2_MAX)
+#define GPI_P3_GRP (GPIO_P3_GRP + GPIO_P3_MAX)
+#define GPO_P3_GRP (GPI_P3_GRP + GPI_P3_MAX)
+
+/*
+ * A specific GPIO can be selected with this macro
+ * ie, GPIO_05 can be selected with LPC32XX_GPIO(GPIO_P3_GRP, 5)
+ * See the LPC32x0 User's guide for GPIO group numbers
+ */
+#define LPC32XX_GPIO(x, y) ((x) + (y))
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+static inline int gpio_cansleep(unsigned gpio)
+{
+	return __gpio_cansleep(gpio);
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return __gpio_to_irq(gpio);
+}
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/hardware.h b/arch/arm/mach-lpc32xx/include/mach/hardware.h
new file mode 100644
index 0000000..3f4bffa
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/hardware.h
@@ -0,0 +1,41 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/hardware.h
+ *
+ * Copyright (c) 2005 MontaVista Software, Inc. <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+#include <asm/sizes.h>
+
+/*
+ * Start of virtual addresses for IO devices
+ */
+#define IO_BASE		0xF0000000
+
+#define io_p2v(x)	(IO_BASE | (((x) & 0xff000000) >> 4) |\
+			 ((x) & 0x000fffff))
+#define io_v2p(x)	((((x) & 0x0ff00000) << 4) | ((x) & 0x000fffff))
+
+/*
+ * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
+ */
+#define IO_ADDRESS(x)	(((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
+			 IO_BASE)
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/i2c.h b/arch/arm/mach-lpc32xx/include/mach/i2c.h
new file mode 100644
index 0000000..a2d810b
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/i2c.h
@@ -0,0 +1,63 @@
+/*
+ * PNX4008-specific tweaks for I2C IP3204 block
+ *
+ * Author: Vitaly Wool <vwool@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_ARCH_I2C_H__
+#define __ASM_ARCH_I2C_H__
+
+enum {
+	mstatus_tdi = 0x00000001,
+	mstatus_afi = 0x00000002,
+	mstatus_nai = 0x00000004,
+	mstatus_drmi = 0x00000008,
+	mstatus_active = 0x00000020,
+	mstatus_scl = 0x00000040,
+	mstatus_sda = 0x00000080,
+	mstatus_rff = 0x00000100,
+	mstatus_rfe = 0x00000200,
+	mstatus_tff = 0x00000400,
+	mstatus_tfe = 0x00000800,
+};
+
+enum {
+	mcntrl_tdie = 0x00000001,
+	mcntrl_afie = 0x00000002,
+	mcntrl_naie = 0x00000004,
+	mcntrl_drmie = 0x00000008,
+	mcntrl_daie = 0x00000020,
+	mcntrl_rffie = 0x00000040,
+	mcntrl_tffie = 0x00000080,
+	mcntrl_reset = 0x00000100,
+	mcntrl_cdbmode = 0x00000400,
+};
+
+enum {
+	rw_bit = 1 << 0,
+	start_bit = 1 << 8,
+	stop_bit = 1 << 9,
+};
+
+#define I2C_REG_RX(a)	((a)->ioaddr)		/* Rx FIFO reg (RO) */
+#define I2C_REG_TX(a)	((a)->ioaddr)		/* Tx FIFO reg (WO) */
+#define I2C_REG_STS(a)	((a)->ioaddr + 0x04)	/* Status reg (RO) */
+#define I2C_REG_CTL(a)	((a)->ioaddr + 0x08)	/* Ctl reg */
+#define I2C_REG_CKL(a)	((a)->ioaddr + 0x0c)	/* Clock divider low */
+#define I2C_REG_CKH(a)	((a)->ioaddr + 0x10)	/* Clock divider high */
+#define I2C_REG_ADR(a)	((a)->ioaddr + 0x14)	/* I2C address */
+#define I2C_REG_RFL(a)	((a)->ioaddr + 0x18)	/* Rx FIFO level (RO) */
+#define I2C_REG_TFL(a)	((a)->ioaddr + 0x1c)	/* Tx FIFO level (RO) */
+#define I2C_REG_RXB(a)	((a)->ioaddr + 0x20)	/* Num of bytes Rx-ed (RO) */
+#define I2C_REG_TXB(a)	((a)->ioaddr + 0x24)	/* Num of bytes Tx-ed (RO) */
+#define I2C_REG_TXS(a)	((a)->ioaddr + 0x28)	/* Tx slave FIFO (RO) */
+#define I2C_REG_STFL(a)	((a)->ioaddr + 0x2c)	/* Tx slave FIFO level (RO) */
+
+#define I2C_CHIP_NAME		"PNX4008-I2C"
+
+#endif				/* __ASM_ARCH_I2C_H___ */
diff --git a/arch/arm/mach-lpc32xx/include/mach/io.h b/arch/arm/mach-lpc32xx/include/mach/io.h
new file mode 100644
index 0000000..0da8713
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/io.h
@@ -0,0 +1,31 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/io.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT	0xffffffff
+
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/irqs.h b/arch/arm/mach-lpc32xx/include/mach/irqs.h
new file mode 100644
index 0000000..157a26c
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/irqs.h
@@ -0,0 +1,118 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/irqs.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARM_ARCH_IRQS_H
+#define __ASM_ARM_ARCH_IRQS_H
+
+/*
+ * MIC interrupts
+ */
+#define IRQ_SUB1IRQ		0
+#define IRQ_SUB2IRQ		1
+#define IRQ_PWM3		3
+#define IRQ_PWM4		4
+#define IRQ_HSTIMER		5
+#define IRQ_WATCH		6
+#define IRQ_UART_IIR3		7
+#define IRQ_UART_IIR4		8
+#define IRQ_UART_IIR5		9
+#define IRQ_UART_IIR6		10
+#define IRQ_FLASH		11
+#define IRQ_SD1			13
+#define IRQ_LCD			14
+#define IRQ_SD0			15
+#define IRQ_TIMER0		16
+#define IRQ_TIMER1		17
+#define IRQ_TIMER2		18
+#define IRQ_TIMER3		19
+#define IRQ_SSP0		20
+#define IRQ_SSP1		21
+#define IRQ_I2S0		22
+#define IRQ_I2S1		23
+#define IRQ_UART_IIR7		24
+#define IRQ_UART_IIR2		25
+#define IRQ_UART_IIR1		26
+#define IRQ_MSTIMER		27
+#define IRQ_DMA			28
+#define IRQ_ETHERNET		29
+#define IRQ_SUB1FIQ		30
+#define IRQ_SUB2FIQ		31
+
+/*
+ * SIC1 interrupts start at offset 32
+ */
+#define IRQ_JTAG_COMM_TX	(32 + 1)
+#define IRQ_JTAG_COMM_RX	(32 + 2)
+#define IRQ_GPI_11		(32 + 4)
+#define IRQ_TS_P		(32 + 6)
+#define IRQ_TS_IRQ		(32 + 7)
+#define IRQ_TS_AUX		(32 + 8)
+#define IRQ_SPI2		(32 + 12)
+#define IRQ_PLLUSB		(32 + 13)
+#define IRQ_PLLHCLK		(32 + 14)
+#define IRQ_PLL397		(32 + 17)
+#define IRQ_I2C_2		(32 + 18)
+#define IRQ_I2C_1		(32 + 19)
+#define IRQ_RTC			(32 + 20)
+#define IRQ_KEY			(32 + 22)
+#define IRQ_SPI1		(32 + 23)
+#define IRQ_SW			(32 + 24)
+#define IRQ_USB_OTG_TIMER	(32 + 25)
+#define IRQ_USB_OTG_ATX		(32 + 26)
+#define IRQ_USB_HOST		(32 + 27)
+#define IRQ_USB_DEV_DMA		(32 + 28)
+#define IRQ_USB_DEV_LP		(32 + 29)
+#define IRQ_USB_DEV_HP		(32 + 30)
+#define IRQ_USB_I2C		(32 + 31)
+
+/*
+ * SIC2 interrupts start at offset 64
+ */
+#define IRQ_GPIO_00		(64 + 0)
+#define IRQ_GPIO_01		(64 + 1)
+#define IRQ_GPIO_02		(64 + 2)
+#define IRQ_GPIO_03		(64 + 3)
+#define IRQ_GPIO_04		(64 + 4)
+#define IRQ_GPIO_05		(64 + 5)
+#define IRQ_SPI2_DATAIN		(64 + 6)
+#define IRQ_U2_HCTS		(64 + 7)
+#define IRQ_P0_P1_IRQ		(64 + 8)
+#define IRQ_GPI_08		(64 + 9)
+#define IRQ_GPI_09		(64 + 10)
+#define IRQ_GPI_10		(64 + 11)
+#define IRQ_U7_HCTS		(64 + 12)
+#define IRQ_GPI_07		(64 + 15)
+#define IRQ_SDIO		(64 + 18)
+#define IRQ_U5_RX		(64 + 19)
+#define IRQ_SPI1_DATAIN		(64 + 20)
+#define IRQ_GPI_00		(64 + 22)
+#define IRQ_GPI_01		(64 + 23)
+#define IRQ_GPI_02		(64 + 24)
+#define IRQ_GPI_03		(64 + 25)
+#define IRQ_GPI_04		(64 + 26)
+#define IRQ_GPI_05		(64 + 27)
+#define IRQ_GPI_06		(64 + 28)
+#define IRQ_SYSCLK		(64 + 31)
+
+#define NR_IRQS			96
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/memory.h b/arch/arm/mach-lpc32xx/include/mach/memory.h
new file mode 100644
index 0000000..b246973
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/memory.h
@@ -0,0 +1,32 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/memory.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset of bank 0
+ */
+#define PHYS_OFFSET	UL(0x80000000)
+
+#endif
+
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
new file mode 100644
index 0000000..48305a5
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -0,0 +1,735 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/platform.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_PLATFORM_H
+#define __ASM_ARCH_PLATFORM_H
+
+#define _SBF(f, v)			(((v)) << (f))
+#define _BIT(n)				(1 << (n))
+
+/*
+ * AHB 0 physical base addresses
+ */
+#define SLC_BASE			0x20020000
+#define SSP0_BASE			0x20084000
+#define SPI1_BASE			0x20088000
+#define SSP1_BASE			0x2008C000
+#define SPI2_BASE			0x20090000
+#define I2S0_BASE			0x20094000
+#define SD_BASE				0x20098000
+#define I2S1_BASE			0x2009C000
+#define MLC_BASE			0x200A8000
+#define AHB0_START			SLC_BASE
+#define AHB0_SIZE			((MLC_BASE - SLC_BASE) + SZ_4K)
+
+/*
+ * AHB 1 physical base addresses
+ */
+#define DMA_BASE			0x31000000
+#define USB_BASE			0x31020000
+#define USBH_BASE			0x31020000
+#define USB_OTG_BASE			0x31020000
+#define OTG_I2C_BASE			0x31020300
+#define LCD_BASE			0x31040000
+#define ETHERNET_BASE			0x31060000
+#define EMC_BASE			0x31080000
+#define ETB_CFG_BASE			0x310C0000
+#define ETB_DATA_BASE			0x310E0000
+#define AHB1_START			DMA_BASE
+#define AHB1_SIZE			((EMC_BASE - DMA_BASE) + SZ_4K)
+
+/*
+ * FAB physical base addresses
+ */
+#define CLK_PM_BASE			0x40004000
+#define MIC_BASE			0x40008000
+#define SIC1_BASE			0x4000C000
+#define SIC2_BASE			0x40010000
+#define HS_UART1_BASE			0x40014000
+#define HS_UART2_BASE			0x40018000
+#define HS_UART7_BASE			0x4001C000
+#define RTC_BASE			0x40024000
+#define RTC_RAM_BASE			0x40024080
+#define GPIO_BASE			0x40028000
+#define PWM3_BASE			0x4002C000
+#define PWM4_BASE			0x40030000
+#define MSTIM_BASE			0x40034000
+#define HSTIM_BASE			0x40038000
+#define WDTIM_BASE			0x4003C000
+#define DEBUG_CTRL_BASE			0x40040000
+#define TIMER0_BASE			0x40044000
+#define ADC_BASE			0x40048000
+#define TIMER1_BASE			0x4004C000
+#define KSCAN_BASE			0x40050000
+#define UART_CTRL_BASE			0x40054000
+#define TIMER2_BASE			0x40058000
+#define PWM1_BASE			0x4005C000
+#define PWM2_BASE			0x4005C004
+#define TIMER3_BASE			0x40060000
+
+/*
+ * APB physical base addresses
+ */
+
+#define UART3_BASE			0x40080000
+#define UART4_BASE			0x40088000
+#define UART5_BASE			0x40090000
+#define UART6_BASE			0x40098000
+#define I2C1_BASE			0x400A0000
+#define I2C2_BASE			0x400A8000
+
+/*
+ * FAB and APB base and sizing
+ */
+#define FABAPB_START			CLK_PM_BASE
+#define FABAPB_SIZE			((I2C2_BASE - CLK_PM_BASE) + SZ_4K)
+
+/*
+ * Internal memory Bases
+ */
+#define IRAM_BASE			0x08000000
+#define IROM_BASE			0x0C000000
+
+/*
+ * External Static Memory Bank Address Space Bases
+ */
+#define EMC_CS0_BASE			0xE0000000
+#define EMC_CS1_BASE			0xE1000000
+#define EMC_CS2_BASE			0xE2000000
+#define EMC_CS3_BASE			0xE3000000
+
+/*
+ * External SDRAM Memory Bank Address Space Bases
+ */
+#define EMC_DYCS0_BASE			0x80000000
+#define EMC_DYCS1_BASE			0xA0000000
+
+/*
+ * Clock and crystal information
+ */
+#define MAIN_OSC_FREQ			13000000
+#define CLOCK_OSC_FREQ			32768
+
+/*
+ * IRAM size
+*/
+#define LPC32XX_IRAM_SIZE 		CONFIG_ARCH_LPC32XX_IRAM_SIZE
+
+/*
+ * Clock and Power control register offsets
+ */
+#define CLKPWR_DEBUG_CTRL(x)		((x) + 0x000)
+#define CLKPWR_BOOTMAP(x)		((x) + 0x014)
+#define CLKPWR_P01_ER(x)		((x) + 0x018)
+#define CLKPWR_USBCLK_PDIV(x)		((x) + 0x01C)
+#define CLKPWR_INT_ER(x)		((x) + 0x020)
+#define CLKPWR_INT_RS(x)		((x) + 0x024)
+#define CLKPWR_INT_SR(x)		((x) + 0x028)
+#define CLKPWR_INT_AP(x)		((x) + 0x02C)
+#define CLKPWR_PIN_ER(x)		((x) + 0x030)
+#define CLKPWR_PIN_RS(x)		((x) + 0x034)
+#define CLKPWR_PIN_SR(x)		((x) + 0x038)
+#define CLKPWR_PIN_AP(x)		((x) + 0x03C)
+#define CLKPWR_HCLK_DIV(x)		((x) + 0x040)
+#define CLKPWR_PWR_CTRL(x)		((x) + 0x044)
+#define CLKPWR_PLL397_CTRL(x)		((x) + 0x048)
+#define CLKPWR_MAIN_OSC_CTRL(x)		((x) + 0x04C)
+#define CLKPWR_SYSCLK_CTRL(x)		((x) + 0x050)
+#define CLKPWR_LCDCLK_CTRL(x)		((x) + 0x054)
+#define CLKPWR_HCLKPLL_CTRL(x)		((x) + 0x058)
+#define CLKPWR_ADC_CLK_CTRL_1(x)	((x) + 0x060)
+#define CLKPWR_USB_CTRL(x)		((x) + 0x064)
+#define CLKPWR_SDRAMCLK_CTRL(x)		((x) + 0x068)
+#define CLKPWR_DDR_LAP_NOM(x)		((x) + 0x06C)
+#define CLKPWR_DDR_LAP_COUNT(x)		((x) + 0x070)
+#define CLKPWR_DDR_LAP_DELAY(x)		((x) + 0x074)
+#define CLKPWR_SSP_CLK_CTRL(x)		((x) + 0x078)
+#define CLKPWR_I2S_CLK_CTRL(x)		((x) + 0x07C)
+#define CLKPWR_MS_CTRL(x)		((x) + 0x080)
+#define CLKPWR_MACCLK_CTRL(x)		((x) + 0x090)
+#define CLKPWR_TEST_CLK_SEL(x)		((x) + 0x0A4)
+#define CLKPWR_SFW_INT(x)		((x) + 0x0A8)
+#define CLKPWR_I2C_CLK_CTRL(x)		((x) + 0x0AC)
+#define CLKPWR_KEY_CLK_CTRL(x)		((x) + 0x0B0)
+#define CLKPWR_ADC_CLK_CTRL(x)		((x) + 0x0B4)
+#define CLKPWR_PWM_CLK_CTRL(x)		((x) + 0x0B8)
+#define CLKPWR_TIMER_CLK_CTRL(x)	((x) + 0x0BC)
+#define CLKPWR_TIMERS_PWMS_CLK_CTRL_1(x) ((x) + 0x0C0)
+#define CLKPWR_SPI_CLK_CTRL(x)		((x) + 0x0C4)
+#define CLKPWR_NAND_CLK_CTRL(x)		((x) + 0x0C8)
+#define CLKPWR_UART3_CLK_CTRL(x)	((x) + 0x0D0)
+#define CLKPWR_UART4_CLK_CTRL(x)	((x) + 0x0D4)
+#define CLKPWR_UART5_CLK_CTRL(x)	((x) + 0x0D8)
+#define CLKPWR_UART6_CLK_CTRL(x)	((x) + 0x0DC)
+#define CLKPWR_IRDA_CLK_CTRL(x)		((x) + 0x0E0)
+#define CLKPWR_UART_CLK_CTRL(x)		((x) + 0x0E4)
+#define CLKPWR_DMA_CLK_CTRL(x)		((x) + 0x0E8)
+#define CLKPWR_AUTOCLOCK(x)		((x) + 0x0EC)
+#define CLKPWR_DEVID(x, y)		((x) + 0x130 + (y))
+
+/*
+ * clkpwr_debug_ctrl register definitions
+*/
+#define CLKPWR_VFP_CLOCK_ENABLE_BIT	_BIT(4)
+
+/*
+ * clkpwr_bootmap register definitions
+ */
+#define CLKPWR_BOOTMAP_SEL_BIT		_BIT(1)
+
+/*
+ * clkpwr_start_gpio register bit definitions
+ */
+#define CLKPWR_GPIOSRC_P1IO23_BIT	_BIT(31)
+#define CLKPWR_GPIOSRC_P1IO22_BIT	_BIT(30)
+#define CLKPWR_GPIOSRC_P1IO21_BIT	_BIT(29)
+#define CLKPWR_GPIOSRC_P1IO20_BIT	_BIT(28)
+#define CLKPWR_GPIOSRC_P1IO19_BIT	_BIT(27)
+#define CLKPWR_GPIOSRC_P1IO18_BIT	_BIT(26)
+#define CLKPWR_GPIOSRC_P1IO17_BIT	_BIT(25)
+#define CLKPWR_GPIOSRC_P1IO16_BIT	_BIT(24)
+#define CLKPWR_GPIOSRC_P1IO15_BIT	_BIT(23)
+#define CLKPWR_GPIOSRC_P1IO14_BIT	_BIT(22)
+#define CLKPWR_GPIOSRC_P1IO13_BIT	_BIT(21)
+#define CLKPWR_GPIOSRC_P1IO12_BIT	_BIT(20)
+#define CLKPWR_GPIOSRC_P1IO11_BIT	_BIT(19)
+#define CLKPWR_GPIOSRC_P1IO10_BIT	_BIT(18)
+#define CLKPWR_GPIOSRC_P1IO9_BIT	_BIT(17)
+#define CLKPWR_GPIOSRC_P1IO8_BIT	_BIT(16)
+#define CLKPWR_GPIOSRC_P1IO7_BIT	_BIT(15)
+#define CLKPWR_GPIOSRC_P1IO6_BIT	_BIT(14)
+#define CLKPWR_GPIOSRC_P1IO5_BIT	_BIT(13)
+#define CLKPWR_GPIOSRC_P1IO4_BIT	_BIT(12)
+#define CLKPWR_GPIOSRC_P1IO3_BIT	_BIT(11)
+#define CLKPWR_GPIOSRC_P1IO2_BIT	_BIT(10)
+#define CLKPWR_GPIOSRC_P1IO1_BIT	_BIT(9)
+#define CLKPWR_GPIOSRC_P1IO0_BIT	_BIT(8)
+#define CLKPWR_GPIOSRC_P0IO7_BIT	_BIT(7)
+#define CLKPWR_GPIOSRC_P0IO6_BIT	_BIT(6)
+#define CLKPWR_GPIOSRC_P0IO5_BIT	_BIT(5)
+#define CLKPWR_GPIOSRC_P0IO4_BIT	_BIT(4)
+#define CLKPWR_GPIOSRC_P0IO3_BIT	_BIT(3)
+#define CLKPWR_GPIOSRC_P0IO2_BIT	_BIT(2)
+#define CLKPWR_GPIOSRC_P0IO1_BIT	_BIT(1)
+#define CLKPWR_GPIOSRC_P0IO0_BIT	_BIT(0)
+
+/*
+ * clkpwr_usbclk_pdiv register definitions
+ */
+#define CLKPWR_SET_PLL_USBPDIV(n)	((n) & 0xF)
+#define CLKPWR_USBPDIV_PLL_MASK		0xF
+
+/*
+ * clkpwr_start_int, clkpwr_start_raw_sts_int, clkpwr_start_sts_int,
+ * clkpwr_start_pol_int, register bit definitions
+ */
+#define CLKPWR_INTSRC_ADC_BIT		_BIT(31)
+#define CLKPWR_INTSRC_TS_P_BIT		_BIT(30)
+#define CLKPWR_INTSRC_TS_AUX_BIT	_BIT(29)
+#define CLKPWR_INTSRC_USBAHNEEDCLK_BIT	_BIT(26)
+#define CLKPWR_INTSRC_MSTIMER_BIT	_BIT(25)
+#define CLKPWR_INTSRC_RTC_BIT		_BIT(24)
+#define CLKPWR_INTSRC_USBNEEDCLK_BIT	_BIT(23)
+#define CLKPWR_INTSRC_USB_BIT		_BIT(22)
+#define CLKPWR_INTSRC_I2C_BIT		_BIT(21)
+#define CLKPWR_INTSRC_USBOTGTIMER_BIT	_BIT(20)
+#define CLKPWR_INTSRC_USBATXINT_BIT	_BIT(19)
+#define CLKPWR_INTSRC_KEY_BIT		_BIT(16)
+#define CLKPWR_INTSRC_MAC_BIT		_BIT(7)
+#define CLKPWR_INTSRC_P0P1_BIT		_BIT(6)
+#define CLKPWR_INTSRC_GPIO_05_BIT	_BIT(5)
+#define CLKPWR_INTSRC_GPIO_04_BIT	_BIT(4)
+#define CLKPWR_INTSRC_GPIO_03_BIT	_BIT(3)
+#define CLKPWR_INTSRC_GPIO_02_BIT	_BIT(2)
+#define CLKPWR_INTSRC_GPIO_01_BIT	_BIT(1)
+#define CLKPWR_INTSRC_GPIO_00_BIT	_BIT(0)
+
+/*
+ * clkpwr_start_pin, clkpwr_start_raw_sts_pin, clkpwr_start_sts_pin,
+ * clkpwr_start_pol_pin register bit definitions
+ */
+#define CLKPWR_EXTSRC_U7_RX_BIT		_BIT(31)
+#define CLKPWR_EXTSRC_U7_HCTS_BIT	_BIT(30)
+#define CLKPWR_EXTSRC_U6_IRRX_BIT	_BIT(28)
+#define CLKPWR_EXTSRC_U5_RX_BIT		_BIT(26)
+#define CLKPWR_EXTSRC_GPI_11_BIT	_BIT(25)
+#define CLKPWR_EXTSRC_U3_RX_BIT		_BIT(24)
+#define CLKPWR_EXTSRC_U2_HCTS_BIT	_BIT(23)
+#define CLKPWR_EXTSRC_U2_RX_BIT		_BIT(22)
+#define CLKPWR_EXTSRC_U1_RX_BIT		_BIT(21)
+#define CLKPWR_EXTSRC_MSDIO_INT_BIT	_BIT(18)
+#define CLKPWR_EXTSRC_MSDIO_SRT_BIT	_BIT(17)
+#define CLKPWR_EXTSRC_GPIO_O6_BIT	_BIT(16)
+#define CLKPWR_EXTSRC_GPIO_O5_BIT	_BIT(15)
+#define CLKPWR_EXTSRC_GPIO_O4_BIT	_BIT(14)
+#define CLKPWR_EXTSRC_GPIO_O3_BIT	_BIT(13)
+#define CLKPWR_EXTSRC_GPIO_O2_BIT	_BIT(12)
+#define CLKPWR_EXTSRC_GPIO_O1_BIT	_BIT(11)
+#define CLKPWR_EXTSRC_GPIO_O0_BIT	_BIT(10)
+#define CLKPWR_EXTSRC_SYSCLKEN_BIT	_BIT(9)
+#define CLKPWR_EXTSRC_SPI1_DATIN_BIT	_BIT(8)
+#define CLKPWR_EXTSRC_GPIO_O7_BIT	_BIT(7)
+#define CLKPWR_EXTSRC_SPI2_DATIN_BIT	_BIT(6)
+#define CLKPWR_EXTSRC_GPIO_19_BIT	_BIT(5)
+#define CLKPWR_EXTSRC_GPIO_O9_BIT	_BIT(4)
+#define CLKPWR_EXTSRC_GPIO_O8_BIT	_BIT(3)
+
+/*
+ * clkpwr_hclk_div register definitions
+ */
+#define CLKPWR_HCLKDIV_DDRCLK_STOP	(0x0 << 7)
+#define CLKPWR_HCLKDIV_DDRCLK_NORM	(0x1 << 7)
+#define CLKPWR_HCLKDIV_DDRCLK_HALF	(0x2 << 7)
+#define CLKPWR_HCLKDIV_PCLK_DIV(n)	(((n) & 0x1F) << 2)
+#define CLKPWR_HCLKDIV_DIV_2POW(n)	((n) & 0x3)
+
+/*
+ * clkpwr_pwr_ctrl register definitions
+ */
+#define CLKPWR_CTRL_FORCE_PCLK		_BIT(10)
+#define CLKPWR_SDRAM_SELF_RFSH		_BIT(9)
+#define CLKPWR_UPD_SDRAM_SELF_RFSH	_BIT(8)
+#define CLKPWR_AUTO_SDRAM_SELF_RFSH	_BIT(7)
+#define CLKPWR_HIGHCORE_STATE_BIT	_BIT(5)
+#define CLKPWR_SYSCLKEN_STATE_BIT	_BIT(4)
+#define CLKPWR_SYSCLKEN_GPIO_EN		_BIT(3)
+#define CLKPWR_SELECT_RUN_MODE		_BIT(2)
+#define CLKPWR_HIGHCORE_GPIO_EN		_BIT(1)
+#define CLKPWR_STOP_MODE_CTRL		_BIT(0)
+
+/*
+ * clkpwr_pll397_ctrl register definitions
+ */
+#define CLKPWR_PLL397_MSLOCK_STS	_BIT(10)
+#define CLKPWR_PLL397_BYPASS		_BIT(9)
+#define CLKPWR_PLL397_BIAS_NORM		0x000
+#define CLKPWR_PLL397_BIAS_N12_5	0x040
+#define CLKPWR_PLL397_BIAS_N25		0x080
+#define CLKPWR_PLL397_BIAS_N37_5	0x0C0
+#define CLKPWR_PLL397_BIAS_P12_5	0x100
+#define CLKPWR_PLL397_BIAS_P25		0x140
+#define CLKPWR_PLL397_BIAS_P37_5	0x180
+#define CLKPWR_PLL397_BIAS_P50		0x1C0
+#define CLKPWR_PLL397_BIAS_MASK		0x1C0
+#define CLKPWR_SYSCTRL_PLL397_DIS	_BIT(1)
+#define CLKPWR_SYSCTRL_PLL397_STS	_BIT(0)
+
+/*
+ * clkpwr_main_osc_ctrl register definitions
+ */
+#define CLKPWR_MOSC_ADD_CAP(n)		(((n) & 0x7F) << 2)
+#define CLKPWR_MOSC_CAP_MASK		(0x7F << 2)
+#define CLKPWR_TEST_MODE		_BIT(1)
+#define CLKPWR_MOSC_DISABLE		_BIT(0)
+
+/*
+ * clkpwr_sysclk_ctrl register definitions
+ */
+#define CLKPWR_SYSCTRL_BP_TRIG(n)	(((n) & 0x3FF) << 2)
+#define CLKPWR_SYSCTRL_BP_MASK		(0x3FF << 2)
+#define CLKPWR_SYSCTRL_USEPLL397	_BIT(1)
+#define CLKPWR_SYSCTRL_SYSCLKMUX	_BIT(0)
+
+/*
+ * clkpwr_lcdclk_ctrl register definitions
+ */
+#define CLKPWR_LCDCTRL_LCDTYPE_TFT12	0x000
+#define CLKPWR_LCDCTRL_LCDTYPE_TFT16	0x040
+#define CLKPWR_LCDCTRL_LCDTYPE_TFT15	0x080
+#define CLKPWR_LCDCTRL_LCDTYPE_TFT24	0x0C0
+#define CLKPWR_LCDCTRL_LCDTYPE_STN4M	0x100
+#define CLKPWR_LCDCTRL_LCDTYPE_STN8C	0x140
+#define CLKPWR_LCDCTRL_LCDTYPE_DSTN4M	0x180
+#define CLKPWR_LCDCTRL_LCDTYPE_DSTN8C	0x1C0
+#define CLKPWR_LCDCTRL_LCDTYPE_MSK	0x01C0
+#define CLKPWR_LCDCTRL_CLK_EN		0x020
+#define CLKPWR_LCDCTRL_SET_PSCALE(n)	((n - 1) & 0x1F)
+#define CLKPWR_LCDCTRL_PSCALE_MSK	0x001F
+
+/*
+ * clkpwr_hclkpll_ctrl register definitions
+ */
+#define CLKPWR_HCLKPLL_POWER_UP		_BIT(16)
+#define CLKPWR_HCLKPLL_CCO_BYPASS	_BIT(15)
+#define CLKPWR_HCLKPLL_POSTDIV_BYPASS	_BIT(14)
+#define CLKPWR_HCLKPLL_FDBK_SEL_FCLK	_BIT(13)
+#define CLKPWR_HCLKPLL_POSTDIV_2POW(n)	(((n) & 0x3) << 11)
+#define CLKPWR_HCLKPLL_PREDIV_PLUS1(n)	(((n) & 0x3) << 9)
+#define CLKPWR_HCLKPLL_PLLM(n)		(((n) & 0xFF) << 1)
+#define CLKPWR_HCLKPLL_PLL_STS		_BIT(0)
+
+/*
+ * clkpwr_adc_clk_ctrl_1 register definitions
+ */
+#define CLKPWR_ADCCTRL1_RTDIV(n)	(((n) & 0xFF) << 0)
+#define CLKPWR_ADCCTRL1_PCLK_SEL	_BIT(8)
+
+/*
+ * clkpwr_usb_ctrl register definitions
+ */
+#define CLKPWR_USBCTRL_HCLK_EN		_BIT(24)
+#define CLKPWR_USBCTRL_USBI2C_EN	_BIT(23)
+#define CLKPWR_USBCTRL_USBDVND_EN	_BIT(22)
+#define CLKPWR_USBCTRL_USBHSTND_EN	_BIT(21)
+#define CLKPWR_USBCTRL_PU_ADD		(0x0 << 19)
+#define CLKPWR_USBCTRL_BUS_KEEPER	(0x1 << 19)
+#define CLKPWR_USBCTRL_PD_ADD		(0x3 << 19)
+#define CLKPWR_USBCTRL_CLK_EN2		_BIT(18)
+#define CLKPWR_USBCTRL_CLK_EN1		_BIT(17)
+#define CLKPWR_USBCTRL_PLL_PWRUP	_BIT(16)
+#define CLKPWR_USBCTRL_CCO_BYPASS	_BIT(15)
+#define CLKPWR_USBCTRL_POSTDIV_BYPASS	_BIT(14)
+#define CLKPWR_USBCTRL_FDBK_SEL_FCLK	_BIT(13)
+#define CLKPWR_USBCTRL_POSTDIV_2POW(n)	(((n) & 0x3) << 11)
+#define CLKPWR_USBCTRL_PREDIV_PLUS1(n)	(((n) & 0x3) << 9)
+#define CLKPWR_USBCTRL_FDBK_PLUS1(n)	(((n) & 0xFF) << 1)
+#define CLKPWR_USBCTRL_PLL_STS		_BIT(0)
+
+/*
+ * clkpwr_sdramclk_ctrl register definitions
+ */
+#define CLKPWR_SDRCLK_FASTSLEW_CLK	_BIT(22)
+#define CLKPWR_SDRCLK_FASTSLEW		_BIT(21)
+#define CLKPWR_SDRCLK_FASTSLEW_DAT	_BIT(20)
+#define CLKPWR_SDRCLK_SW_DDR_RESET	_BIT(19)
+#define CLKPWR_SDRCLK_HCLK_DLY(n)	(((n) & 0x1F) << 14)
+#define CLKPWR_SDRCLK_DLY_ADDR_STS	_BIT(13)
+#define CLKPWR_SDRCLK_SENS_FACT(n)	(((n) & 0x7) << 10)
+#define CLKPWR_SDRCLK_USE_CAL		_BIT(9)
+#define CLKPWR_SDRCLK_DO_CAL		_BIT(8)
+#define CLKPWR_SDRCLK_CAL_ON_RTC	_BIT(7)
+#define CLKPWR_SDRCLK_DQS_DLY(n)	(((n) & 0x1F) << 2)
+#define CLKPWR_SDRCLK_USE_DDR		_BIT(1)
+#define CLKPWR_SDRCLK_CLK_DIS		_BIT(0)
+
+/*
+ * clkpwr_ssp_blk_ctrl register definitions
+ */
+#define CLKPWR_SSPCTRL_DMA_SSP1RX	_BIT(5)
+#define CLKPWR_SSPCTRL_DMA_SSP1TX	_BIT(4)
+#define CLKPWR_SSPCTRL_DMA_SSP0RX	_BIT(3)
+#define CLKPWR_SSPCTRL_DMA_SSP0TX	_BIT(2)
+#define CLKPWR_SSPCTRL_SSPCLK1_EN	_BIT(1)
+#define CLKPWR_SSPCTRL_SSPCLK0_EN	_BIT(0)
+
+/*
+ * clkpwr_i2s_clk_ctrl register definitions
+ */
+#define CLKPWR_I2SCTRL_I2S1_RX_FOR_TX	_BIT(6)
+#define CLKPWR_I2SCTRL_I2S1_TX_FOR_RX	_BIT(5)
+#define CLKPWR_I2SCTRL_I2S1_USE_DMA	_BIT(4)
+#define CLKPWR_I2SCTRL_I2S0_RX_FOR_TX	_BIT(3)
+#define CLKPWR_I2SCTRL_I2S0_TX_FOR_RX	_BIT(2)
+#define CLKPWR_I2SCTRL_I2SCLK1_EN	_BIT(1)
+#define CLKPWR_I2SCTRL_I2SCLK0_EN	_BIT(0)
+
+/*
+ * clkpwr_ms_ctrl register definitions
+ */
+#define CLKPWR_MSCARD_MSDIO_PIN_DIS	_BIT(10)
+#define CLKPWR_MSCARD_MSDIO_PU_EN	_BIT(9)
+#define CLKPWR_MSCARD_MSDIO23_DIS	_BIT(8)
+#define CLKPWR_MSCARD_MSDIO1_DIS	_BIT(7)
+#define CLKPWR_MSCARD_MSDIO0_DIS	_BIT(6)
+#define CLKPWR_MSCARD_SDCARD_EN		_BIT(5)
+#define CLKPWR_MSCARD_SDCARD_DIV(n)	((n) & 0xF)
+
+/*
+ * clkpwr_macclk_ctrl register definitions
+ */
+#define CLKPWR_MACCTRL_NO_ENET_PIS	0x00
+#define CLKPWR_MACCTRL_USE_MII_PINS	0x08
+#define CLKPWR_MACCTRL_USE_RMII_PINS	0x18
+#define CLKPWR_MACCTRL_PINS_MSK		0x18
+#define CLKPWR_MACCTRL_DMACLK_EN	_BIT(2)
+#define CLKPWR_MACCTRL_MMIOCLK_EN	_BIT(1)
+#define CLKPWR_MACCTRL_HRCCLK_EN	_BIT(0)
+
+/*
+ * clkpwr_test_clk_sel register definitions
+ */
+#define CLKPWR_TESTCLK1_SEL_PERCLK	(0x0 << 5)
+#define CLKPWR_TESTCLK1_SEL_RTC		(0x1 << 5)
+#define CLKPWR_TESTCLK1_SEL_MOSC	(0x2 << 5)
+#define CLKPWR_TESTCLK1_SEL_MASK	(0x3 << 5)
+#define CLKPWR_TESTCLK_TESTCLK1_EN	_BIT(4)
+#define CLKPWR_TESTCLK2_SEL_HCLK	(0x0 << 1)
+#define CLKPWR_TESTCLK2_SEL_PERCLK	(0x1 << 1)
+#define CLKPWR_TESTCLK2_SEL_USBCLK	(0x2 << 1)
+#define CLKPWR_TESTCLK2_SEL_MOSC	(0x5 << 1)
+#define CLKPWR_TESTCLK2_SEL_PLL397	(0x7 << 1)
+#define CLKPWR_TESTCLK2_SEL_MASK	(0x7 << 1)
+#define CLKPWR_TESTCLK_TESTCLK2_EN	_BIT(0)
+
+/*
+ * clkpwr_sw_int register definitions
+ */
+#define CLKPWR_SW_INT(n)		(_BIT(0) | (((n) & 0x7F) << 1))
+#define CLKPWR_SW_GET_ARG(n)		(((n) & 0xFE) >> 1)
+
+/*
+ * clkpwr_i2c_clk_ctrl register definitions
+ */
+#define CLKPWR_I2CCLK_USBI2CHI_DRIVE	_BIT(4)
+#define CLKPWR_I2CCLK_I2C2HI_DRIVE	_BIT(3)
+#define CLKPWR_I2CCLK_I2C1HI_DRIVE	_BIT(2)
+#define CLKPWR_I2CCLK_I2C2CLK_EN	_BIT(1)
+#define CLKPWR_I2CCLK_I2C1CLK_EN	_BIT(0)
+
+/*
+ * clkpwr_key_clk_ctrl register definitions
+ */
+#define CLKPWR_KEYCLKCTRL_CLK_EN	0x1
+
+/*
+ * clkpwr_adc_clk_ctrl register definitions
+ */
+#define CLKPWR_ADC32CLKCTRL_CLK_EN	0x1
+
+/*
+ * clkpwr_pwm_clk_ctrl register definitions
+ */
+#define CLKPWR_PWMCLK_PWM2_DIV(n)	(((n) & 0xF) << 8)
+#define CLKPWR_PWMCLK_PWM1_DIV(n)	(((n) & 0xF) << 4)
+#define CLKPWR_PWMCLK_PWM2SEL_PCLK	0x8
+#define CLKPWR_PWMCLK_PWM2CLK_EN	0x4
+#define CLKPWR_PWMCLK_PWM1SEL_PCLK	0x2
+#define CLKPWR_PWMCLK_PWM1CLK_EN	0x1
+
+/*
+ * clkpwr_timer_clk_ctrl register definitions
+ */
+#define CLKPWR_PWMCLK_HSTIMER_EN	0x2
+#define CLKPWR_PWMCLK_WDOG_EN		0x1
+
+/*
+ * clkpwr_timers_pwms_clk_ctrl_1 register definitions
+ */
+#define CLKPWR_TMRPWMCLK_TIMER3_EN	0x20
+#define CLKPWR_TMRPWMCLK_TIMER2_EN	0x10
+#define CLKPWR_TMRPWMCLK_TIMER1_EN	0x08
+#define CLKPWR_TMRPWMCLK_TIMER0_EN	0x04
+#define CLKPWR_TMRPWMCLK_PWM4_EN	0x02
+#define CLKPWR_TMRPWMCLK_PWM3_EN	0x01
+
+/*
+ * clkpwr_spi_clk_ctrl register definitions
+ */
+#define CLKPWR_SPICLK_SET_SPI2DATIO	0x80
+#define CLKPWR_SPICLK_SET_SPI2CLK	0x40
+#define CLKPWR_SPICLK_USE_SPI2		0x20
+#define CLKPWR_SPICLK_SPI2CLK_EN	0x10
+#define CLKPWR_SPICLK_SET_SPI1DATIO	0x08
+#define CLKPWR_SPICLK_SET_SPI1CLK	0x04
+#define CLKPWR_SPICLK_USE_SPI1		0x02
+#define CLKPWR_SPICLK_SPI1CLK_EN	0x01
+
+/*
+ * clkpwr_nand_clk_ctrl register definitions
+ */
+#define CLKPWR_NANDCLK_INTSEL_MLC	0x20
+#define CLKPWR_NANDCLK_DMA_RNB		0x10
+#define CLKPWR_NANDCLK_DMA_INT		0x08
+#define CLKPWR_NANDCLK_SEL_SLC		0x04
+#define CLKPWR_NANDCLK_MLCCLK_EN	0x02
+#define CLKPWR_NANDCLK_SLCCLK_EN	0x01
+
+/*
+ * clkpwr_uart3_clk_ctrl, clkpwr_uart4_clk_ctrl, clkpwr_uart5_clk_ctrl
+ * and clkpwr_uart6_clk_ctrl register definitions
+ */
+#define CLKPWR_UART_Y_DIV(y)		((y) & 0xFF)
+#define CLKPWR_UART_X_DIV(x)		(((x) & 0xFF) << 8)
+#define CLKPWR_UART_USE_HCLK		_BIT(16)
+
+/*
+ * clkpwr_irda_clk_ctrl register definitions
+ */
+#define CLKPWR_IRDA_Y_DIV(y)		((y) & 0xFF)
+#define CLKPWR_IRDA_X_DIV(x)		(((x) & 0xFF) << 8)
+
+/*
+ * clkpwr_uart_clk_ctrl register definitions
+ */
+#define CLKPWR_UARTCLKCTRL_UART6_EN	_BIT(3)
+#define CLKPWR_UARTCLKCTRL_UART5_EN	_BIT(2)
+#define CLKPWR_UARTCLKCTRL_UART4_EN	_BIT(1)
+#define CLKPWR_UARTCLKCTRL_UART3_EN	_BIT(0)
+
+/*
+ * clkpwr_dmaclk_ctrl register definitions
+ */
+#define CLKPWR_DMACLKCTRL_CLK_EN	0x1
+
+/*
+ * clkpwr_autoclock register definitions
+ */
+#define CLKPWR_AUTOCLK_USB_EN		0x40
+#define CLKPWR_AUTOCLK_IRAM_EN		0x02
+#define CLKPWR_AUTOCLK_IROM_EN		0x01
+
+/*
+ * Interrupt controller register offsets
+ */
+#define INTC_MASK		0x00
+#define INTC_RAW_STAT		0x04
+#define INTC_STAT		0x08
+#define INTC_POLAR		0x0C
+#define INTC_ACT_TYPE		0x10
+#define INTC_TYPE		0x14
+
+/*
+ *
+ * Timer/counter register offsets
+ *
+ */
+#define TIMER_IR(x)			((x) + 0x00)
+#define TIMER_TCR(x)			((x) + 0x04)
+#define TIMER_TC(x)			((x) + 0x08)
+#define TIMER_PR(x)			((x) + 0x0C)
+#define TIMER_PC(x)			((x) + 0x10)
+#define TIMER_MCR(x)			((x) + 0x14)
+#define TIMER_MR0(x)			((x) + 0x18)
+#define TIMER_MR1(x)			((x) + 0x1C)
+#define TIMER_MR2(x)			((x) + 0x20)
+#define TIMER_MR3(x)			((x) + 0x24)
+#define TIMER_CCR(x)			((x) + 0x28)
+#define TIMER_CR0(x)			((x) + 0x2C)
+#define TIMER_CR1(x)			((x) + 0x30)
+#define TIMER_CR2(x)			((x) + 0x34)
+#define TIMER_CR3(x)			((x) + 0x38)
+#define TIMER_EMR(x)			((x) + 0x3C)
+#define TIMER_CTCR(x)			((x) + 0x70)
+
+/*
+ * ir register definitions
+ */
+#define TIMER_CNTR_MTCH_BIT(n)		(1 << ((n) & 0x3))
+#define TIMER_CNTR_CAPT_BIT(n)		(1 << (4 + ((n) & 0x3)))
+
+/*
+ * tcr register definitions
+ */
+#define TIMER_CNTR_TCR_EN		0x1
+#define TIMER_CNTR_TCR_RESET		0x2
+
+/*
+ * mcr register definitions
+ */
+#define TIMER_CNTR_MCR_MTCH(n)		(0x1 << ((n) * 3))
+#define TIMER_CNTR_MCR_RESET(n)		(0x1 << (((n) * 3) + 1))
+#define TIMER_CNTR_MCR_STOP(n)		(0x1 << (((n) * 3) + 2))
+
+/*
+ *
+ * Standard UART register offsets
+ *
+ */
+#define UART_DLL_FIFO(x)		((x) + 0x00)
+#define UART_DLM_IER(x)			((x) + 0x04)
+#define UART_IIR_FCR(x)			((x) + 0x08)
+#define UART_LCR_(x)			((x) + 0x0C)
+#define UART_MODEM_CTRL(x)		((x) + 0x10)
+#define UART_LSR_(x)			((x) + 0x14)
+#define UART_MODEM_STATUS(x)		((x) + 0x18)
+#define UART_RXLEV(x)			((x) + 0x1C)
+
+/*
+ *
+ * UART control structure offsets
+ *
+ */
+#define UARTCTL_CTRL(x)			((x) + 0x00)
+#define UARTCTL_CLKMODE(x)		((x) + 0x04)
+#define UARTCTL_CLOOP(x)		((x) + 0x08)
+
+/*
+ * ctrl register definitions
+ */
+#define UART_U3_MD_CTRL_EN		_BIT(11)
+#define UART_IRRX6_INV_EN		_BIT(10)
+#define UART_HDPX_EN			_BIT(9)
+#define UART_UART6_IRDAMOD_BYPASS	_BIT(5)
+#define RT_IRTX6_INV_EN			_BIT(4)
+#define RT_IRTX6_INV_MIR_EN		_BIT(3)
+#define RT_RX_IRPULSE_3_16_115K		_BIT(2)
+#define RT_TX_IRPULSE_3_16_115K		_BIT(1)
+#define UART_U5_ROUTE_TO_USB		_BIT(0)
+
+/*
+ * clkmode register definitions
+ */
+#define UART_ENABLED_CLOCKS(n)		(((n) >> 16) & 0x7F)
+#define UART_ENABLED_CLOCK(n, u)	(((n) >> (16 + (u))) & 0x1)
+#define UART_ENABLED_CLKS_ANY		_BIT(14)
+#define UART_CLKMODE_OFF		0x0
+#define UART_CLKMODE_ON			0x1
+#define UART_CLKMODE_AUTO		0x2
+#define UART_CLKMODE_MASK(u)		(0x3 << ((((u) - 3) * 2) + 4))
+#define UART_CLKMODE_LOAD(m, u)		((m) << ((((u) - 3) * 2) + 4))
+
+/*
+ *
+ * GPIO Module Register offsets
+ *
+ */
+#define GPIO_P3_INP_STATE(x)		((x) + 0x000)
+#define GPIO_P3_OUTP_SET(x)		((x) + 0x004)
+#define GPIO_P3_OUTP_CLR(x)		((x) + 0x008)
+#define GPIO_P3_OUTP_STATE(x)		((x) + 0x00C)
+#define GPIO_P2_DIR_SET(x)		((x) + 0x010)
+#define GPIO_P2_DIR_CLR(x)		((x) + 0x014)
+#define GPIO_P2_DIR_STATE(x)		((x) + 0x018)
+#define GPIO_P2_INP_STATE(x)		((x) + 0x01C)
+#define GPIO_P2_OUTP_SET(x)		((x) + 0x020)
+#define GPIO_P2_OUTP_CLR(x)		((x) + 0x024)
+#define GPIO_P2_MUX_SET(x)		((x) + 0x028)
+#define GPIO_P2_MUX_CLR(x)		((x) + 0x02C)
+#define GPIO_P2_MUX_STATE(x)		((x) + 0x030)
+#define GPIO_P0_INP_STATE(x)		((x) + 0x040)
+#define GPIO_P0_OUTP_SET(x)		((x) + 0x044)
+#define GPIO_P0_OUTP_CLR(x)		((x) + 0x048)
+#define GPIO_P0_OUTP_STATE(x)		((x) + 0x04C)
+#define GPIO_P0_DIR_SET(x)		((x) + 0x050)
+#define GPIO_P0_DIR_CLR(x)		((x) + 0x054)
+#define GPIO_P0_DIR_STATE(x)		((x) + 0x058)
+#define GPIO_P1_INP_STATE(x)		((x) + 0x060)
+#define GPIO_P1_OUTP_SET(x)		((x) + 0x064)
+#define GPIO_P1_OUTP_CLR(x)		((x) + 0x068)
+#define GPIO_P1_OUTP_STATE(x)		((x) + 0x06C)
+#define GPIO_P1_DIR_SET(x)		((x) + 0x070)
+#define GPIO_P1_DIR_CLR(x)		((x) + 0x074)
+#define GPIO_P1_DIR_STATE(x)		((x) + 0x078)
+#define GPIO_P_MUX_SET(x)		((x) + 0x100)
+#define GPIO_P_MUX_CLR(x)		((x) + 0x104)
+#define GPIO_P_MUX_STATE(x)		((x) + 0x108)
+#define GPIO_P3_MUX_SET(x)		((x) + 0x110)
+#define GPIO_P3_MUX_CLR(x)		((x) + 0x114)
+#define GPIO_P3_MUX_STATE(x)		((x) + 0x118)
+#define GPIO_P0_MUX_SET(x)		((x) + 0x120)
+#define GPIO_P0_MUX_CLR(x)		((x) + 0x124)
+#define GPIO_P0_MUX_STATE(x)		((x) + 0x128)
+#define GPIO_P1_MUX_SET(x)		((x) + 0x130)
+#define GPIO_P1_MUX_CLR(x)		((x) + 0x134)
+#define GPIO_P1_MUX_STATE(x)		((x) + 0x138)
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
new file mode 100644
index 0000000..29bd2e4
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/system.h
@@ -0,0 +1,56 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/system.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+static void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	extern void lpc32xx_watchdog_reset(void);
+
+	switch (mode) {
+	case 's':
+	case 'h':
+		printk(KERN_CRIT "RESET: Rebooting system\n");
+
+		/* Disable interrupts */
+		local_irq_disable();
+
+		lpc32xx_watchdog_reset();
+		break;
+
+	default:
+		/* Do nothing */
+		break;
+	}
+
+	/* Wait for watchdog to reset system */
+	while (1)
+		;
+}
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/timex.h b/arch/arm/mach-lpc32xx/include/mach/timex.h
new file mode 100644
index 0000000..1f872c5
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/timex.h
@@ -0,0 +1,33 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/timex.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H
+
+/*
+ * Rate in Hz of the main system oscillator. This value should match
+ * the value 'MAIN_OSC_FREQ' in platform.h
+ */
+#define CLOCK_TICK_RATE	13000000
+
+#endif
+
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
new file mode 100644
index 0000000..a00ecc5
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -0,0 +1,114 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/uncompress.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARM_ARCH_UNCOMPRESS_H
+#define __ASM_ARM_ARCH_UNCOMPRESS_H
+
+#include <linux/io.h>
+
+#include <mach/platform.h>
+
+#if defined(CONFIG_ARCH_LPC32XX_UNCOMP_HSU1) || \
+	defined(CONFIG_ARCH_LPC32XX_UNCOMP_HSU2) || \
+	defined(CONFIG_ARCH_LPC32XX_UNCOMP_HSU7)
+/*
+ * High speed UART uncompress output support
+*/
+#ifdef CONFIG_ARCH_LPC32XX_UNCOMP_HSU1
+#define HS_UARTX_BASE	(HS_UART1_BASE)
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_UNCOMP_HSU2
+#define HS_UARTX_BASE	(HS_UART2_BASE)
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_UNCOMP_HSU7
+#define HS_UARTX_BASE	(HS_UART7_BASE)
+#endif
+
+#define HSUART_FIFO	(HS_UARTX_BASE + 0x00)
+#define HSUART_LEVEL	(HS_UARTX_BASE + 0x04)
+
+static inline void putc(int ch)
+{
+	/* Wait for transmit FIFO to empty */
+	while ((readl(HSUART_LEVEL) & 0xFF00) != 0)
+		;
+	writel((u32) ch, HSUART_FIFO);
+}
+static inline void flush(void)
+{
+	/* Don't see a reset? */
+	/* Then just wait for transmition to complete */
+	while ((readl(HSUART_LEVEL) & 0xFF00) != 0)
+		;
+}
+
+#else
+/*
+ * Standard UART uncompress output support
+ */
+
+#define UART_FIFO_CTL_TX_RESET	(1 << 2)
+#define UART_STATUS_TX_MT	(1 << 6)
+
+#ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U3
+#define UARTX_BASE	(UART3_BASE)
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U4
+#define UARTX_BASE	(UART4_BASE)
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U5
+#define UARTX_BASE	(UART5_BASE)
+#endif
+
+#ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U6
+#define UARTX_BASE	(UART6_BASE)
+#endif
+
+#define UART_DATA	(UARTX_BASE + 0x00)
+#define UART_FIFO_CTL	(UARTX_BASE + 0x08)
+#define UART_STATUS	(UARTX_BASE + 0x14)
+
+static inline void putc(int ch)
+{
+	/* Wait for transmit FIFO to empty */
+	while ((readl(UART_STATUS) & UART_STATUS_TX_MT) == 0)
+		;
+
+	writel((u32) ch, UART_DATA);
+}
+
+static inline void flush(void)
+{
+	writel(readl(UART_FIFO_CTL) | UART_FIFO_CTL_TX_RESET, UART_FIFO_CTL);
+}
+#endif
+
+/* NULL functions; we don't presently need them */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
+
+#endif
+
diff --git a/arch/arm/mach-lpc32xx/include/mach/vmalloc.h b/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
new file mode 100644
index 0000000..5efcc96
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
@@ -0,0 +1,28 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/vmalloc.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_VMALLOC_H
+#define __ASM_ARCH_VMALLOC_H
+
+#define VMALLOC_END	(PAGE_OFFSET + 0x10000000)
+
+#endif
-- 
1.6.6
