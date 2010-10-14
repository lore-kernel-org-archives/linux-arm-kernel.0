From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 14 Oct 2010 16:47:47 +0200
Subject: [PATCH v4] ARM: AT91: add board support for Pcontrol_G20
In-Reply-To: <1286979531.7165.9.camel@aspire.localdomain>
References: <1286466086.4306.41.camel@aspire.localdomain>	<20101008123407.GB30252@game.jcrosoft.org>	<1286550644.21584.34.camel@aspire.localdomain>	<1286787761.7800.11.camel@aspire.localdomain>	<1286792568.7800.19.camel@aspire.localdomain>	<20101013131515.GC11087@game.jcrosoft.org>
	<1286979531.7165.9.camel@aspire.localdomain>
Message-ID: <4CB71813.6060601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/10/2010 16:18, Peter Gsellmann :
> Board is a carrier board for Stamp9G20, with additional peripherals
> for a building automation system
> 
> Signed-off-by: Peter Gsellmann <pgsellmann@portner-elektronik.at>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I will add it to my next pull request to Russell.

Thanks.

> ---
>  arch/arm/configs/pcontrol_g20_defconfig |  175 +++++++++++++++++
>  arch/arm/mach-at91/Kconfig              |    6 +
>  arch/arm/mach-at91/Makefile             |    1 +
>  arch/arm/mach-at91/board-pcontrol-g20.c |  324 +++++++++++++++++++++++++++++++
>  4 files changed, 506 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/pcontrol_g20_defconfig
>  create mode 100644 arch/arm/mach-at91/board-pcontrol-g20.c
> 
> diff --git a/arch/arm/configs/pcontrol_g20_defconfig b/arch/arm/configs/pcontrol_g20_defconfig
> new file mode 100644
> index 0000000..b42ee62
> --- /dev/null
> +++ b/arch/arm/configs/pcontrol_g20_defconfig
> @@ -0,0 +1,175 @@
> +CONFIG_EXPERIMENTAL=y
> +CONFIG_CROSS_COMPILE="/opt/arm-2010q1/bin/arm-none-linux-gnueabi-"
> +# CONFIG_LOCALVERSION_AUTO is not set
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_TREE_PREEMPT_RCU=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_LOG_BUF_SHIFT=14
> +CONFIG_NAMESPACES=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_EMBEDDED=y
> +# CONFIG_SYSCTL_SYSCALL is not set
> +# CONFIG_KALLSYMS is not set
> +# CONFIG_VM_EVENT_COUNTERS is not set
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +# CONFIG_LBDAF is not set
> +# CONFIG_BLK_DEV_BSG is not set
> +CONFIG_DEFAULT_DEADLINE=y
> +CONFIG_ARCH_AT91=y
> +CONFIG_ARCH_AT91SAM9G20=y
> +CONFIG_MACH_PCONTROL_G20=y
> +CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_PREEMPT=y
> +CONFIG_AEABI=y
> +# CONFIG_OABI_COMPAT is not set
> +CONFIG_ZBOOT_ROM_TEXT=0x0
> +CONFIG_ZBOOT_ROM_BSS=0x0
> +CONFIG_CMDLINE="console=ttyS0,115200 mem=128M mtdparts=atmel_nand:128k(bootstrap)ro,256k(uboot)ro,128k(env1)ro,128k(env2)ro,2M(linux),-(root) root=/dev/mmcblk0p1 rootwait rw"
> +CONFIG_VFP=y
> +CONFIG_BINFMT_MISC=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_INET_LRO is not set
> +# CONFIG_IPV6 is not set
> +CONFIG_VLAN_8021Q=y
> +# CONFIG_WIRELESS is not set
> +CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> +# CONFIG_FW_LOADER is not set
> +CONFIG_MTD=y
> +CONFIG_MTD_PARTITIONS=y
> +CONFIG_MTD_CMDLINE_PARTS=y
> +CONFIG_MTD_CHAR=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_COMPLEX_MAPPINGS=y
> +CONFIG_MTD_PHRAM=m
> +CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_ATMEL=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_SIZE=8192
> +CONFIG_ATMEL_TCLIB=y
> +CONFIG_EEPROM_AT24=m
> +CONFIG_SCSI=m
> +# CONFIG_SCSI_PROC_FS is not set
> +CONFIG_BLK_DEV_SD=m
> +CONFIG_SCSI_MULTI_LUN=y
> +# CONFIG_SCSI_LOWLEVEL is not set
> +CONFIG_NETDEVICES=y
> +CONFIG_MACVLAN=m
> +CONFIG_TUN=m
> +CONFIG_SMSC_PHY=m
> +CONFIG_BROADCOM_PHY=m
> +CONFIG_NET_ETHERNET=y
> +CONFIG_MII=y
> +CONFIG_MACB=y
> +CONFIG_SMSC911X=m
> +# CONFIG_NETDEV_1000 is not set
> +# CONFIG_NETDEV_10000 is not set
> +# CONFIG_WLAN is not set
> +CONFIG_PPP=m
> +CONFIG_PPP_ASYNC=m
> +CONFIG_PPP_DEFLATE=m
> +CONFIG_PPP_MPPE=m
> +CONFIG_INPUT_POLLDEV=y
> +CONFIG_INPUT_SPARSEKMAP=y
> +# CONFIG_INPUT_MOUSEDEV is not set
> +CONFIG_INPUT_EVDEV=m
> +CONFIG_INPUT_EVBUG=m
> +# CONFIG_KEYBOARD_ATKBD is not set
> +CONFIG_KEYBOARD_GPIO=m
> +CONFIG_KEYBOARD_MATRIX=m
> +# CONFIG_INPUT_MOUSE is not set
> +CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_INPUT_MISC=y
> +CONFIG_INPUT_UINPUT=m
> +CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
> +# CONFIG_SERIO is not set
> +# CONFIG_DEVKMEM is not set
> +CONFIG_SERIAL_ATMEL=y
> +CONFIG_SERIAL_ATMEL_CONSOLE=y
> +CONFIG_SERIAL_MAX3100=m
> +# CONFIG_LEGACY_PTYS is not set
> +# CONFIG_HW_RANDOM is not set
> +CONFIG_R3964=m
> +CONFIG_I2C=m
> +CONFIG_I2C_CHARDEV=m
> +# CONFIG_I2C_HELPER_AUTO is not set
> +CONFIG_I2C_GPIO=m
> +CONFIG_SPI=y
> +CONFIG_SPI_ATMEL=m
> +CONFIG_SPI_SPIDEV=m
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_W1=m
> +CONFIG_W1_MASTER_GPIO=m
> +CONFIG_W1_SLAVE_DS2431=m
> +# CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
> +CONFIG_AT91SAM9X_WATCHDOG=y
> +# CONFIG_MFD_SUPPORT is not set
> +# CONFIG_HID_SUPPORT is not set
> +CONFIG_USB=y
> +# CONFIG_USB_DEVICE_CLASS is not set
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_STORAGE=m
> +CONFIG_USB_LIBUSUAL=y
> +CONFIG_USB_SERIAL=m
> +CONFIG_USB_SERIAL_GENERIC=y
> +CONFIG_USB_SERIAL_FTDI_SIO=m
> +CONFIG_USB_SERIAL_PL2303=m
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_ZERO=m
> +CONFIG_USB_ETH=m
> +CONFIG_USB_FILE_STORAGE=m
> +CONFIG_USB_G_SERIAL=m
> +CONFIG_USB_G_HID=m
> +CONFIG_MMC=y
> +CONFIG_MMC_UNSAFE_RESUME=y
> +CONFIG_MMC_ATMELMCI=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_AT91SAM9=y
> +CONFIG_AUXDISPLAY=y
> +CONFIG_UIO=y
> +CONFIG_UIO_PDRV=y
> +CONFIG_STAGING=y
> +# CONFIG_STAGING_EXCLUDE_BUILD is not set
> +CONFIG_IIO=y
> +CONFIG_EXT2_FS=y
> +CONFIG_EXT3_FS=y
> +# CONFIG_EXT3_FS_XATTR is not set
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_JFFS2_FS=y
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V3=y
> +CONFIG_NFS_V4=y
> +CONFIG_PARTITION_ADVANCED=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_CODEPAGE_850=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_NLS_ISO8859_15=y
> +CONFIG_NLS_UTF8=y
> +# CONFIG_RCU_CPU_STALL_DETECTOR is not set
> +CONFIG_CRYPTO=y
> +CONFIG_CRYPTO_ANSI_CPRNG=y
> +# CONFIG_CRYPTO_HW is not set
> +CONFIG_CRC_CCITT=y
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 939bccd..e66405e 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -364,6 +364,12 @@ config MACH_STAMP9G20
>  	  evaluation board.
>  	  <http://www.taskit.de/en/>
>  
> +config MACH_PCONTROL_G20
> +	bool "PControl G20 CPU module"
> +	help
> +	  Select this if you are using taskit's Stamp9G20 CPU module on this
> +	  carrier board, beeing the decentralized unit of a building automation
> +	  system; featuring nvram, eth-switch, iso-rs485, display, io
>  endif
>  
>  if (ARCH_AT91SAM9260 || ARCH_AT91SAM9G20)
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index ca2ac00..7fabc1b 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_AT91SAM9G20EK_2MMC) += board-sam9g20ek-2slot-mmc.o
>  obj-$(CONFIG_MACH_CPU9G20)	+= board-cpu9krea.o
>  obj-$(CONFIG_MACH_STAMP9G20)	+= board-stamp9g20.o
>  obj-$(CONFIG_MACH_PORTUXG20)	+= board-stamp9g20.o
> +obj-$(CONFIG_MACH_PCONTROL_G20)	+= board-pcontrol-g20.o
>  
>  # AT91SAM9260/AT91SAM9G20 board-specific support
>  obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
> diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
> new file mode 100644
> index 0000000..7652d9c
> --- /dev/null
> +++ b/arch/arm/mach-at91/board-pcontrol-g20.c
> @@ -0,0 +1,324 @@
> +/*
> + *  Copyright (C) 2010 Christian Glindkamp <christian.glindkamp@taskit.de>
> + *                     taskit GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +/*
> + * copied and adjusted from board-stamp9g20.c
> + * by Peter Gsellmann <pgsellmann@portner-elektronik.at>
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/w1-gpio.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/board.h>
> +#include <mach/at91sam9_smc.h>
> +
> +#include "sam9_smc.h"
> +#include "generic.h"
> +
> +
> +static void __init pcontrol_g20_map_io(void)
> +{
> +	/* Initialize processor: 18.432 MHz crystal */
> +	at91sam9260_initialize(18432000);
> +
> +	/* DGBU on ttyS0. (Rx, Tx) only TTL -> JTAG connector X7 17,19 ) */
> +	at91_register_uart(0, 0, 0);
> +
> +	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS) piggyback  A2 */
> +	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS
> +						| ATMEL_UART_RTS);
> +
> +	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) isolated RS485  X5 */
> +	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS
> +						| ATMEL_UART_RTS);
> +
> +	/* USART2 on ttyS3. (Rx, Tx)  9bit-Bus  Multidrop-mode  X4 */
> +	at91_register_uart(AT91SAM9260_ID_US4, 3, 0);
> +
> +	/* set serial console to ttyS0 (ie, DBGU) */
> +	at91_set_serial_console(0);
> +}
> +
> +
> +static void __init init_irq(void)
> +{
> +	at91sam9260_init_interrupts(NULL);
> +}
> +
> +
> +/*
> + * NAND flash 512MiB 1,8V 8-bit, sector size 128 KiB
> + */
> +static struct atmel_nand_data __initdata nand_data = {
> +	.ale		= 21,
> +	.cle		= 22,
> +	.rdy_pin	= AT91_PIN_PC13,
> +	.enable_pin	= AT91_PIN_PC14,
> +};
> +
> +/*
> + * Bus timings; unit = 7.57ns
> + */
> +static struct sam9_smc_config __initdata nand_smc_config = {
> +	.ncs_read_setup		= 0,
> +	.nrd_setup		= 2,
> +	.ncs_write_setup	= 0,
> +	.nwe_setup		= 2,
> +
> +	.ncs_read_pulse		= 4,
> +	.nrd_pulse		= 4,
> +	.ncs_write_pulse	= 4,
> +	.nwe_pulse		= 4,
> +
> +	.read_cycle		= 7,
> +	.write_cycle		= 7,
> +
> +	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE
> +			| AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
> +	.tdf_cycles		= 3,
> +};
> +
> +static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
> +	.ncs_read_setup		= 16,
> +	.nrd_setup		= 18,
> +	.ncs_write_setup	= 16,
> +	.nwe_setup		= 18,
> +
> +	.ncs_read_pulse		= 63,
> +	.nrd_pulse		= 55,
> +	.ncs_write_pulse	= 63,
> +	.nwe_pulse		= 55,
> +
> +	.read_cycle		= 127,
> +	.write_cycle		= 127,
> +
> +	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE
> +			| AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_BAT_SELECT
> +			| AT91_SMC_DBW_8 | AT91_SMC_PS_4
> +			| AT91_SMC_TDFMODE,
> +	.tdf_cycles		= 3,
> +}, {
> +	.ncs_read_setup		= 0,
> +	.nrd_setup		= 0,
> +	.ncs_write_setup	= 0,
> +	.nwe_setup		= 1,
> +
> +	.ncs_read_pulse		= 8,
> +	.nrd_pulse		= 8,
> +	.ncs_write_pulse	= 5,
> +	.nwe_pulse		= 4,
> +
> +	.read_cycle		= 8,
> +	.write_cycle		= 7,
> +
> +	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE
> +			| AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_BAT_SELECT
> +			| AT91_SMC_DBW_16 | AT91_SMC_PS_8
> +			| AT91_SMC_TDFMODE,
> +	.tdf_cycles		= 1,
> +} };
> +
> +static void __init add_device_nand(void)
> +{
> +	/* configure chip-select 3 (NAND) */
> +	sam9_smc_configure(3, &nand_smc_config);
> +	at91_add_device_nand(&nand_data);
> +}
> +
> +
> +static void __init add_device_pcontrol(void)
> +{
> +	/* configure chip-select 4 (IO compatible to 8051  X4 ) */
> +	sam9_smc_configure(4, &pcontrol_smc_config[0]);
> +	/* configure chip-select 7 (FerroRAM 256KiBx16bit MR2A16A  D4 ) */
> +	sam9_smc_configure(7, &pcontrol_smc_config[1]);
> +}
> +
> +
> +/*
> + * MCI (SD/MMC)
> + * det_pin, wp_pin and vcc_pin are not connected
> + */
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata mmc_data = {
> +	.slot[0] = {
> +		.bus_width	= 4,
> +	},
> +};
> +#else
> +static struct at91_mmc_data __initdata mmc_data = {
> +	.wire4		= 1,
> +};
> +#endif
> +
> +
> +/*
> + * USB Host port
> + */
> +static struct at91_usbh_data __initdata usbh_data = {
> +	.ports		= 2,
> +};
> +
> +
> +/*
> + * USB Device port
> + */
> +static struct at91_udc_data __initdata pcontrol_g20_udc_data = {
> +	.vbus_pin	= AT91_PIN_PA22,	/* Detect +5V bus voltage */
> +	.pullup_pin	= AT91_PIN_PA4,		/* K-state, active low */
> +};
> +
> +
> +/*
> + * MACB Ethernet device
> + */
> +static struct at91_eth_data __initdata macb_data = {
> +	.phy_irq_pin	= AT91_PIN_PA28,
> +	.is_rmii	= 1,
> +};
> +
> +
> +/*
> + * I2C devices: eeprom and phy/switch
> + */
> +static struct i2c_board_info __initdata pcontrol_g20_i2c_devices[] = {
> +{		/* D7  address width=2, 8KiB */
> +	I2C_BOARD_INFO("24c64", 0x50)
> +}, {		/* D8  address width=1, 1 byte has 32 bits! */
> +	I2C_BOARD_INFO("lan9303", 0x0a)
> +}, };
> +
> +
> +/*
> + * LEDs
> + */
> +static struct gpio_led pcontrol_g20_leds[] = {
> +	{
> +		.name			= "LED1",	/* red  H5 */
> +		.gpio			= AT91_PIN_PB18,
> +		.active_low		= 1,
> +		.default_trigger	= "none",	/* supervisor */
> +	}, {
> +		.name			= "LED2",	/* yellow  H7 */
> +		.gpio			= AT91_PIN_PB19,
> +		.active_low		= 1,
> +		.default_trigger	= "mmc0",	/* SD-card activity */
> +	}, {
> +		.name			= "LED3",	/* green  H2 */
> +		.gpio			= AT91_PIN_PB20,
> +		.active_low		= 1,
> +		.default_trigger	= "heartbeat",	/* blinky */
> +	}, {
> +		.name			= "LED4",	/* red  H3 */
> +		.gpio			= AT91_PIN_PC6,
> +		.active_low		= 1,
> +		.default_trigger	= "none",	/* connection lost */
> +	}, {
> +		.name			= "LED5",	/* yellow  H6 */
> +		.gpio			= AT91_PIN_PC7,
> +		.active_low		= 1,
> +		.default_trigger	= "none",	/* unsent data */
> +	}, {
> +		.name			= "LED6",	/* green  H1 */
> +		.gpio			= AT91_PIN_PC9,
> +		.active_low		= 1,
> +		.default_trigger	= "none",	/* snafu */
> +	}
> +};
> +
> +
> +/*
> + * SPI devices
> + */
> +static struct spi_board_info pcontrol_g20_spi_devices[] = {
> +	{
> +		.modalias	= "spidev",	/* HMI port  X4 */
> +		.chip_select	= 1,
> +		.max_speed_hz	= 50 * 1000 * 1000,
> +		.bus_num	= 0,
> +	}, {
> +		.modalias	= "spidev",	/* piggyback  A2 */
> +		.chip_select	= 0,
> +		.max_speed_hz	= 50 * 1000 * 1000,
> +		.bus_num	= 1,
> +	},
> +};
> +
> +
> +/*
> + * Dallas 1-Wire  DS2431
> + */
> +static struct w1_gpio_platform_data w1_gpio_pdata = {
> +	.pin		= AT91_PIN_PA29,
> +	.is_open_drain	= 1,
> +};
> +
> +static struct platform_device w1_device = {
> +	.name			= "w1-gpio",
> +	.id			= -1,
> +	.dev.platform_data	= &w1_gpio_pdata,
> +};
> +
> +static void add_wire1(void)
> +{
> +	at91_set_GPIO_periph(w1_gpio_pdata.pin, 1);
> +	at91_set_multi_drive(w1_gpio_pdata.pin, 1);
> +	platform_device_register(&w1_device);
> +}
> +
> +
> +static void __init pcontrol_g20_board_init(void)
> +{
> +	at91_add_device_serial();
> +	add_device_nand();
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +	at91_add_device_mci(0, &mmc_data);
> +#else
> +	at91_add_device_mmc(0, &mmc_data);
> +#endif
> +	at91_add_device_usbh(&usbh_data);
> +	at91_add_device_eth(&macb_data);
> +	at91_add_device_i2c(pcontrol_g20_i2c_devices,
> +		ARRAY_SIZE(pcontrol_g20_i2c_devices));
> +	add_wire1();
> +	add_device_pcontrol();
> +	at91_add_device_spi(pcontrol_g20_spi_devices,
> +		ARRAY_SIZE(pcontrol_g20_spi_devices));
> +	at91_add_device_udc(&pcontrol_g20_udc_data);
> +	at91_gpio_leds(pcontrol_g20_leds,
> +		ARRAY_SIZE(pcontrol_g20_leds));
> +	/* piggyback  A2 */
> +	at91_set_gpio_output(AT91_PIN_PB31, 1);
> +}
> +
> +
> +MACHINE_START(PCONTROL_G20, "PControl G20")
> +	/* Maintainer: pgsellmann at portner-elektronik.at */
> +	.phys_io	= AT91_BASE_SYS,
> +	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
> +	.boot_params	= AT91_SDRAM_BASE + 0x100,
> +	.timer		= &at91sam926x_timer,
> +	.map_io		= pcontrol_g20_map_io,
> +	.init_irq	= init_irq,
> +	.init_machine	= pcontrol_g20_board_init,
> +MACHINE_END


-- 
Nicolas Ferre
