From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 20 Nov 2009 15:17:23 +0800
Subject: RFC [PATCH 6/9] Added lpc32xx platform.h file
In-Reply-To: <083DF309106F364B939360100EC290F804F54D560F@eu1rdcrdc1wx030.exi.nxp.com>
References: <AcppfmTfmIz4uGVTSkSZH3tsHS4cTw==>
	<083DF309106F364B939360100EC290F804F54D560F@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <e68bb3470911192317s1203ae5k750ec6372539e433@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

And, this patch could not be applied in my Linux 2.6.32-rc7, error
occurs as following:

zswan at zswan-laptop:~/git-2.6/linux-2.6$ patch -p1 < Added\ lpc32xx\
platform.h\ file.eml
patching file arch/arm/mach-lpc32xx/include/mach/platform.h
patch: **** malformed patch at line 1063:  */

why?

2009/11/20 Kevin Wells <kevin.wells@nxp.com>:
> Added lpc32xx platform.h file
>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
> ---
> ?arch/arm/mach-lpc32xx/include/mach/platform.h | ?993 +++++++++++++++++++++++++
> ?1 files changed, 993 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-lpc32xx/include/mach/platform.h
>
> diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
> new file mode 100644
> index 0000000..a3fc3d9
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
> @@ -0,0 +1,993 @@
> +/*
> + * mach-lpc32xx/include/mach/platform.h
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> + */
> +
> +#ifndef __ASM_ARCH_PLATFORM_H
> +#define __ASM_ARCH_PLATFORM_H
> +
> +#include <mach/hardware.h>
> +
> +#define _SBF(f,v) ? ? ? ? ? ? ? ? ? ? ?(((v)) << (f))
> +#define _BIT(n) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << (n))
> +
> +/*
> + * AHB 0 physical base addresses
> + */
> +#define SLC_BASE ? ? ? ? ? ? ? ? ? ? ? 0x20020000
> +#define SSP0_BASE ? ? ? ? ? ? ? ? ? ? ?0x20084000
> +#define SPI1_BASE ? ? ? ? ? ? ? ? ? ? ?0x20088000
> +#define SSP1_BASE ? ? ? ? ? ? ? ? ? ? ?0x2008C000
> +#define SPI2_BASE ? ? ? ? ? ? ? ? ? ? ?0x20090000
> +#define I2S0_BASE ? ? ? ? ? ? ? ? ? ? ?0x20094000
> +#define SD_BASE ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?0x20098000
> +#define I2S1_BASE ? ? ? ? ? ? ? ? ? ? ?0x2009C000
> +#define MLC_BASE ? ? ? ? ? ? ? ? ? ? ? 0x200A8000
> +#define AHB0_START ? ? ? ? ? ? ? ? ? ? SLC_BASE
> +#define AHB0_SIZE ? ? ? ? ? ? ? ? ? ? ?((MLC_BASE - SLC_BASE) + SZ_4K)
> +
> +/*
> + * AHB 1 physical base addresses
> + */
> +#define DMA_BASE ? ? ? ? ? ? ? ? ? ? ? 0x31000000
> +#define USB_BASE ? ? ? ? ? ? ? ? ? ? ? 0x31020000
> +#define USBH_BASE ? ? ? ? ? ? ? ? ? ? ?0x31020000
> +#define USB_OTG_BASE ? ? ? ? ? ? ? ? ? 0x31020000
> +#define OTG_I2C_BASE ? ? ? ? ? ? ? ? ? 0x31020300
> +#define LCD_BASE ? ? ? ? ? ? ? ? ? ? ? 0x31040000
> +#define ETHERNET_BASE ? ? ? ? ? ? ? ? ?0x31060000
> +#define EMC_BASE ? ? ? ? ? ? ? ? ? ? ? 0x31080000
> +#define ETB_CFG_BASE ? ? ? ? ? ? ? ? ? 0x310C0000
> +#define ETB_DATA_BASE ? ? ? ? ? ? ? ? ?0x310E0000
> +#define AHB1_START ? ? ? ? ? ? ? ? ? ? DMA_BASE
> +#define AHB1_SIZE ? ? ? ? ? ? ? ? ? ? ?((EMC_BASE - DMA_BASE) + SZ_4K)
> +
> +/*
> + * FAB physical base addresses
> + */
> +#define CLK_PM_BASE ? ? ? ? ? ? ? ? ? ?0x40004000
> +#define MIC_BASE ? ? ? ? ? ? ? ? ? ? ? 0x40008000
> +#define SIC1_BASE ? ? ? ? ? ? ? ? ? ? ?0x4000C000
> +#define SIC2_BASE ? ? ? ? ? ? ? ? ? ? ?0x40010000
> +#define HS_UART1_BASE ? ? ? ? ? ? ? ? ?0x40014000
> +#define HS_UART2_BASE ? ? ? ? ? ? ? ? ?0x40018000
> +#define HS_UART7_BASE ? ? ? ? ? ? ? ? ?0x4001C000
> +#define RTC_BASE ? ? ? ? ? ? ? ? ? ? ? 0x40024000
> +#define RTC_RAM_BASE ? ? ? ? ? ? ? ? ? 0x40024080
> +#define GPIO_BASE ? ? ? ? ? ? ? ? ? ? ?0x40028000
> +#define PWM3_BASE ? ? ? ? ? ? ? ? ? ? ?0x4002C000
> +#define PWM4_BASE ? ? ? ? ? ? ? ? ? ? ?0x40030000
> +#define MSTIM_BASE ? ? ? ? ? ? ? ? ? ? 0x40034000
> +#define HSTIM_BASE ? ? ? ? ? ? ? ? ? ? 0x40038000
> +#define WDTIM_BASE ? ? ? ? ? ? ? ? ? ? 0x4003C000
> +#define DEBUG_CTRL_BASE ? ? ? ? ? ? ? ? ? ? ? ?0x40040000
> +#define TIMER0_BASE ? ? ? ? ? ? ? ? ? ?0x40044000
> +#define ADC_BASE ? ? ? ? ? ? ? ? ? ? ? 0x40048000
> +#define TIMER1_BASE ? ? ? ? ? ? ? ? ? ?0x4004C000
> +#define KSCAN_BASE ? ? ? ? ? ? ? ? ? ? 0x40050000
> +#define UART_CTRL_BASE ? ? ? ? ? ? ? ? 0x40054000
> +#define TIMER2_BASE ? ? ? ? ? ? ? ? ? ?0x40058000
> +#define PWM1_BASE ? ? ? ? ? ? ? ? ? ? ?0x4005C000
> +#define PWM2_BASE ? ? ? ? ? ? ? ? ? ? ?0x4005C004
> +#define TIMER3_BASE ? ? ? ? ? ? ? ? ? ?0x40060000
> +
> +/*
> + * APB physical base addresses
> + */
> +
> +#define UART3_BASE ? ? ? ? ? ? ? ? ? ? 0x40080000
> +#define UART4_BASE ? ? ? ? ? ? ? ? ? ? 0x40088000
> +#define UART5_BASE ? ? ? ? ? ? ? ? ? ? 0x40090000
> +#define UART6_BASE ? ? ? ? ? ? ? ? ? ? 0x40098000
> +#define I2C1_BASE ? ? ? ? ? ? ? ? ? ? ?0x400A0000
> +#define I2C2_BASE ? ? ? ? ? ? ? ? ? ? ?0x400A8000
> +
> +/*
> + * FAB and APB base and sizing
> + */
> +#define FABAPB_START ? ? ? ? ? ? ? ? ? CLK_PM_BASE
> +#define FABAPB_SIZE ? ? ? ? ? ? ? ? ? ?((I2C2_BASE - CLK_PM_BASE) + SZ_4K)
> +
> +/*
> + * Internal memory Bases
> + */
> +#define IRAM_BASE ? ? ? ? ? ? ? ? ? ? ?0x08000000
> +#define IROM_BASE ? ? ? ? ? ? ? ? ? ? ?0x0C000000
> +
> +/*
> + * External Static Memory Bank Address Space Bases
> + */
> +#define EMC_CS0_BASE ? ? ? ? ? ? ? ? ? 0xE0000000
> +#define EMC_CS1_BASE ? ? ? ? ? ? ? ? ? 0xE1000000
> +#define EMC_CS2_BASE ? ? ? ? ? ? ? ? ? 0xE2000000
> +#define EMC_CS3_BASE ? ? ? ? ? ? ? ? ? 0xE3000000
> +
> +/*
> + * External SDRAM Memory Bank Address Space Bases
> + */
> +#define EMC_DYCS0_BASE ? ? ? ? ? ? ? ? 0x80000000
> +#define EMC_DYCS1_BASE ? ? ? ? ? ? ? ? 0xA0000000
> +
> +/*
> + * Clock and crystal information
> + */
> +#define MAIN_OSC_FREQ ? ? ? ? ? ? ? ? ?13000000
> +#define CLOCK_OSC_FREQ ? ? ? ? ? ? ? ? 32768
> +
> +/*
> + * IRAM size
> +*/
> +#define LPC32XX_IRAM_SIZE ? ? ? ? ? ? ?(CONFIG_MACH_LPC32XX_IRAM_SIZE * 1024)
> +
> +/*
> + * Clock and Power control register offsets
> + */
> +#define CLKPWR_DEBUG_CTRL(x) ? ? ? ? ? (x + 0x000)
> +#define CLKPWR_BOOTMAP(x) ? ? ? ? ? ? ?(x + 0x014)
> +#define CLKPWR_P01_ER(x) ? ? ? ? ? ? ? (x + 0x018)
> +#define CLKPWR_USBCLK_PDIV(x) ? ? ? ? ?(x + 0x01C)
> +#define CLKPWR_INT_ER(x) ? ? ? ? ? ? ? (x + 0x020)
> +#define CLKPWR_INT_RS(x) ? ? ? ? ? ? ? (x + 0x024)
> +#define CLKPWR_INT_SR(x) ? ? ? ? ? ? ? (x + 0x028)
> +#define CLKPWR_INT_AP(x) ? ? ? ? ? ? ? (x + 0x02C)
> +#define CLKPWR_PIN_ER(x) ? ? ? ? ? ? ? (x + 0x030)
> +#define CLKPWR_PIN_RS(x) ? ? ? ? ? ? ? (x + 0x034)
> +#define CLKPWR_PIN_SR(x) ? ? ? ? ? ? ? (x + 0x038)
> +#define CLKPWR_PIN_AP(x) ? ? ? ? ? ? ? (x + 0x03C)
> +#define CLKPWR_HCLK_DIV(x) ? ? ? ? ? ? (x + 0x040)
> +#define CLKPWR_PWR_CTRL(x) ? ? ? ? ? ? (x + 0x044)
> +#define CLKPWR_PLL397_CTRL(x) ? ? ? ? ?(x + 0x048)
> +#define CLKPWR_MAIN_OSC_CTRL(x) ? ? ? ? ? ? ? ?(x + 0x04C)
> +#define CLKPWR_SYSCLK_CTRL(x) ? ? ? ? ?(x + 0x050)
> +#define CLKPWR_LCDCLK_CTRL(x) ? ? ? ? ?(x + 0x054)
> +#define CLKPWR_HCLKPLL_CTRL(x) ? ? ? ? (x + 0x058)
> +#define CLKPWR_ADC_CLK_CTRL_1(x) ? ? ? (x + 0x060)
> +#define CLKPWR_USB_CTRL(x) ? ? ? ? ? ? (x + 0x064)
> +#define CLKPWR_SDRAMCLK_CTRL(x) ? ? ? ? ? ? ? ?(x + 0x068)
> +#define CLKPWR_DDR_LAP_NOM(x) ? ? ? ? ?(x + 0x06C)
> +#define CLKPWR_DDR_LAP_COUNT(x) ? ? ? ? ? ? ? ?(x + 0x070)
> +#define CLKPWR_DDR_LAP_DELAY(x) ? ? ? ? ? ? ? ?(x + 0x074)
> +#define CLKPWR_SSP_CLK_CTRL(x) ? ? ? ? (x + 0x078)
> +#define CLKPWR_I2S_CLK_CTRL(x) ? ? ? ? (x + 0x07C)
> +#define CLKPWR_MS_CTRL(x) ? ? ? ? ? ? ?(x + 0x080)
> +#define CLKPWR_MACCLK_CTRL(x) ? ? ? ? ?(x + 0x090)
> +#define CLKPWR_TEST_CLK_SEL(x) ? ? ? ? (x + 0x0A4)
> +#define CLKPWR_SFW_INT(x) ? ? ? ? ? ? ?(x + 0x0A8)
> +#define CLKPWR_I2C_CLK_CTRL(x) ? ? ? ? (x + 0x0AC)
> +#define CLKPWR_KEY_CLK_CTRL(x) ? ? ? ? (x + 0x0B0)
> +#define CLKPWR_ADC_CLK_CTRL(x) ? ? ? ? (x + 0x0B4)
> +#define CLKPWR_PWM_CLK_CTRL(x) ? ? ? ? (x + 0x0B8)
> +#define CLKPWR_TIMER_CLK_CTRL(x) ? ? ? (x + 0x0BC)
> +#define CLKPWR_TIMERS_PWMS_CLK_CTRL_1(x) (x + 0x0C0)
> +#define CLKPWR_SPI_CLK_CTRL(x) ? ? ? ? (x + 0x0C4)
> +#define CLKPWR_NAND_CLK_CTRL(x) ? ? ? ? ? ? ? ?(x + 0x0C8)
> +#define CLKPWR_UART3_CLK_CTRL(x) ? ? ? (x + 0x0D0)
> +#define CLKPWR_UART4_CLK_CTRL(x) ? ? ? (x + 0x0D4)
> +#define CLKPWR_UART5_CLK_CTRL(x) ? ? ? (x + 0x0D8)
> +#define CLKPWR_UART6_CLK_CTRL(x) ? ? ? (x + 0x0DC)
> +#define CLKPWR_IRDA_CLK_CTRL(x) ? ? ? ? ? ? ? ?(x + 0x0E0)
> +#define CLKPWR_UART_CLK_CTRL(x) ? ? ? ? ? ? ? ?(x + 0x0E4)
> +#define CLKPWR_DMA_CLK_CTRL(x) ? ? ? ? (x + 0x0E8)
> +#define CLKPWR_AUTOCLOCK(x) ? ? ? ? ? ?(x + 0x0EC)
> +#define CLKPWR_DEVID(x, y) ? ? ? ? ? ? (x + 0x130 + y)
> +
> +/*
> + * clkpwr_debug_ctrl register definitions
> +*/
> +#define CLKPWR_VFP_CLOCK_ENABLE_BIT ? ?_BIT(4)
> +
> +/*
> + * clkpwr_bootmap register definitions
> + */
> +#define CLKPWR_BOOTMAP_SEL_BIT ? ? ? ? _BIT(1)
> +
> +/*
> + * clkpwr_start_gpio register bit definitions
> + */
> +#define CLKPWR_GPIOSRC_P1IO23_BIT ? ? ?_BIT(31)
> +#define CLKPWR_GPIOSRC_P1IO22_BIT ? ? ?_BIT(30)
> +#define CLKPWR_GPIOSRC_P1IO21_BIT ? ? ?_BIT(29)
> +#define CLKPWR_GPIOSRC_P1IO20_BIT ? ? ?_BIT(28)
> +#define CLKPWR_GPIOSRC_P1IO19_BIT ? ? ?_BIT(27)
> +#define CLKPWR_GPIOSRC_P1IO18_BIT ? ? ?_BIT(26)
> +#define CLKPWR_GPIOSRC_P1IO17_BIT ? ? ?_BIT(25)
> +#define CLKPWR_GPIOSRC_P1IO16_BIT ? ? ?_BIT(24)
> +#define CLKPWR_GPIOSRC_P1IO15_BIT ? ? ?_BIT(23)
> +#define CLKPWR_GPIOSRC_P1IO14_BIT ? ? ?_BIT(22)
> +#define CLKPWR_GPIOSRC_P1IO13_BIT ? ? ?_BIT(21)
> +#define CLKPWR_GPIOSRC_P1IO12_BIT ? ? ?_BIT(20)
> +#define CLKPWR_GPIOSRC_P1IO11_BIT ? ? ?_BIT(19)
> +#define CLKPWR_GPIOSRC_P1IO10_BIT ? ? ?_BIT(18)
> +#define CLKPWR_GPIOSRC_P1IO9_BIT ? ? ? _BIT(17)
> +#define CLKPWR_GPIOSRC_P1IO8_BIT ? ? ? _BIT(16)
> +#define CLKPWR_GPIOSRC_P1IO7_BIT ? ? ? _BIT(15)
> +#define CLKPWR_GPIOSRC_P1IO6_BIT ? ? ? _BIT(14)
> +#define CLKPWR_GPIOSRC_P1IO5_BIT ? ? ? _BIT(13)
> +#define CLKPWR_GPIOSRC_P1IO4_BIT ? ? ? _BIT(12)
> +#define CLKPWR_GPIOSRC_P1IO3_BIT ? ? ? _BIT(11)
> +#define CLKPWR_GPIOSRC_P1IO2_BIT ? ? ? _BIT(10)
> +#define CLKPWR_GPIOSRC_P1IO1_BIT ? ? ? _BIT(9)
> +#define CLKPWR_GPIOSRC_P1IO0_BIT ? ? ? _BIT(8)
> +#define CLKPWR_GPIOSRC_P0IO7_BIT ? ? ? _BIT(7)
> +#define CLKPWR_GPIOSRC_P0IO6_BIT ? ? ? _BIT(6)
> +#define CLKPWR_GPIOSRC_P0IO5_BIT ? ? ? _BIT(5)
> +#define CLKPWR_GPIOSRC_P0IO4_BIT ? ? ? _BIT(4)
> +#define CLKPWR_GPIOSRC_P0IO3_BIT ? ? ? _BIT(3)
> +#define CLKPWR_GPIOSRC_P0IO2_BIT ? ? ? _BIT(2)
> +#define CLKPWR_GPIOSRC_P0IO1_BIT ? ? ? _BIT(1)
> +#define CLKPWR_GPIOSRC_P0IO0_BIT ? ? ? _BIT(0)
> +
> +/*
> + * clkpwr_usbclk_pdiv register definitions
> + */
> +#define CLKPWR_SET_PLL_USBPDIV(n) ? ? ?((n) & 0xF)
> +#define CLKPWR_USBPDIV_PLL_MASK ? ? ? ? ? ? ? ?0xF
> +
> +/*
> + * clkpwr_start_int, clkpwr_start_raw_sts_int, clkpwr_start_sts_int,
> + * clkpwr_start_pol_int, register bit definitions
> + */
> +#define CLKPWR_INTSRC_ADC_BIT ? ? ? ? ?_BIT(31)
> +#define CLKPWR_INTSRC_TS_P_BIT ? ? ? ? _BIT(30)
> +#define CLKPWR_INTSRC_TS_AUX_BIT ? ? ? _BIT(29)
> +#define CLKPWR_INTSRC_USBAHNEEDCLK_BIT _BIT(26)
> +#define CLKPWR_INTSRC_MSTIMER_BIT ? ? ?_BIT(25)
> +#define CLKPWR_INTSRC_RTC_BIT ? ? ? ? ?_BIT(24)
> +#define CLKPWR_INTSRC_USBNEEDCLK_BIT ? _BIT(23)
> +#define CLKPWR_INTSRC_USB_BIT ? ? ? ? ?_BIT(22)
> +#define CLKPWR_INTSRC_I2C_BIT ? ? ? ? ?_BIT(21)
> +#define CLKPWR_INTSRC_USBOTGTIMER_BIT ?_BIT(20)
> +#define CLKPWR_INTSRC_USBATXINT_BIT ? ?_BIT(19)
> +#define CLKPWR_INTSRC_KEY_BIT ? ? ? ? ?_BIT(16)
> +#define CLKPWR_INTSRC_MAC_BIT ? ? ? ? ?_BIT(7)
> +#define CLKPWR_INTSRC_P0P1_BIT ? ? ? ? _BIT(6)
> +#define CLKPWR_INTSRC_GPIO_05_BIT ? ? ?_BIT(5)
> +#define CLKPWR_INTSRC_GPIO_04_BIT ? ? ?_BIT(4)
> +#define CLKPWR_INTSRC_GPIO_03_BIT ? ? ?_BIT(3)
> +#define CLKPWR_INTSRC_GPIO_02_BIT ? ? ?_BIT(2)
> +#define CLKPWR_INTSRC_GPIO_01_BIT ? ? ?_BIT(1)
> +#define CLKPWR_INTSRC_GPIO_00_BIT ? ? ?_BIT(0)
> +
> +/*
> + * clkpwr_start_pin, clkpwr_start_raw_sts_pin, clkpwr_start_sts_pin,
> + * clkpwr_start_pol_pin register bit definitions
> + */
> +#define CLKPWR_EXTSRC_U7_RX_BIT ? ? ? ? ? ? ? ?_BIT(31)
> +#define CLKPWR_EXTSRC_U7_HCTS_BIT ? ? ?_BIT(30)
> +#define CLKPWR_EXTSRC_U6_IRRX_BIT ? ? ?_BIT(28)
> +#define CLKPWR_EXTSRC_U5_RX_BIT ? ? ? ? ? ? ? ?_BIT(26)
> +#define CLKPWR_EXTSRC_GPI_11_BIT ? ? ? _BIT(25)
> +#define CLKPWR_EXTSRC_U3_RX_BIT ? ? ? ? ? ? ? ?_BIT(24)
> +#define CLKPWR_EXTSRC_U2_HCTS_BIT ? ? ?_BIT(23)
> +#define CLKPWR_EXTSRC_U2_RX_BIT ? ? ? ? ? ? ? ?_BIT(22)
> +#define CLKPWR_EXTSRC_U1_RX_BIT ? ? ? ? ? ? ? ?_BIT(21)
> +#define CLKPWR_EXTSRC_MSDIO_INT_BIT ? ?_BIT(18)
> +#define CLKPWR_EXTSRC_MSDIO_SRT_BIT ? ?_BIT(17)
> +#define CLKPWR_EXTSRC_GPIO_O6_BIT ? ? ?_BIT(16)
> +#define CLKPWR_EXTSRC_GPIO_O5_BIT ? ? ?_BIT(15)
> +#define CLKPWR_EXTSRC_GPIO_O4_BIT ? ? ?_BIT(14)
> +#define CLKPWR_EXTSRC_GPIO_O3_BIT ? ? ?_BIT(13)
> +#define CLKPWR_EXTSRC_GPIO_O2_BIT ? ? ?_BIT(12)
> +#define CLKPWR_EXTSRC_GPIO_O1_BIT ? ? ?_BIT(11)
> +#define CLKPWR_EXTSRC_GPIO_O0_BIT ? ? ?_BIT(10)
> +#define CLKPWR_EXTSRC_SYSCLKEN_BIT ? ? _BIT(9)
> +#define CLKPWR_EXTSRC_SPI1_DATIN_BIT ? _BIT(8)
> +#define CLKPWR_EXTSRC_GPIO_O7_BIT ? ? ?_BIT(7)
> +#define CLKPWR_EXTSRC_SPI2_DATIN_BIT ? _BIT(6)
> +#define CLKPWR_EXTSRC_GPIO_10_BIT ? ? ?_BIT(5)
> +#define CLKPWR_EXTSRC_GPIO_O9_BIT ? ? ?_BIT(4)
> +#define CLKPWR_EXTSRC_GPIO_O8_BIT ? ? ?_BIT(3)
> +
> +/*
> + * clkpwr_hclk_div register definitions
> + */
> +#define CLKPWR_HCLKDIV_DDRCLK_STOP ? ? (0x0 << 7)
> +#define CLKPWR_HCLKDIV_DDRCLK_NORM ? ? (0x1 << 7)
> +#define CLKPWR_HCLKDIV_DDRCLK_HALF ? ? (0x2 << 7)
> +#define CLKPWR_HCLKDIV_PCLK_DIV(n) ? ? (((n) & 0x1F) << 2)
> +#define CLKPWR_HCLKDIV_DIV_2POW(n) ? ? ((n) & 0x3)
> +
> +/*
> + * clkpwr_pwr_ctrl register definitions
> + */
> +#define CLKPWR_CTRL_FORCE_PCLK ? ? ? ? _BIT(10)
> +#define CLKPWR_SDRAM_SELF_RFSH ? ? ? ? _BIT(9)
> +#define CLKPWR_UPD_SDRAM_SELF_RFSH ? ? _BIT(8)
> +#define CLKPWR_AUTO_SDRAM_SELF_RFSH ? ?_BIT(7)
> +#define CLKPWR_HIGHCORE_STATE_BIT ? ? ?_BIT(5)
> +#define CLKPWR_SYSCLKEN_STATE_BIT ? ? ?_BIT(4)
> +#define CLKPWR_SYSCLKEN_GPIO_EN ? ? ? ? ? ? ? ?_BIT(3)
> +#define CLKPWR_SELECT_RUN_MODE ? ? ? ? _BIT(2)
> +#define CLKPWR_HIGHCORE_GPIO_EN ? ? ? ? ? ? ? ?_BIT(1)
> +#define CLKPWR_STOP_MODE_CTRL ? ? ? ? ?_BIT(0)
> +
> +/*
> + * clkpwr_pll397_ctrl register definitions
> + */
> +#define CLKPWR_PLL397_MSLOCK_STS ? ? ? _BIT(10)
> +#define CLKPWR_PLL397_BYPASS ? ? ? ? ? _BIT(9)
> +#define CLKPWR_PLL397_BIAS_NORM ? ? ? ? ? ? ? ?0x000
> +#define CLKPWR_PLL397_BIAS_N12_5 ? ? ? 0x040
> +#define CLKPWR_PLL397_BIAS_N25 ? ? ? ? 0x080
> +#define CLKPWR_PLL397_BIAS_N37_5 ? ? ? 0x0C0
> +#define CLKPWR_PLL397_BIAS_P12_5 ? ? ? 0x100
> +#define CLKPWR_PLL397_BIAS_P25 ? ? ? ? 0x140
> +#define CLKPWR_PLL397_BIAS_P37_5 ? ? ? 0x180
> +#define CLKPWR_PLL397_BIAS_P50 ? ? ? ? 0x1C0
> +#define CLKPWR_PLL397_BIAS_MASK ? ? ? ? ? ? ? ?0x1C0
> +#define CLKPWR_SYSCTRL_PLL397_DIS ? ? ?_BIT(1)
> +#define CLKPWR_SYSCTRL_PLL397_STS ? ? ?_BIT(0)
> +
> +/*
> + * clkpwr_main_osc_ctrl register definitions
> + */
> +#define CLKPWR_MOSC_ADD_CAP(n) ? ? ? ? (((n) & 0x7F) << 2)
> +#define CLKPWR_MOSC_CAP_MASK ? ? ? ? ? (0x7F << 2)
> +#define CLKPWR_TEST_MODE ? ? ? ? ? ? ? _BIT(1)
> +#define CLKPWR_MOSC_DISABLE ? ? ? ? ? ?_BIT(0)
> +
> +/*
> + * clkpwr_sysclk_ctrl register definitions
> + */
> +#define CLKPWR_SYSCTRL_BP_TRIG(n) ? ? ?(((n) & 0x3FF) << 2)
> +#define CLKPWR_SYSCTRL_BP_MASK ? ? ? ? (0x3FF << 2)
> +#define CLKPWR_SYSCTRL_USEPLL397 ? ? ? _BIT(1)
> +#define CLKPWR_SYSCTRL_SYSCLKMUX ? ? ? _BIT(0)
> +
> +/*
> + * clkpwr_lcdclk_ctrl register definitions
> + */
> +#define CLKPWR_LCDCTRL_LCDTYPE_TFT12 ? 0x000
> +#define CLKPWR_LCDCTRL_LCDTYPE_TFT16 ? 0x040
> +#define CLKPWR_LCDCTRL_LCDTYPE_TFT15 ? 0x080
> +#define CLKPWR_LCDCTRL_LCDTYPE_TFT24 ? 0x0C0
> +#define CLKPWR_LCDCTRL_LCDTYPE_STN4M ? 0x100
> +#define CLKPWR_LCDCTRL_LCDTYPE_STN8C ? 0x140
> +#define CLKPWR_LCDCTRL_LCDTYPE_DSTN4M ?0x180
> +#define CLKPWR_LCDCTRL_LCDTYPE_DSTN8C ?0x1C0
> +#define CLKPWR_LCDCTRL_LCDTYPE_MSK ? ? 0x01C0
> +#define CLKPWR_LCDCTRL_CLK_EN ? ? ? ? ?0x020
> +#define CLKPWR_LCDCTRL_SET_PSCALE(n) ? ((n - 1) & 0x1F)
> +#define CLKPWR_LCDCTRL_PSCALE_MSK ? ? ?0x001F
> +
> +/*
> + * clkpwr_hclkpll_ctrl register definitions
> + */
> +#define CLKPWR_HCLKPLL_POWER_UP ? ? ? ? ? ? ? ?_BIT(16)
> +#define CLKPWR_HCLKPLL_CCO_BYPASS ? ? ?_BIT(15)
> +#define CLKPWR_HCLKPLL_POSTDIV_BYPASS ?_BIT(14)
> +#define CLKPWR_HCLKPLL_FDBK_SEL_FCLK ? _BIT(13)
> +#define CLKPWR_HCLKPLL_POSTDIV_2POW(n) (((n) & 0x3) << 11)
> +#define CLKPWR_HCLKPLL_PREDIV_PLUS1(n) (((n) & 0x3) << 9)
> +#define CLKPWR_HCLKPLL_PLLM(n) ? ? ? ? (((n) & 0xFF) << 1)
> +#define CLKPWR_HCLKPLL_PLL_STS ? ? ? ? _BIT(0)
> +
> +/*
> + * clkpwr_adc_clk_ctrl_1 register definitions
> + */
> +#define CLKPWR_ADCCTRL1_RTDIV(n) ? ? ? (((n) & 0xFF) << 0)
> +#define CLKPWR_ADCCTRL1_PCLK_SEL ? ? ? _BIT(8)
> +
> +/*
> + * clkpwr_usb_ctrl register definitions
> + */
> +#define CLKPWR_USBCTRL_HCLK_EN ? ? ? ? _BIT(24)
> +#define CLKPWR_USBCTRL_USBI2C_EN ? ? ? _BIT(23)
> +#define CLKPWR_USBCTRL_USBDVND_EN ? ? ?_BIT(22)
> +#define CLKPWR_USBCTRL_USBHSTND_EN ? ? _BIT(21)
> +#define CLKPWR_USBCTRL_PU_ADD ? ? ? ? ?(0x0 << 19)
> +#define CLKPWR_USBCTRL_BUS_KEEPER ? ? ?(0x1 << 19)
> +#define CLKPWR_USBCTRL_PD_ADD ? ? ? ? ?(0x3 << 19)
> +#define CLKPWR_USBCTRL_CLK_EN2 ? ? ? ? _BIT(18)
> +#define CLKPWR_USBCTRL_CLK_EN1 ? ? ? ? _BIT(17)
> +#define CLKPWR_USBCTRL_PLL_PWRUP ? ? ? _BIT(16)
> +#define CLKPWR_USBCTRL_CCO_BYPASS ? ? ?_BIT(15)
> +#define CLKPWR_USBCTRL_POSTDIV_BYPASS ?_BIT(14)
> +#define CLKPWR_USBCTRL_FDBK_SEL_FCLK ? _BIT(13)
> +#define CLKPWR_USBCTRL_POSTDIV_2POW(n) (((n) & 0x3) << 11)
> +#define CLKPWR_USBCTRL_PREDIV_PLUS1(n) (((n) & 0x3) << 9)
> +#define CLKPWR_USBCTRL_FDBK_PLUS1(n) ? (((n) & 0xFF) << 1)
> +#define CLKPWR_USBCTRL_PLL_STS ? ? ? ? _BIT(0)
> +
> +/*
> + * clkpwr_sdramclk_ctrl register definitions
> + */
> +#define CLKPWR_SDRCLK_FASTSLEW_CLK ? ? _BIT(22)
> +#define CLKPWR_SDRCLK_FASTSLEW ? ? ? ? _BIT(21)
> +#define CLKPWR_SDRCLK_FASTSLEW_DAT ? ? _BIT(20)
> +#define CLKPWR_SDRCLK_SW_DDR_RESET ? ? _BIT(19)
> +#define CLKPWR_SDRCLK_HCLK_DLY(n) ? ? ?(((n) & 0x1F) << 14)
> +#define CLKPWR_SDRCLK_DLY_ADDR_STS ? ? _BIT(13)
> +#define CLKPWR_SDRCLK_SENS_FACT(n) ? ? (((n) & 0x7) << 10)
> +#define CLKPWR_SDRCLK_USE_CAL ? ? ? ? ?_BIT(9)
> +#define CLKPWR_SDRCLK_DO_CAL ? ? ? ? ? _BIT(8)
> +#define CLKPWR_SDRCLK_CAL_ON_RTC ? ? ? _BIT(7)
> +#define CLKPWR_SDRCLK_DQS_DLY(n) ? ? ? (((n) & 0x1F) << 2)
> +#define CLKPWR_SDRCLK_USE_DDR ? ? ? ? ?_BIT(1)
> +#define CLKPWR_SDRCLK_CLK_DIS ? ? ? ? ?_BIT(0)
> +
> +/*
> + * clkpwr_ssp_blk_ctrl register definitions
> + */
> +#define CLKPWR_SSPCTRL_DMA_SSP1RX ? ? ?_BIT(5)
> +#define CLKPWR_SSPCTRL_DMA_SSP1TX ? ? ?_BIT(4)
> +#define CLKPWR_SSPCTRL_DMA_SSP0RX ? ? ?_BIT(3)
> +#define CLKPWR_SSPCTRL_DMA_SSP0TX ? ? ?_BIT(2)
> +#define CLKPWR_SSPCTRL_SSPCLK1_EN ? ? ?_BIT(1)
> +#define CLKPWR_SSPCTRL_SSPCLK0_EN ? ? ?_BIT(0)
> +
> +/*
> + * clkpwr_i2s_clk_ctrl register definitions
> + */
> +#define CLKPWR_I2SCTRL_I2S1_RX_FOR_TX ?_BIT(6)
> +#define CLKPWR_I2SCTRL_I2S1_TX_FOR_RX ?_BIT(5)
> +#define CLKPWR_I2SCTRL_I2S1_USE_DMA ? ?_BIT(4)
> +#define CLKPWR_I2SCTRL_I2S0_RX_FOR_TX ?_BIT(3)
> +#define CLKPWR_I2SCTRL_I2S0_TX_FOR_RX ?_BIT(2)
> +#define CLKPWR_I2SCTRL_I2SCLK1_EN ? ? ?_BIT(1)
> +#define CLKPWR_I2SCTRL_I2SCLK0_EN ? ? ?_BIT(0)
> +
> +/*
> + * clkpwr_ms_ctrl register definitions
> + */
> +#define CLKPWR_MSCARD_MSDIO_PIN_DIS ? ?_BIT(10)
> +#define CLKPWR_MSCARD_MSDIO_PU_EN ? ? ?_BIT(9)
> +#define CLKPWR_MSCARD_MSDIO23_DIS ? ? ?_BIT(8)
> +#define CLKPWR_MSCARD_MSDIO1_DIS ? ? ? _BIT(7)
> +#define CLKPWR_MSCARD_MSDIO0_DIS ? ? ? _BIT(6)
> +#define CLKPWR_MSCARD_SDCARD_EN ? ? ? ? ? ? ? ?_BIT(5)
> +#define CLKPWR_MSCARD_SDCARD_DIV(n) ? ?((n) & 0xF)
> +
> +/*
> + * clkpwr_macclk_ctrl register definitions
> + */
> +#define CLKPWR_MACCTRL_NO_ENET_PIS ? ? 0x00
> +#define CLKPWR_MACCTRL_USE_MII_PINS ? ?0x08
> +#define CLKPWR_MACCTRL_USE_RMII_PINS ? 0x18
> +#define CLKPWR_MACCTRL_PINS_MSK ? ? ? ? ? ? ? ?0x18
> +#define CLKPWR_MACCTRL_DMACLK_EN ? ? ? _BIT(2)
> +#define CLKPWR_MACCTRL_MMIOCLK_EN ? ? ?_BIT(1)
> +#define CLKPWR_MACCTRL_HRCCLK_EN ? ? ? _BIT(0)
> +
> +/*
> + * clkpwr_test_clk_sel register definitions
> + */
> +#define CLKPWR_TESTCLK1_SEL_PERCLK ? ? (0x0 << 5)
> +#define CLKPWR_TESTCLK1_SEL_RTC ? ? ? ? ? ? ? ?(0x1 << 5)
> +#define CLKPWR_TESTCLK1_SEL_MOSC ? ? ? (0x2 << 5)
> +#define CLKPWR_TESTCLK1_SEL_MASK ? ? ? (0x3 << 5)
> +#define CLKPWR_TESTCLK_TESTCLK1_EN ? ? _BIT(4)
> +#define CLKPWR_TESTCLK2_SEL_HCLK ? ? ? (0x0 << 1)
> +#define CLKPWR_TESTCLK2_SEL_PERCLK ? ? (0x1 << 1)
> +#define CLKPWR_TESTCLK2_SEL_USBCLK ? ? (0x2 << 1)
> +#define CLKPWR_TESTCLK2_SEL_MOSC ? ? ? (0x5 << 1)
> +#define CLKPWR_TESTCLK2_SEL_PLL397 ? ? (0x7 << 1)
> +#define CLKPWR_TESTCLK2_SEL_MASK ? ? ? (0x7 << 1)
> +#define CLKPWR_TESTCLK_TESTCLK2_EN ? ? _BIT(0)
> +
> +/*
> + * clkpwr_sw_int register definitions
> + */
> +#define CLKPWR_SW_INT(n) ? ? ? ? ? ? ? (_BIT(0) | (((n) & 0x7F) << 1))
> +#define CLKPWR_SW_GET_ARG(n) ? ? ? ? ? (((n) & 0xFE) >> 1)
> +
> +/*
> + * clkpwr_i2c_clk_ctrl register definitions
> + */
> +#define CLKPWR_I2CCLK_USBI2CHI_DRIVE ? _BIT(4)
> +#define CLKPWR_I2CCLK_I2C2HI_DRIVE ? ? _BIT(3)
> +#define CLKPWR_I2CCLK_I2C1HI_DRIVE ? ? _BIT(2)
> +#define CLKPWR_I2CCLK_I2C2CLK_EN ? ? ? _BIT(1)
> +#define CLKPWR_I2CCLK_I2C1CLK_EN ? ? ? _BIT(0)
> +
> +/*
> + * clkpwr_key_clk_ctrl register definitions
> + */
> +#define CLKPWR_KEYCLKCTRL_CLK_EN ? ? ? 0x1
> +
> +/*
> + * clkpwr_adc_clk_ctrl register definitions
> + */
> +#define CLKPWR_ADC32CLKCTRL_CLK_EN ? ? 0x1
> +
> +/*
> + * clkpwr_pwm_clk_ctrl register definitions
> + */
> +#define CLKPWR_PWMCLK_PWM2_DIV(n) ? ? ?(((n) & 0xF) << 8)
> +#define CLKPWR_PWMCLK_PWM1_DIV(n) ? ? ?(((n) & 0xF) << 4)
> +#define CLKPWR_PWMCLK_PWM2SEL_PCLK ? ? 0x8
> +#define CLKPWR_PWMCLK_PWM2CLK_EN ? ? ? 0x4
> +#define CLKPWR_PWMCLK_PWM1SEL_PCLK ? ? 0x2
> +#define CLKPWR_PWMCLK_PWM1CLK_EN ? ? ? 0x1
> +
> +/*
> + * clkpwr_timer_clk_ctrl register definitions
> + */
> +#define CLKPWR_PWMCLK_HSTIMER_EN ? ? ? 0x2
> +#define CLKPWR_PWMCLK_WDOG_EN ? ? ? ? ?0x1
> +
> +/*
> + * clkpwr_timers_pwms_clk_ctrl_1 register definitions
> + */
> +#define CLKPWR_TMRPWMCLK_TIMER3_EN ? ? 0x20
> +#define CLKPWR_TMRPWMCLK_TIMER2_EN ? ? 0x10
> +#define CLKPWR_TMRPWMCLK_TIMER1_EN ? ? 0x08
> +#define CLKPWR_TMRPWMCLK_TIMER0_EN ? ? 0x04
> +#define CLKPWR_TMRPWMCLK_PWM4_EN ? ? ? 0x02
> +#define CLKPWR_TMRPWMCLK_PWM3_EN ? ? ? 0x01
> +
> +/*
> + * clkpwr_spi_clk_ctrl register definitions
> + */
> +#define CLKPWR_SPICLK_SET_SPI2DATIO ? ?0x80
> +#define CLKPWR_SPICLK_SET_SPI2CLK ? ? ?0x40
> +#define CLKPWR_SPICLK_USE_SPI2 ? ? ? ? 0x20
> +#define CLKPWR_SPICLK_SPI2CLK_EN ? ? ? 0x10
> +#define CLKPWR_SPICLK_SET_SPI1DATIO ? ?0x08
> +#define CLKPWR_SPICLK_SET_SPI1CLK ? ? ?0x04
> +#define CLKPWR_SPICLK_USE_SPI1 ? ? ? ? 0x02
> +#define CLKPWR_SPICLK_SPI1CLK_EN ? ? ? 0x01
> +
> +/*
> + * clkpwr_nand_clk_ctrl register definitions
> + */
> +#define CLKPWR_NANDCLK_INTSEL_MLC ? ? ?0x20
> +#define CLKPWR_NANDCLK_DMA_RNB ? ? ? ? 0x10
> +#define CLKPWR_NANDCLK_DMA_INT ? ? ? ? 0x08
> +#define CLKPWR_NANDCLK_SEL_SLC ? ? ? ? 0x04
> +#define CLKPWR_NANDCLK_MLCCLK_EN ? ? ? 0x02
> +#define CLKPWR_NANDCLK_SLCCLK_EN ? ? ? 0x01
> +
> +/*
> + * clkpwr_uart3_clk_ctrl, clkpwr_uart4_clk_ctrl, clkpwr_uart5_clk_ctrl
> + * and clkpwr_uart6_clk_ctrl register definitions
> + */
> +#define CLKPWR_UART_Y_DIV(y) ? ? ? ? ? ((y) & 0xFF)
> +#define CLKPWR_UART_X_DIV(x) ? ? ? ? ? (((x) & 0xFF) << 8)
> +#define CLKPWR_UART_USE_HCLK ? ? ? ? ? _BIT(16)
> +
> +/*
> + * clkpwr_irda_clk_ctrl register definitions
> + */
> +#define CLKPWR_IRDA_Y_DIV(y) ? ? ? ? ? ((y) & 0xFF)
> +#define CLKPWR_IRDA_X_DIV(x) ? ? ? ? ? (((x) & 0xFF) << 8)
> +
> +/*
> + * clkpwr_uart_clk_ctrl register definitions
> + */
> +#define CLKPWR_UARTCLKCTRL_UART6_EN ? ?_BIT(3)
> +#define CLKPWR_UARTCLKCTRL_UART5_EN ? ?_BIT(2)
> +#define CLKPWR_UARTCLKCTRL_UART4_EN ? ?_BIT(1)
> +#define CLKPWR_UARTCLKCTRL_UART3_EN ? ?_BIT(0)
> +
> +/*
> + * clkpwr_dmaclk_ctrl register definitions
> + */
> +#define CLKPWR_DMACLKCTRL_CLK_EN ? ? ? 0x1
> +
> +/*
> + * clkpwr_autoclock register definitions
> + */
> +#define CLKPWR_AUTOCLK_USB_EN ? ? ? ? ?0x40
> +#define CLKPWR_AUTOCLK_IRAM_EN ? ? ? ? 0x02
> +#define CLKPWR_AUTOCLK_IROM_EN ? ? ? ? 0x01
> +
> +/*
> + *
> + * Timer/counter register offsets
> + *
> + */
> +#define TIMER_IR(x) ? ? ? ? ? ? ? ? ? ?(x + 0x00)
> +#define TIMER_TCR(x) ? ? ? ? ? ? ? ? ? (x + 0x04)
> +#define TIMER_TC(x) ? ? ? ? ? ? ? ? ? ?(x + 0x08)
> +#define TIMER_PR(x) ? ? ? ? ? ? ? ? ? ?(x + 0x0C)
> +#define TIMER_PC(x) ? ? ? ? ? ? ? ? ? ?(x + 0x10)
> +#define TIMER_MCR(x) ? ? ? ? ? ? ? ? ? (x + 0x14)
> +#define TIMER_MR0(x) ? ? ? ? ? ? ? ? ? (x + 0x18)
> +#define TIMER_MR1(x) ? ? ? ? ? ? ? ? ? (x + 0x1C)
> +#define TIMER_MR2(x) ? ? ? ? ? ? ? ? ? (x + 0x20)
> +#define TIMER_MR3(x) ? ? ? ? ? ? ? ? ? (x + 0x24)
> +#define TIMER_CCR(x) ? ? ? ? ? ? ? ? ? (x + 0x28)
> +#define TIMER_CR0(x) ? ? ? ? ? ? ? ? ? (x + 0x2C)
> +#define TIMER_CR1(x) ? ? ? ? ? ? ? ? ? (x + 0x30)
> +#define TIMER_CR2(x) ? ? ? ? ? ? ? ? ? (x + 0x34)
> +#define TIMER_CR3(x) ? ? ? ? ? ? ? ? ? (x + 0x38)
> +#define TIMER_EMR(x) ? ? ? ? ? ? ? ? ? (x + 0x3C)
> +#define TIMER_CTCR(x) ? ? ? ? ? ? ? ? ?(x + 0x70)
> +
> +/*
> + * ir register definitions
> + */
> +#define TIMER_CNTR_MTCH_BIT(n) ? ? ? ? (1 << ((n) & 0x3))
> +#define TIMER_CNTR_CAPT_BIT(n) ? ? ? ? (1 << (4 + ((n) & 0x3)))
> +
> +/*
> + * tcr register definitions
> + */
> +#define TIMER_CNTR_TCR_EN ? ? ? ? ? ? ?0x1
> +#define TIMER_CNTR_TCR_RESET ? ? ? ? ? 0x2
> +
> +/*
> + * mcr register definitions
> + */
> +#define TIMER_CNTR_MCR_MTCH(n) ? ? ? ? (0x1 << ((n) * 3))
> +#define TIMER_CNTR_MCR_RESET(n) ? ? ? ? ? ? ? ?(0x1 << (((n) * 3) + 1))
> +#define TIMER_CNTR_MCR_STOP(n) ? ? ? ? (0x1 << (((n) * 3) + 2))
> +
> +/*
> + * ccr register definitions
> + */
> +#define TIMER_CNTR_CCR_CAPNRE(n) ? ? ? (0x1 << ((n) * 3))
> +#define TIMER_CNTR_CCR_CAPNFE(n) ? ? ? (0x1 << (((n) * 3) + 1))
> +#define TIMER_CNTR_CCR_CAPNI(n) ? ? ? ? ? ? ? ?(0x1 << (((n) * 3) + 2))
> +
> +/*
> + * emr register definitions
> + */
> +#define TIMER_CNTR_EMR_DRIVE(n) ? ? ? ? ? ? ? ?(1 << (n))
> +#define TIMER_CNTR_EMR_DRIVE_SET(n, s) (((s) & 0x1) << (n))
> +#define TIMER_CNTR_EMR_NOTHING ? ? ? ? 0x0
> +#define TIMER_CNTR_EMR_LOW ? ? ? ? ? ? 0x1
> +#define TIMER_CNTR_EMR_HIGH ? ? ? ? ? ?0x2
> +#define TIMER_CNTR_EMR_TOGGLE ? ? ? ? ?0x3
> +#define TIMER_CNTR_EMR_EMC_SET(n, s) ? (((s) & 0x3) << (4 + ((n) * 2)))
> +#define TIMER_CNTR_EMR_EMC_MASK(n) ? ? (0x3 << (4 + ((n) * 2)))
> +
> +/*
> + * ctcr register definitions
> + */
> +#define TIMER_CNTR_CTCR_MODE_MASK ? ? ?0x3
> +#define TIMER_CNTR_CTCR_INPUT_MASK ? ? 0xC
> +#define TIMER_CNTR_CTCR_TIMER_MODE ? ? 0x0
> +#define TIMER_CNTR_CTCR_TCINC_MODE ? ? 0x1
> +#define TIMER_CNTR_CTCR_TCDEC_MODE ? ? 0x2
> +#define TIMER_CNTR_CTCR_TCBOTH_MODE ? ?0x3
> +#define TIMER_CNTR_CTCR_INPUT_CAP0 ? ? 0x0
> +#define TIMER_CNTR_CTCR_INPUT_CAP1 ? ? 0x1
> +#define TIMER_CNTR_CTCR_INPUT_CAP2 ? ? 0x2
> +#define TIMER_CNTR_CTCR_INPUT_CAP3 ? ? 0x3
> +#define TIMER_CNTR_SET_MODE(n) ? ? ? ? ((n) & 0x3)
> +#define TIMER_CNTR_SET_INPUT(n) ? ? ? ? ? ? ? ?(((n) & 0x3) << 2)
> +
> +/*
> + *
> + * Standard UART register offsets
> + *
> + */
> +#define UART_DLL_FIFO(x) ? ? ? ? ? ? ? (x + 0x00)
> +#define UART_DLM_IER(x) ? ? ? ? ? ? ? ? ? ? ? ?(x + 0x04)
> +#define UART_IIR_FCR(x) ? ? ? ? ? ? ? ? ? ? ? ?(x + 0x08)
> +#define UART_LCR_(x) ? ? ? ? ? ? ? ? ? (x + 0x0C)
> +#define UART_MODEM_CTRL(x) ? ? ? ? ? ? (x + 0x10)
> +#define UART_LSR_(x) ? ? ? ? ? ? ? ? ? (x + 0x14)
> +#define UART_MODEM_STATUS(x) ? ? ? ? ? (x + 0x18)
> +#define UART_RXLEV(x) ? ? ? ? ? ? ? ? ?(x + 0x1C)
> +
> +/*
> + *
> + * UART control structure offsets
> + *
> + */
> +#define UARTCTL_CTRL(x) ? ? ? ? ? ? ? ? ? ? ? ?(x + 0x00)
> +#define UARTCTL_CLKMODE(x) ? ? ? ? ? ? (x + 0x04)
> +#define UARTCTL_CLOOP(x) ? ? ? ? ? ? ? (x + 0x08)
> +
> +/*
> + * dll and dlm register definitions
> + */
> +#define UART_LOAD_DM(div) ? ? ? ? ? ? ?((div) & 0xFF)
> +
> +/*
> + * ier register definitions
> + */
> +#define UART_IER_MODEM_STS ? ? ? ? ? ? _BIT(3)
> +#define UART_IER_RXLINE_STS ? ? ? ? ? ?_BIT(2)
> +#define UART_IER_THRE ? ? ? ? ? ? ? ? ?_BIT(1)
> +#define UART_IER_RDA ? ? ? ? ? ? ? ? ? _BIT(0)
> +
> +/*
> + * iir register definitions
> + */
> +#define UART_IIR_INT_PENDING ? ? ? ? ? _BIT(0)
> +#define UART_IIR_INT_MASK ? ? ? ? ? ? ?0xE
> +#define UART_IIR_MODEM_STS ? ? ? ? ? ? 0x0
> +#define UART_IIR_INTSRC_THRE ? ? ? ? ? 0x2
> +#define UART_IIR_INTSRC_RDA ? ? ? ? ? ?0x4
> +#define UART_IIR_INTSRC_RXLINE ? ? ? ? 0x6
> +#define UART_IIR_INTSRC_CTI ? ? ? ? ? ?0xC
> +#define UART_IIR_INTSRC_MASK ? ? ? ? ? 0xE
> +
> +/*
> + * fcr register definitions
> + */
> +#define UART_FCR_RXFIFO_TL16 ? ? ? ? ? 0x0
> +#define UART_FCR_RXFIFO_TL32 ? ? ? ? ? _BIT(6)
> +#define UART_FCR_RXFIFO_TL48 ? ? ? ? ? _BIT(7)
> +#define UART_FCR_RXFIFO_TL60 ? ? ? ? ? (_BIT(7) | _BIT(6))
> +#define UART_FCR_TXFIFO_TL0 ? ? ? ? ? ?0x0
> +#define UART_FCR_TXFIFO_TL4 ? ? ? ? ? ?_BIT(4)
> +#define UART_FCR_TXFIFO_TL8 ? ? ? ? ? ?_BIT(5)
> +#define UART_FCR_TXFIFO_TL16 ? ? ? ? ? (_BIT(5) | _BIT(4))
> +#define UART_FCR_FIFO_CTRL ? ? ? ? ? ? _BIT(3)
> +#define UART_FCR_TXFIFO_FLUSH ? ? ? ? ?_BIT(2)
> +#define UART_FCR_RXFIFO_FLUSH ? ? ? ? ?_BIT(1)
> +#define UART_FCR_FIFO_EN ? ? ? ? ? ? ? _BIT(0)
> +
> +/*
> + * lcr register definitions
> + */
> +#define UART_LCR_DIVLATCH_EN ? ? ? ? ? _BIT(7)
> +#define UART_LCR_BREAK_EN ? ? ? ? ? ? ?_BIT(6)
> +#define UART_LCR_PARITY_ODD ? ? ? ? ? ?0x0
> +#define UART_LCR_PARITY_EVEN ? ? ? ? ? _BIT(4)
> +#define UART_LCR_PARITY_FORCE1 ? ? ? ? _BIT(5)
> +#define UART_LCR_PARITY_FORCE0 ? ? ? ? (_BIT(5) | _BIT(4))
> +#define UART_LCR_PARITY_MASK ? ? ? ? ? (_BIT(5) | _BIT(4))
> +#define UART_LCR_PARITY_ENABLE ? ? ? ? _BIT(3)
> +#define UART_LCR_STOP1BIT ? ? ? ? ? ? ?0x0
> +#define UART_LCR_STOP2BITS ? ? ? ? ? ? _BIT(2)
> +#define UART_LCR_WLEN_5BITS ? ? ? ? ? ?0x0
> +#define UART_LCR_WLEN_6BITS ? ? ? ? ? ?_BIT(0)
> +#define UART_LCR_WLEN_7BITS ? ? ? ? ? ?_BIT(1)
> +#define UART_LCR_WLEN_8BITS ? ? ? ? ? ?(_BIT(1) | _BIT(0))
> +#define UART_LCR_WLEN_MASK ? ? ? ? ? ? (_BIT(1) | _BIT(0))
> +
> +/*
> + * modem_ctrl register definitions
> + */
> +#define UART_MDMC_LOOPB_EN ? ? ? ? ? ? _BIT(4)
> +#define UART_MDMC_RTS_LOW ? ? ? ? ? ? ?_BIT(1)
> +#define UART_MDMC_DTR_LOW ? ? ? ? ? ? ?_BIT(0)
> +
> +/*
> + * lsr register definitions
> + */
> +#define UART_LSR_FIFORX_ERR ? ? ? ? ? ?_BIT(7)
> +#define UART_LSR_TEMT_ ? ? ? ? ? ? ? ? _BIT(6)
> +#define UART_LSR_THRE_ ? ? ? ? ? ? ? ? _BIT(5)
> +#define UART_LSR_BI_ ? ? ? ? ? ? ? ? ? _BIT(4)
> +#define UART_LSR_FR_ ? ? ? ? ? ? ? ? ? _BIT(3)
> +#define UART_LSR_PE_ ? ? ? ? ? ? ? ? ? _BIT(2)
> +#define UART_LSR_OE_ ? ? ? ? ? ? ? ? ? _BIT(1)
> +#define UART_LSR_RDR_ ? ? ? ? ? ? ? ? ?_BIT(0)
> +
> +/*
> + * modem_status register definitions
> + */
> +#define UART_MDMS_DCD ? ? ? ? ? ? ? ? ?_BIT(7)
> +#define UART_MDMS_RI ? ? ? ? ? ? ? ? ? _BIT(6)
> +#define UART_MDMS_DSR ? ? ? ? ? ? ? ? ?_BIT(5)
> +#define UART_MDMS_CTS ? ? ? ? ? ? ? ? ?_BIT(4)
> +#define UART_MDMS_DCD_CHG ? ? ? ? ? ? ?_BIT(3)
> +#define UART_MDMS_RI_CHG ? ? ? ? ? ? ? _BIT(2)
> +#define UART_MDMS_DSR_CHG ? ? ? ? ? ? ?_BIT(1)
> +#define UART_MDMS_CTS_CHG ? ? ? ? ? ? ?_BIT(0)
> +
> +/*
> + * rxlev register definitions
> + */
> +#define UART_RXLEVL(n) ? ? ? ? ? ? ? ? ((n) & 0x7F)
> +
> +/*
> + * ctrl register definitions
> + */
> +#define UART_U3_MD_CTRL_EN ? ? ? ? ? ? _BIT(11)
> +#define UART_IRRX6_INV_EN ? ? ? ? ? ? ?_BIT(10)
> +#define UART_HDPX_EN ? ? ? ? ? ? ? ? ? _BIT(9)
> +#define UART_UART6_IRDAMOD_BYPASS ? ? ?_BIT(5)
> +#define RT_IRTX6_INV_EN ? ? ? ? ? ? ? ? ? ? ? ?_BIT(4)
> +#define RT_IRTX6_INV_MIR_EN ? ? ? ? ? ?_BIT(3)
> +#define RT_RX_IRPULSE_3_16_115K ? ? ? ? ? ? ? ?_BIT(2)
> +#define RT_TX_IRPULSE_3_16_115K ? ? ? ? ? ? ? ?_BIT(1)
> +#define UART_U5_ROUTE_TO_USB ? ? ? ? ? _BIT(0)
> +
> +/*
> + * clkmode register definitions
> + */
> +#define UART_ENABLED_CLOCKS(n) ? ? ? ? (((n) >> 16) & 0x7F)
> +#define UART_ENABLED_CLOCK(n, u) ? ? ? (((n) >> (16 + (u))) & 0x1)
> +#define UART_ENABLED_CLKS_ANY ? ? ? ? ?_BIT(14)
> +#define UART_CLKMODE_OFF ? ? ? ? ? ? ? 0x0
> +#define UART_CLKMODE_ON ? ? ? ? ? ? ? ? ? ? ? ?0x1
> +#define UART_CLKMODE_AUTO ? ? ? ? ? ? ?0x2
> +#define UART_CLKMODE_MASK(u) ? ? ? ? ? (0x3 << ((((u) - 3) * 2) + 4))
> +#define UART_CLKMODE_LOAD(m, u) ? ? ? ? ? ? ? ?((m) << ((((u) - 3) * 2) + 4))
> +
> +/*
> + * loop register definitions
> + */
> +#define UART_LPBACK_ENABLED(u) ? ? ? ? (0x1 << ((u) - 1))
> +
> +/*
> + *
> + * GPIO Module Register offsets
> + *
> + */
> +#define GPIO_P3_INP_STATE(x) ? ? ? ? ? (x + 0x000)
> +#define GPIO_P3_OUTP_SET(x) ? ? ? ? ? ?(x + 0x004)
> +#define GPIO_P3_OUTP_CLR(x) ? ? ? ? ? ?(x + 0x008)
> +#define GPIO_P3_OUTP_STATE(x) ? ? ? ? ?(x + 0x00C)
> +#define GPIO_P2_DIR_SET(x) ? ? ? ? ? ? (x + 0x010)
> +#define GPIO_P2_DIR_CLR(x) ? ? ? ? ? ? (x + 0x014)
> +#define GPIO_P2_DIR_STATE(x) ? ? ? ? ? (x + 0x018)
> +#define GPIO_P2_INP_STATE(x) ? ? ? ? ? (x + 0x01C)
> +#define GPIO_P2_OUTP_SET(x) ? ? ? ? ? ?(x + 0x020)
> +#define GPIO_P2_OUTP_CLR(x) ? ? ? ? ? ?(x + 0x024)
> +#define GPIO_P2_MUX_SET(x) ? ? ? ? ? ? (x + 0x028)
> +#define GPIO_P2_MUX_CLR(x) ? ? ? ? ? ? (x + 0x02C)
> +#define GPIO_P2_MUX_STATE(x) ? ? ? ? ? (x + 0x030)
> +#define GPIO_P0_INP_STATE(x) ? ? ? ? ? (x + 0x040)
> +#define GPIO_P0_OUTP_SET(x) ? ? ? ? ? ?(x + 0x044)
> +#define GPIO_P0_OUTP_CLR(x) ? ? ? ? ? ?(x + 0x048)
> +#define GPIO_P0_OUTP_STATE(x) ? ? ? ? ?(x + 0x04C)
> +#define GPIO_P0_DIR_SET(x) ? ? ? ? ? ? (x + 0x050)
> +#define GPIO_P0_DIR_CLR(x) ? ? ? ? ? ? (x + 0x054)
> +#define GPIO_P0_DIR_STATE(x) ? ? ? ? ? (x + 0x058)
> +#define GPIO_P1_INP_STATE(x) ? ? ? ? ? (x + 0x060)
> +#define GPIO_P1_OUTP_SET(x) ? ? ? ? ? ?(x + 0x064)
> +#define GPIO_P1_OUTP_CLR(x) ? ? ? ? ? ?(x + 0x068)
> +#define GPIO_P1_OUTP_STATE(x) ? ? ? ? ?(x + 0x06C)
> +#define GPIO_P1_DIR_SET(x) ? ? ? ? ? ? (x + 0x070)
> +#define GPIO_P1_DIR_CLR(x) ? ? ? ? ? ? (x + 0x074)
> +#define GPIO_P1_DIR_STATE(x) ? ? ? ? ? (x + 0x078)
> +#define GPIO_P_MUX_SET(x) ? ? ? ? ? ? ?(x + 0x100)
> +#define GPIO_P_MUX_CLR(x) ? ? ? ? ? ? ?(x + 0x104)
> +#define GPIO_P_MUX_STATE(x) ? ? ? ? ? ?(x + 0x108)
> +#define GPIO_P3_MUX_SET(x) ? ? ? ? ? ? (x + 0x110)
> +#define GPIO_P3_MUX_CLR(x) ? ? ? ? ? ? (x + 0x114)
> +#define GPIO_P3_MUX_STATE(x) ? ? ? ? ? (x + 0x118)
> +#define GPIO_P0_MUX_SET(x) ? ? ? ? ? ? (x + 0x120)
> +#define GPIO_P0_MUX_CLR(x) ? ? ? ? ? ? (x + 0x124)
> +#define GPIO_P0_MUX_STATE(x) ? ? ? ? ? (x + 0x128)
> +#define GPIO_P1_MUX_SET(x) ? ? ? ? ? ? (x + 0x130)
> +#define GPIO_P1_MUX_CLR(x) ? ? ? ? ? ? (x + 0x134)
> +#define GPIO_P1_MUX_STATE(x) ? ? ? ? ? (x + 0x138)
> +
> +/*
> + * Input Pin State Register defines
> + */
> +#define INP_STATE_GPI_00 ? ? ? ? ? ? ? _BIT(0)
> +#define INP_STATE_GPI_01 ? ? ? ? ? ? ? _BIT(1)
> +#define INP_STATE_GPI_02 ? ? ? ? ? ? ? _BIT(2)
> +#define INP_STATE_GPI_03 ? ? ? ? ? ? ? _BIT(3)
> +#define INP_STATE_GPI_04 ? ? ? ? ? ? ? _BIT(4)
> +#define INP_STATE_GPI_05 ? ? ? ? ? ? ? _BIT(5)
> +#define INP_STATE_GPI_06 ? ? ? ? ? ? ? _BIT(6)
> +#define INP_STATE_GPI_07 ? ? ? ? ? ? ? _BIT(7)
> +#define INP_STATE_GPI_08 ? ? ? ? ? ? ? _BIT(8)
> +#define INP_STATE_GPI_09 ? ? ? ? ? ? ? _BIT(9)
> +#define INP_STATE_GPIO_00 ? ? ? ? ? ? ?_BIT(10)
> +#define INP_STATE_GPIO_01 ? ? ? ? ? ? ?_BIT(11)
> +#define INP_STATE_GPIO_02 ? ? ? ? ? ? ?_BIT(12)
> +#define INP_STATE_GPIO_03 ? ? ? ? ? ? ?_BIT(13)
> +#define INP_STATE_GPIO_04 ? ? ? ? ? ? ?_BIT(14)
> +#define INP_STATE_U1_RX ? ? ? ? ? ? ? ? ? ? ? ?_BIT(15)
> +#define INP_STATE_U2_HCTS ? ? ? ? ? ? ?_BIT(16)
> +#define INP_STATE_U2_RX ? ? ? ? ? ? ? ? ? ? ? ?_BIT(17)
> +#define INP_STATE_U3_RX ? ? ? ? ? ? ? ? ? ? ? ?_BIT(18)
> +#define INP_STATE_GPI_19_U4RX ? ? ? ? ?_BIT(19)
> +#define INP_STATE_U5_RX ? ? ? ? ? ? ? ? ? ? ? ?_BIT(20)
> +#define INP_STATE_U6_IRRX ? ? ? ? ? ? ?_BIT(21)
> +#define INP_STATE_U7_HCTS ? ? ? ? ? ? ?_BIT(22)
> +#define INP_STATE_U7_RX ? ? ? ? ? ? ? ? ? ? ? ?_BIT(23)
> +#define INP_STATE_GPIO_05 ? ? ? ? ? ? ?_BIT(24)
> +#define INP_STATE_SPI1_DATIN ? ? ? ? ? _BIT(25)
> +#define INP_STATE_SPI2_DATIN ? ? ? ? ? _BIT(27)
> +#define INP_STATE_GPI_28_U3RI ? ? ? ? ?_BIT(28)
> +
> +/*
> + * p3_outp_set, p3_outp_clr, and p3_outp_state register defines
> + */
> +#define OUTP_STATE_GPO(pin) ? ? ? ? ? ?_BIT(pin)
> +#define OUTP_STATE_GPIO(pin) ? ? ? ? ? _BIT(((pin) + 25))
> +
> +/*
> + * GPIO Direction Register defines
> + */
> +#define PIO_DIR_GPIO(pin) ? ? ? ? ? ? ?_BIT((pin) + 25)
> +#define PIO_SDRAM_DIR_PIN(pin) ? ? ? ? _BIT((pin) - 19)
> +#define PIO_SDRAM_PIN_ALL ? ? ? ? ? ? ?0x00001FFF
> +
> +/*
> + * p_mux_set, p_mux_clr, p_mux_state register defines
> + */
> +#define P_I2STXSDA1_MAT31 ? ? ? ? ? ? ?_BIT(2)
> +#define P_I2STXCLK1_MAT30 ? ? ? ? ? ? ?_BIT(3)
> +#define P_I2STXWS1_CAP30 ? ? ? ? ? ? ? _BIT(4)
> +#define P_SPI2DATAIO_MOSI1 ? ? ? ? ? ? _BIT(5)
> +#define P_SPI2DATAIN_MISO1 ? ? ? ? ? ? _BIT(6)
> +#define P_SPI2CLK_SCK1 ? ? ? ? ? ? ? ? _BIT(8)
> +#define P_SPI1DATAIO_SSP0_MOSI ? ? ? ? _BIT(9)
> +#define P_SPI1DATAIN_SSP0_MISO ? ? ? ? _BIT(10)
> +#define P_SPI1CLK_SCK0 ? ? ? ? ? ? ? ? _BIT(12)
> +#define P_MAT21_PWM36 ? ? ? ? ? ? ? ? ?_BIT(13)
> +#define P_MAT20_PWM35 ? ? ? ? ? ? ? ? ?_BIT(14)
> +#define P_U7TX_MAT11 ? ? ? ? ? ? ? ? ? _BIT(15)
> +#define P_MAT03_PWM34 ? ? ? ? ? ? ? ? ?_BIT(17)
> +#define P_MAT02_PWM33 ? ? ? ? ? ? ? ? ?_BIT(18)
> +#define P_MAT01_PWM32 ? ? ? ? ? ? ? ? ?_BIT(19)
> +#define P_MAT00_PWM31 ? ? ? ? ? ? ? ? ?_BIT(20)
> +
> +/*
> + * p0_mux_set, p0_mux_clr, p0_mux_state register defines
> + */
> +#define OUTP_STATE_GPIO_P0(pin) ? ? ? ? ? ? ? ?_BIT(pin)
> +#define P0_GPOP0_I2SRXCLK1 ? ? ? ? ? ? _BIT(0)
> +#define P0_GPOP1_I2SRXWS1 ? ? ? ? ? ? ?_BIT(1)
> +#define P0_GPOP2_I2SRXSDA0 ? ? ? ? ? ? _BIT(2)
> +#define P0_GPOP3_I2SRXCLK0 ? ? ? ? ? ? _BIT(3)
> +#define P0_GPOP4_I2SRXWS0 ? ? ? ? ? ? ?_BIT(4)
> +#define P0_GPOP5_I2STXSDA0 ? ? ? ? ? ? _BIT(5)
> +#define P0_GPOP6_I2STXCLK0 ? ? ? ? ? ? _BIT(6)
> +#define P0_GPOP7_I2STXWS0 ? ? ? ? ? ? ?_BIT(7)
> +#define P0_ALL ? ? ? ? ? ? ? ? ? ? ? ? 0xFF
> +
> +/*
> + * p1_mux_set, p1_mux_clr, p1_mux_state register defines
> + */
> +#define OUTP_STATE_GPIO_P1(pin) ? ? ? ? ? ? ? ?_BIT(pin)
> +#define P1_ALL ? ? ? ? ? ? ? ? ? ? ? ? ?0x00FFFFFF
> +
> +/*
> + * p2_mux_set, p2_mux_clr, p2_mux_state register defines
> + */
> +#define P2_GPIO05_SSEL0 ? ? ? ? ? ? ? ? ? ? ? ?_BIT(5)
> +#define P2_GPIO04_SSEL1 ? ? ? ? ? ? ? ? ? ? ? ?_BIT(4)
> +#define P2_SDRAMD19D31_GPIO ? ? ? ? ? ?_BIT(3)
> +#define P2_GPO21_U4TX ? ? ? ? ? ? ? ? ?_BIT(2)
> +#define P2_GPIO03_KEYROW7 ? ? ? ? ? ? ?_BIT(1)
> +#define P2_GPIO02_KEYROW6 ? ? ? ? ? ? ?_BIT(0)
> +
> +/*
> + * p3_mux_set, p3_mux_clr, p3_mux_state register defines
> + */
> +#define P3_GPO2_MAT10 ? ? ? ? ? ? ? ? ?_BIT(2)
> +#define P3_GPO6_PWM43 ? ? ? ? ? ? ? ? ?_BIT(6)
> +#define P3_GPO8_PWM42 ? ? ? ? ? ? ? ? ?_BIT(8)
> +#define P3_GPO9_PWM41 ? ? ? ? ? ? ? ? ?_BIT(9)
> +#define P3_GPO10_PWM36 ? ? ? ? ? ? ? ? _BIT(10)
> +#define P3_GPO12_PWM35 ? ? ? ? ? ? ? ? _BIT(12)
> +#define P3_GPO13_PWM34 ? ? ? ? ? ? ? ? _BIT(13)
> +#define P3_GPO15_PWM33 ? ? ? ? ? ? ? ? _BIT(15)
> +#define P3_GPO16_PWM32 ? ? ? ? ? ? ? ? _BIT(16)
> +#define P3_GPO18_PWM31 ? ? ? ? ? ? ? ? _BIT(18)
> +
> +/*
> + * SSP module register offsets
> ?*/
> +#define LSSP_CR0(x) ? ? ? ? ? ? ? ? ? ?(x + 0x00)
> +#define LSSP_CR1(x) ? ? ? ? ? ? ? ? ? ?(x + 0x04)
> +#define LSSP_DATA(x) ? ? ? ? ? ? ? ? ? (x + 0x08)
> +#define LSSP_SR(x) ? ? ? ? ? ? ? ? ? ? (x + 0x0C)
> +#define LSSP_CPSR(x) ? ? ? ? ? ? ? ? ? (x + 0x10)
> +#define LSSP_IMSC(x) ? ? ? ? ? ? ? ? ? (x + 0x14)
> +#define LSSP_ICR(x) ? ? ? ? ? ? ? ? ? ?(x + 0x20)
> +
> +#define LSSP_ICR_RORIC ? ? ? ? ? ? ? ? (1 << 0)
> +#define LSSP_ICR_RTIC ? ? ? ? ? ? ? ? ?(1 << 1)
> +#define LSSP_CR0_DSS(n) ? ? ? ? ? ? ? ? ? ? ? ?_SBF(0, (((n) - 1) & 0xF))
> +#define LSSP_CR0_FRF_SPI ? ? ? ? ? ? ? 0x0
> +#define LSSP_CR0_CPOL(n) ? ? ? ? ? ? ? _SBF(6, ((n) & 0x01))
> +#define LSSP_CR0_CPHA(n) ? ? ? ? ? ? ? _SBF(7, ((n) & 0x01))
> +#define LSSP_CR0_SCR(n) ? ? ? ? ? ? ? ? ? ? ? ?_SBF(8, ((n) & 0xFF))
> +#define LSSP_CR1_SSP_ENABLE ? ? ? ? ? ?(1 << 1)
> +#define LSSP_CPSR_CPDVSR(n) ? ? ? ? ? ?_SBF(0, (n) & 0xFE)
> +#define LSSP_SR_RNE ? ? ? ? ? ? ? ? ? ?(1 << 2)
> +
> +#endif
> --
> 1.6.0.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
