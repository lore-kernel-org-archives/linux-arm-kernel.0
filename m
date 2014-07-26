From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Sat, 26 Jul 2014 20:20:42 +0200
Subject: [PATCH] ARM: i.MX: Remove mach-cpuimx27sd board file
In-Reply-To: <1406382068-13452-1-git-send-email-shc_work@mail.ru>
References: <1406382068-13452-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140726202042.6979888c@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Sat, 26 Jul 2014 17:41:08 +0400,
Alexander Shiyan <shc_work@mail.ru> a ?crit :

> 
> eukrea_mbimx27-baseboard.c and mach-cpuimx27.c can be replaced with their
> devicetree equivalents: imx27-eukrea-mbimxsd27-baseboard.dts and
> imx27-eukrea-cpuimx27.dtsi respectively, so remove the board files.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Acked-by: Eric B?nard <eric@eukrea.com>

Thanks !

> ---
>  arch/arm/configs/imx_v4_v5_defconfig         |   3 -
>  arch/arm/mach-imx/Kconfig                    |  50 ----
>  arch/arm/mach-imx/Makefile                   |   2 -
>  arch/arm/mach-imx/eukrea-baseboards.h        |  10 +-
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c | 351 ---------------------------
>  arch/arm/mach-imx/mach-cpuimx27.c            | 321 ------------------------
>  6 files changed, 1 insertion(+), 736 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
>  delete mode 100644 arch/arm/mach-imx/mach-cpuimx27.c
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index 63bde0e..f53074c 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -31,9 +31,6 @@ CONFIG_MACH_EUKREA_CPUIMX25SD=y
>  CONFIG_MACH_IMX25_DT=y
>  CONFIG_MACH_MX27ADS=y
>  CONFIG_MACH_PCM038=y
> -CONFIG_MACH_CPUIMX27=y
> -CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2=y
> -CONFIG_MACH_EUKREA_CPUIMX27_USEUART4=y
>  CONFIG_MACH_MX27_3DS=y
>  CONFIG_MACH_IMX27_VISSTRIM_M10=y
>  CONFIG_MACH_PCA100=y
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c6810b8..901e9ab 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -263,56 +263,6 @@ config MACH_PCM970_BASEBOARD
>  
>  endchoice
>  
> -config MACH_CPUIMX27
> -	bool "Eukrea CPUIMX27 module"
> -	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
> -	select IMX_HAVE_PLATFORM_IMX2_WDT
> -	select IMX_HAVE_PLATFORM_IMX_I2C
> -	select IMX_HAVE_PLATFORM_IMX_UART
> -	select IMX_HAVE_PLATFORM_MXC_EHCI
> -	select IMX_HAVE_PLATFORM_MXC_NAND
> -	select IMX_HAVE_PLATFORM_MXC_W1
> -	select USB_ULPI_VIEWPORT if USB_ULPI
> -	select SOC_IMX27
> -	help
> -	  Include support for Eukrea CPUIMX27 platform. This includes
> -	  specific configurations for the module and its peripherals.
> -
> -config MACH_EUKREA_CPUIMX27_USESDHC2
> -	bool "CPUIMX27 integrates SDHC2 module"
> -	depends on MACH_CPUIMX27
> -	select IMX_HAVE_PLATFORM_MXC_MMC
> -	help
> -	  This adds support for the internal SDHC2 used on CPUIMX27
> -	  for wifi or eMMC.
> -
> -config MACH_EUKREA_CPUIMX27_USEUART4
> -	bool "CPUIMX27 integrates UART4 module"
> -	depends on MACH_CPUIMX27
> -	help
> -	  This adds support for the internal UART4 used on CPUIMX27
> -	  for bluetooth.
> -
> -choice
> -	prompt "Baseboard"
> -	depends on MACH_CPUIMX27
> -	default MACH_EUKREA_MBIMX27_BASEBOARD
> -
> -config MACH_EUKREA_MBIMX27_BASEBOARD
> -	bool "Eukrea MBIMX27 development board"
> -	select IMX_HAVE_PLATFORM_IMX_FB
> -	select IMX_HAVE_PLATFORM_IMX_KEYPAD
> -	select IMX_HAVE_PLATFORM_IMX_SSI
> -	select IMX_HAVE_PLATFORM_IMX_UART
> -	select IMX_HAVE_PLATFORM_MXC_MMC
> -	select IMX_HAVE_PLATFORM_SPI_IMX
> -	select LEDS_GPIO_REGISTER
> -	help
> -	  This adds board specific devices that can be found on Eukrea's
> -	  MBIMX27 evaluation board.
> -
> -endchoice
> -
>  config MACH_MX27_3DS
>  	bool "MX27PDK platform"
>  	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 2783d27..2942ec3 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -61,8 +61,6 @@ obj-$(CONFIG_MACH_PCM038) += mach-pcm038.o
>  obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
>  obj-$(CONFIG_MACH_MX27_3DS) += mach-mx27_3ds.o
>  obj-$(CONFIG_MACH_IMX27_VISSTRIM_M10) += mach-imx27_visstrim_m10.o
> -obj-$(CONFIG_MACH_CPUIMX27) += mach-cpuimx27.o
> -obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
>  obj-$(CONFIG_MACH_PCA100) += mach-pca100.o
>  obj-$(CONFIG_MACH_MXT_TD60) += mach-mxt_td60.o
>  obj-$(CONFIG_MACH_IMX27_DT) += imx27-dt.o
> diff --git a/arch/arm/mach-imx/eukrea-baseboards.h b/arch/arm/mach-imx/eukrea-baseboards.h
> index a21d331..bb2c90d 100644
> --- a/arch/arm/mach-imx/eukrea-baseboards.h
> +++ b/arch/arm/mach-imx/eukrea-baseboards.h
> @@ -27,23 +27,15 @@
>   * This CPU module needs a baseboard to work. After basic initializing
>   * its own devices, it calls baseboard's init function.
>   * TODO: Add your own baseboard init function and call it from
> - * inside eukrea_cpuimx25_init() eukrea_cpuimx27_init()
> - * eukrea_cpuimx35_init() eukrea_cpuimx51_init()
> - * or eukrea_cpuimx51sd_init().
> + * inside eukrea_cpuimx25_init() or eukrea_cpuimx35_init()
>   *
>   * This example here is for the development board. Refer
>   * mach-mx25/eukrea_mbimxsd-baseboard.c for cpuimx25
> - * mach-imx/eukrea_mbimx27-baseboard.c for cpuimx27
>   * mach-mx3/eukrea_mbimxsd-baseboard.c for cpuimx35
> - * mach-mx5/eukrea_mbimx51-baseboard.c for cpuimx51
> - * mach-mx5/eukrea_mbimxsd-baseboard.c for cpuimx51sd
>   */
>  
>  extern void eukrea_mbimxsd25_baseboard_init(void);
> -extern void eukrea_mbimx27_baseboard_init(void);
>  extern void eukrea_mbimxsd35_baseboard_init(void);
> -extern void eukrea_mbimx51_baseboard_init(void);
> -extern void eukrea_mbimxsd51_baseboard_init(void);
>  
>  #endif
>  
> diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> deleted file mode 100644
> index b2f08bf..0000000
> --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> +++ /dev/null
> @@ -1,351 +0,0 @@
> -/*
> - * Copyright (C) 2009-2010 Eric Benard - eric at eukrea.com
> - *
> - * Based on pcm970-baseboard.c which is :
> - * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> - * MA 02110-1301, USA.
> - */
> -
> -#include <linux/gpio.h>
> -#include <linux/irq.h>
> -#include <linux/platform_device.h>
> -#include <linux/spi/spi.h>
> -#include <linux/spi/ads7846.h>
> -#include <linux/backlight.h>
> -#include <video/platform_lcd.h>
> -
> -#include <asm/mach/arch.h>
> -
> -#include "common.h"
> -#include "devices-imx27.h"
> -#include "hardware.h"
> -#include "iomux-mx27.h"
> -
> -static const int eukrea_mbimx27_pins[] __initconst = {
> -	/* UART2 */
> -	PE3_PF_UART2_CTS,
> -	PE4_PF_UART2_RTS,
> -	PE6_PF_UART2_TXD,
> -	PE7_PF_UART2_RXD,
> -	/* UART3 */
> -	PE8_PF_UART3_TXD,
> -	PE9_PF_UART3_RXD,
> -	PE10_PF_UART3_CTS,
> -	PE11_PF_UART3_RTS,
> -	/* UART4 */
> -#if !defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> -	PB26_AF_UART4_RTS,
> -	PB28_AF_UART4_TXD,
> -	PB29_AF_UART4_CTS,
> -	PB31_AF_UART4_RXD,
> -#endif
> -	/* SDHC1*/
> -	PE18_PF_SD1_D0,
> -	PE19_PF_SD1_D1,
> -	PE20_PF_SD1_D2,
> -	PE21_PF_SD1_D3,
> -	PE22_PF_SD1_CMD,
> -	PE23_PF_SD1_CLK,
> -	/* display */
> -	PA5_PF_LSCLK,
> -	PA6_PF_LD0,
> -	PA7_PF_LD1,
> -	PA8_PF_LD2,
> -	PA9_PF_LD3,
> -	PA10_PF_LD4,
> -	PA11_PF_LD5,
> -	PA12_PF_LD6,
> -	PA13_PF_LD7,
> -	PA14_PF_LD8,
> -	PA15_PF_LD9,
> -	PA16_PF_LD10,
> -	PA17_PF_LD11,
> -	PA18_PF_LD12,
> -	PA19_PF_LD13,
> -	PA20_PF_LD14,
> -	PA21_PF_LD15,
> -	PA22_PF_LD16,
> -	PA23_PF_LD17,
> -	PA28_PF_HSYNC,
> -	PA29_PF_VSYNC,
> -	PA30_PF_CONTRAST,
> -	PA31_PF_OE_ACD,
> -	/* SPI1 */
> -	PD29_PF_CSPI1_SCLK,
> -	PD30_PF_CSPI1_MISO,
> -	PD31_PF_CSPI1_MOSI,
> -	/* SSI4 */
> -#if defined(CONFIG_SND_SOC_EUKREA_TLV320) \
> -	|| defined(CONFIG_SND_SOC_EUKREA_TLV320_MODULE)
> -	PC16_PF_SSI4_FS,
> -	PC17_PF_SSI4_RXD | GPIO_PUEN,
> -	PC18_PF_SSI4_TXD | GPIO_PUEN,
> -	PC19_PF_SSI4_CLK,
> -#endif
> -};
> -
> -static const uint32_t eukrea_mbimx27_keymap[] = {
> -	KEY(0, 0, KEY_UP),
> -	KEY(0, 1, KEY_DOWN),
> -	KEY(1, 0, KEY_RIGHT),
> -	KEY(1, 1, KEY_LEFT),
> -};
> -
> -static const struct matrix_keymap_data
> -eukrea_mbimx27_keymap_data __initconst = {
> -	.keymap         = eukrea_mbimx27_keymap,
> -	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
> -};
> -
> -static const struct gpio_led eukrea_mbimx27_gpio_leds[] __initconst = {
> -	{
> -		.name			= "led1",
> -		.default_trigger	= "heartbeat",
> -		.active_low		= 1,
> -		.gpio			= GPIO_PORTF | 16,
> -	},
> -	{
> -		.name			= "led2",
> -		.default_trigger	= "none",
> -		.active_low		= 1,
> -		.gpio			= GPIO_PORTF | 19,
> -	},
> -};
> -
> -static const struct gpio_led_platform_data
> -		eukrea_mbimx27_gpio_led_info __initconst = {
> -	.leds		= eukrea_mbimx27_gpio_leds,
> -	.num_leds	= ARRAY_SIZE(eukrea_mbimx27_gpio_leds),
> -};
> -
> -static struct imx_fb_videomode eukrea_mbimx27_modes[] = {
> -	{
> -		.mode = {
> -			.name		= "CMO-QVGA",
> -			.refresh	= 60,
> -			.xres		= 320,
> -			.yres		= 240,
> -			.pixclock	= 156000,
> -			.hsync_len	= 30,
> -			.left_margin	= 38,
> -			.right_margin	= 20,
> -			.vsync_len	= 3,
> -			.upper_margin	= 15,
> -			.lower_margin	= 4,
> -		},
> -		.pcr		= 0xFAD08B80,
> -		.bpp		= 16,
> -	}, {
> -		.mode = {
> -			.name		= "DVI-VGA",
> -			.refresh	= 60,
> -			.xres		= 640,
> -			.yres		= 480,
> -			.pixclock	= 32000,
> -			.hsync_len	= 1,
> -			.left_margin	= 35,
> -			.right_margin	= 0,
> -			.vsync_len	= 1,
> -			.upper_margin	= 7,
> -			.lower_margin	= 0,
> -		},
> -		.pcr		= 0xFA208B80,
> -		.bpp		= 16,
> -	}, {
> -		.mode = {
> -			.name		= "DVI-SVGA",
> -			.refresh	= 60,
> -			.xres		= 800,
> -			.yres		= 600,
> -			.pixclock	= 25000,
> -			.hsync_len	= 1,
> -			.left_margin	= 35,
> -			.right_margin	= 0,
> -			.vsync_len	= 1,
> -			.upper_margin	= 7,
> -			.lower_margin	= 0,
> -		},
> -		.pcr		= 0xFA208B80,
> -		.bpp		= 16,
> -	},
> -};
> -
> -static const struct imx_fb_platform_data eukrea_mbimx27_fb_data __initconst = {
> -	.mode = eukrea_mbimx27_modes,
> -	.num_modes = ARRAY_SIZE(eukrea_mbimx27_modes),
> -
> -	.pwmr		= 0x00A903FF,
> -	.lscr1		= 0x00120300,
> -	.dmacr		= 0x00040060,
> -};
> -
> -static void eukrea_mbimx27_bl_set_intensity(int intensity)
> -{
> -	if (intensity)
> -		gpio_direction_output(GPIO_PORTE | 5, 1);
> -	else
> -		gpio_direction_output(GPIO_PORTE | 5, 0);
> -}
> -
> -static struct generic_bl_info eukrea_mbimx27_bl_info = {
> -	.name			= "eukrea_mbimx27-bl",
> -	.max_intensity		= 0xff,
> -	.default_intensity	= 0xff,
> -	.set_bl_intensity	= eukrea_mbimx27_bl_set_intensity,
> -};
> -
> -static struct platform_device eukrea_mbimx27_bl_dev = {
> -	.name			= "generic-bl",
> -	.id			= 1,
> -	.dev = {
> -		.platform_data	= &eukrea_mbimx27_bl_info,
> -	},
> -};
> -
> -static void eukrea_mbimx27_lcd_power_set(struct plat_lcd_data *pd,
> -				   unsigned int power)
> -{
> -	if (power)
> -		gpio_direction_output(GPIO_PORTA | 25, 1);
> -	else
> -		gpio_direction_output(GPIO_PORTA | 25, 0);
> -}
> -
> -static struct plat_lcd_data eukrea_mbimx27_lcd_power_data = {
> -	.set_power		= eukrea_mbimx27_lcd_power_set,
> -};
> -
> -static struct platform_device eukrea_mbimx27_lcd_powerdev = {
> -	.name			= "platform-lcd",
> -	.dev.platform_data	= &eukrea_mbimx27_lcd_power_data,
> -};
> -
> -static const struct imxuart_platform_data uart_pdata __initconst = {
> -	.flags = IMXUART_HAVE_RTSCTS,
> -};
> -
> -#define ADS7846_PENDOWN (GPIO_PORTD | 25)
> -
> -static void __maybe_unused ads7846_dev_init(void)
> -{
> -	if (gpio_request(ADS7846_PENDOWN, "ADS7846 pendown") < 0) {
> -		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
> -		return;
> -	}
> -	gpio_direction_input(ADS7846_PENDOWN);
> -}
> -
> -static int ads7846_get_pendown_state(void)
> -{
> -	return !gpio_get_value(ADS7846_PENDOWN);
> -}
> -
> -static struct ads7846_platform_data ads7846_config __initdata = {
> -	.get_pendown_state	= ads7846_get_pendown_state,
> -	.keep_vref_on		= 1,
> -};
> -
> -static struct spi_board_info __maybe_unused
> -		eukrea_mbimx27_spi_board_info[] __initdata = {
> -	[0] = {
> -		.modalias	= "ads7846",
> -		.bus_num	= 0,
> -		.chip_select	= 0,
> -		.max_speed_hz	= 1500000,
> -		/* irq number is run-time assigned */
> -		.platform_data	= &ads7846_config,
> -		.mode           = SPI_MODE_2,
> -	},
> -};
> -
> -static int eukrea_mbimx27_spi_cs[] = {GPIO_PORTD | 28};
> -
> -static const struct spi_imx_master eukrea_mbimx27_spi0_data __initconst = {
> -	.chipselect	= eukrea_mbimx27_spi_cs,
> -	.num_chipselect = ARRAY_SIZE(eukrea_mbimx27_spi_cs),
> -};
> -
> -static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
> -	{
> -		I2C_BOARD_INFO("tlv320aic23", 0x1a),
> -	},
> -};
> -
> -static const struct imxmmc_platform_data sdhc_pdata __initconst = {
> -	.dat3_card_detect = 1,
> -};
> -
> -static const
> -struct imx_ssi_platform_data eukrea_mbimx27_ssi_pdata __initconst = {
> -	.flags = IMX_SSI_DMA | IMX_SSI_USE_I2S_SLAVE,
> -};
> -
> -/*
> - * system init for baseboard usage. Will be called by cpuimx27 init.
> - *
> - * Add platform devices present on this baseboard and init
> - * them from CPU side as far as required to use them later on
> - */
> -void __init eukrea_mbimx27_baseboard_init(void)
> -{
> -	mxc_gpio_setup_multiple_pins(eukrea_mbimx27_pins,
> -		ARRAY_SIZE(eukrea_mbimx27_pins), "MBIMX27");
> -
> -	imx27_add_imx_uart1(&uart_pdata);
> -	imx27_add_imx_uart2(&uart_pdata);
> -#if !defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> -	imx27_add_imx_uart3(&uart_pdata);
> -#endif
> -
> -	imx27_add_imx_fb(&eukrea_mbimx27_fb_data);
> -	imx27_add_mxc_mmc(0, &sdhc_pdata);
> -
> -	i2c_register_board_info(0, eukrea_mbimx27_i2c_devices,
> -				ARRAY_SIZE(eukrea_mbimx27_i2c_devices));
> -
> -	imx27_add_imx_ssi(0, &eukrea_mbimx27_ssi_pdata);
> -
> -#if defined(CONFIG_TOUCHSCREEN_ADS7846) \
> -	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> -	/* ADS7846 Touchscreen controller init */
> -	mxc_gpio_mode(GPIO_PORTD | 25 | GPIO_GPIO | GPIO_IN);
> -	ads7846_dev_init();
> -#endif
> -
> -	/* SPI_CS0 init */
> -	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
> -	imx27_add_spi_imx0(&eukrea_mbimx27_spi0_data);
> -	eukrea_mbimx27_spi_board_info[0].irq = gpio_to_irq(IMX_GPIO_NR(4, 25));
> -	spi_register_board_info(eukrea_mbimx27_spi_board_info,
> -			ARRAY_SIZE(eukrea_mbimx27_spi_board_info));
> -
> -	/* Leds configuration */
> -	mxc_gpio_mode(GPIO_PORTF | 16 | GPIO_GPIO | GPIO_OUT);
> -	mxc_gpio_mode(GPIO_PORTF | 19 | GPIO_GPIO | GPIO_OUT);
> -	/* Backlight */
> -	mxc_gpio_mode(GPIO_PORTE | 5 | GPIO_GPIO | GPIO_OUT);
> -	gpio_request(GPIO_PORTE | 5, "backlight");
> -	platform_device_register(&eukrea_mbimx27_bl_dev);
> -	/* LCD Reset */
> -	mxc_gpio_mode(GPIO_PORTA | 25 | GPIO_GPIO | GPIO_OUT);
> -	gpio_request(GPIO_PORTA | 25, "lcd_enable");
> -	platform_device_register(&eukrea_mbimx27_lcd_powerdev);
> -
> -	imx27_add_imx_keypad(&eukrea_mbimx27_keymap_data);
> -
> -	gpio_led_register_device(-1, &eukrea_mbimx27_gpio_led_info);
> -	imx_add_platform_device("eukrea_tlv320", 0, NULL, 0, NULL, 0);
> -}
> diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
> deleted file mode 100644
> index e6d4b99..0000000
> --- a/arch/arm/mach-imx/mach-cpuimx27.c
> +++ /dev/null
> @@ -1,321 +0,0 @@
> -/*
> - * Copyright (C) 2009 Eric Benard - eric at eukrea.com
> - *
> - * Based on pcm038.c which is :
> - * Copyright 2007 Robert Schwebel <r.schwebel@pengutronix.de>, Pengutronix
> - * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> - * MA 02110-1301, USA.
> - */
> -
> -#include <linux/i2c.h>
> -#include <linux/io.h>
> -#include <linux/mtd/plat-ram.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/platform_device.h>
> -#include <linux/serial_8250.h>
> -#include <linux/usb/otg.h>
> -#include <linux/usb/ulpi.h>
> -
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/time.h>
> -#include <asm/mach/map.h>
> -
> -#include "common.h"
> -#include "devices-imx27.h"
> -#include "ehci.h"
> -#include "eukrea-baseboards.h"
> -#include "hardware.h"
> -#include "iomux-mx27.h"
> -#include "ulpi.h"
> -
> -static const int eukrea_cpuimx27_pins[] __initconst = {
> -	/* UART1 */
> -	PE12_PF_UART1_TXD,
> -	PE13_PF_UART1_RXD,
> -	PE14_PF_UART1_CTS,
> -	PE15_PF_UART1_RTS,
> -	/* UART4 */
> -#if defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> -	PB26_AF_UART4_RTS,
> -	PB28_AF_UART4_TXD,
> -	PB29_AF_UART4_CTS,
> -	PB31_AF_UART4_RXD,
> -#endif
> -	/* FEC */
> -	PD0_AIN_FEC_TXD0,
> -	PD1_AIN_FEC_TXD1,
> -	PD2_AIN_FEC_TXD2,
> -	PD3_AIN_FEC_TXD3,
> -	PD4_AOUT_FEC_RX_ER,
> -	PD5_AOUT_FEC_RXD1,
> -	PD6_AOUT_FEC_RXD2,
> -	PD7_AOUT_FEC_RXD3,
> -	PD8_AF_FEC_MDIO,
> -	PD9_AIN_FEC_MDC,
> -	PD10_AOUT_FEC_CRS,
> -	PD11_AOUT_FEC_TX_CLK,
> -	PD12_AOUT_FEC_RXD0,
> -	PD13_AOUT_FEC_RX_DV,
> -	PD14_AOUT_FEC_RX_CLK,
> -	PD15_AOUT_FEC_COL,
> -	PD16_AIN_FEC_TX_ER,
> -	PF23_AIN_FEC_TX_EN,
> -	/* I2C1 */
> -	PD17_PF_I2C_DATA,
> -	PD18_PF_I2C_CLK,
> -	/* SDHC2 */
> -#if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
> -	PB4_PF_SD2_D0,
> -	PB5_PF_SD2_D1,
> -	PB6_PF_SD2_D2,
> -	PB7_PF_SD2_D3,
> -	PB8_PF_SD2_CMD,
> -	PB9_PF_SD2_CLK,
> -#endif
> -#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
> -	/* Quad UART's IRQ */
> -	GPIO_PORTB | 22 | GPIO_GPIO | GPIO_IN,
> -	GPIO_PORTB | 23 | GPIO_GPIO | GPIO_IN,
> -	GPIO_PORTB | 27 | GPIO_GPIO | GPIO_IN,
> -	GPIO_PORTB | 30 | GPIO_GPIO | GPIO_IN,
> -#endif
> -	/* OTG */
> -	PC7_PF_USBOTG_DATA5,
> -	PC8_PF_USBOTG_DATA6,
> -	PC9_PF_USBOTG_DATA0,
> -	PC10_PF_USBOTG_DATA2,
> -	PC11_PF_USBOTG_DATA1,
> -	PC12_PF_USBOTG_DATA4,
> -	PC13_PF_USBOTG_DATA3,
> -	PE0_PF_USBOTG_NXT,
> -	PE1_PF_USBOTG_STP,
> -	PE2_PF_USBOTG_DIR,
> -	PE24_PF_USBOTG_CLK,
> -	PE25_PF_USBOTG_DATA7,
> -	/* USBH2 */
> -	PA0_PF_USBH2_CLK,
> -	PA1_PF_USBH2_DIR,
> -	PA2_PF_USBH2_DATA7,
> -	PA3_PF_USBH2_NXT,
> -	PA4_PF_USBH2_STP,
> -	PD19_AF_USBH2_DATA4,
> -	PD20_AF_USBH2_DATA3,
> -	PD21_AF_USBH2_DATA6,
> -	PD22_AF_USBH2_DATA0,
> -	PD23_AF_USBH2_DATA2,
> -	PD24_AF_USBH2_DATA1,
> -	PD26_AF_USBH2_DATA5,
> -};
> -
> -static struct physmap_flash_data eukrea_cpuimx27_flash_data = {
> -	.width = 2,
> -};
> -
> -static struct resource eukrea_cpuimx27_flash_resource = {
> -	.start = 0xc0000000,
> -	.end   = 0xc3ffffff,
> -	.flags = IORESOURCE_MEM,
> -};
> -
> -static struct platform_device eukrea_cpuimx27_nor_mtd_device = {
> -	.name = "physmap-flash",
> -	.id = 0,
> -	.dev = {
> -		.platform_data = &eukrea_cpuimx27_flash_data,
> -	},
> -	.num_resources = 1,
> -	.resource = &eukrea_cpuimx27_flash_resource,
> -};
> -
> -static const struct imxuart_platform_data uart_pdata __initconst = {
> -	.flags = IMXUART_HAVE_RTSCTS,
> -};
> -
> -static const struct mxc_nand_platform_data
> -cpuimx27_nand_board_info __initconst = {
> -	.width = 1,
> -	.hw_ecc = 1,
> -};
> -
> -static struct platform_device *platform_devices[] __initdata = {
> -	&eukrea_cpuimx27_nor_mtd_device,
> -};
> -
> -static const struct imxi2c_platform_data cpuimx27_i2c1_data __initconst = {
> -	.bitrate = 100000,
> -};
> -
> -static struct i2c_board_info eukrea_cpuimx27_i2c_devices[] = {
> -	{
> -		I2C_BOARD_INFO("pcf8563", 0x51),
> -	},
> -};
> -
> -#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
> -static struct plat_serial8250_port serial_platform_data[] = {
> -	{
> -		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x200000),
> -		/* irq number is run-time assigned */
> -		.uartclk = 14745600,
> -		.regshift = 1,
> -		.iotype = UPIO_MEM,
> -		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
> -	}, {
> -		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x400000),
> -		/* irq number is run-time assigned */
> -		.uartclk = 14745600,
> -		.regshift = 1,
> -		.iotype = UPIO_MEM,
> -		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
> -	}, {
> -		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x800000),
> -		/* irq number is run-time assigned */
> -		.uartclk = 14745600,
> -		.regshift = 1,
> -		.iotype = UPIO_MEM,
> -		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
> -	}, {
> -		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x1000000),
> -		/* irq number is run-time assigned */
> -		.uartclk = 14745600,
> -		.regshift = 1,
> -		.iotype = UPIO_MEM,
> -		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
> -	}, {
> -	}
> -};
> -
> -static struct platform_device serial_device = {
> -	.name = "serial8250",
> -	.id = 0,
> -	.dev = {
> -		.platform_data = serial_platform_data,
> -	},
> -};
> -#endif
> -
> -static int eukrea_cpuimx27_otg_init(struct platform_device *pdev)
> -{
> -	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
> -}
> -
> -static struct mxc_usbh_platform_data otg_pdata __initdata = {
> -	.init	= eukrea_cpuimx27_otg_init,
> -	.portsc	= MXC_EHCI_MODE_ULPI,
> -};
> -
> -static int eukrea_cpuimx27_usbh2_init(struct platform_device *pdev)
> -{
> -	return mx27_initialize_usb_hw(pdev->id, MXC_EHCI_INTERFACE_DIFF_UNI);
> -}
> -
> -static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
> -	.init	= eukrea_cpuimx27_usbh2_init,
> -	.portsc	= MXC_EHCI_MODE_ULPI,
> -};
> -
> -static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
> -	.operating_mode = FSL_USB2_DR_DEVICE,
> -	.phy_mode       = FSL_USB2_PHY_ULPI,
> -};
> -
> -static bool otg_mode_host __initdata;
> -
> -static int __init eukrea_cpuimx27_otg_mode(char *options)
> -{
> -	if (!strcmp(options, "host"))
> -		otg_mode_host = true;
> -	else if (!strcmp(options, "device"))
> -		otg_mode_host = false;
> -	else
> -		pr_info("otg_mode neither \"host\" nor \"device\". "
> -			"Defaulting to device\n");
> -	return 1;
> -}
> -__setup("otg_mode=", eukrea_cpuimx27_otg_mode);
> -
> -static void __init eukrea_cpuimx27_init(void)
> -{
> -	imx27_soc_init();
> -
> -	mxc_gpio_setup_multiple_pins(eukrea_cpuimx27_pins,
> -		ARRAY_SIZE(eukrea_cpuimx27_pins), "CPUIMX27");
> -
> -	imx27_add_imx_uart0(&uart_pdata);
> -
> -	imx27_add_mxc_nand(&cpuimx27_nand_board_info);
> -
> -	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
> -				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
> -
> -	imx27_add_imx_i2c(0, &cpuimx27_i2c1_data);
> -
> -	imx27_add_fec(NULL);
> -	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
> -	imx27_add_imx2_wdt();
> -	imx27_add_mxc_w1();
> -
> -#if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
> -	/* SDHC2 can be used for Wifi */
> -	imx27_add_mxc_mmc(1, NULL);
> -#endif
> -#if defined(CONFIG_MACH_EUKREA_CPUIMX27_USEUART4)
> -	/* in which case UART4 is also used for Bluetooth */
> -	imx27_add_imx_uart3(&uart_pdata);
> -#endif
> -
> -#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
> -	serial_platform_data[0].irq = IMX_GPIO_NR(2, 23);
> -	serial_platform_data[1].irq = IMX_GPIO_NR(2, 22);
> -	serial_platform_data[2].irq = IMX_GPIO_NR(2, 27);
> -	serial_platform_data[3].irq = IMX_GPIO_NR(2, 30);
> -	platform_device_register(&serial_device);
> -#endif
> -
> -	if (otg_mode_host) {
> -		otg_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
> -				ULPI_OTG_DRVVBUS_EXT);
> -		if (otg_pdata.otg)
> -			imx27_add_mxc_ehci_otg(&otg_pdata);
> -	} else {
> -		imx27_add_fsl_usb2_udc(&otg_device_pdata);
> -	}
> -
> -	usbh2_pdata.otg = imx_otg_ulpi_create(ULPI_OTG_DRVVBUS |
> -			ULPI_OTG_DRVVBUS_EXT);
> -	if (usbh2_pdata.otg)
> -		imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
> -
> -#ifdef CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD
> -	eukrea_mbimx27_baseboard_init();
> -#endif
> -}
> -
> -static void __init eukrea_cpuimx27_timer_init(void)
> -{
> -	mx27_clocks_init(26000000);
> -}
> -
> -MACHINE_START(EUKREA_CPUIMX27, "EUKREA CPUIMX27")
> -	.atag_offset = 0x100,
> -	.map_io = mx27_map_io,
> -	.init_early = imx27_init_early,
> -	.init_irq = mx27_init_irq,
> -	.init_time	= eukrea_cpuimx27_timer_init,
> -	.init_machine = eukrea_cpuimx27_init,
> -	.restart	= mxc_restart,
> -MACHINE_END
