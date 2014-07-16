From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 16 Jul 2014 12:04:32 +0200
Subject: [PATCH 11/19] ARM: S5PV210: Remove support for board files
In-Reply-To: <1404496099-26708-12-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-12-git-send-email-t.figa@samsung.com>
Message-ID: <1405505072.4408.17.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-04 at 19:48 +0200, Tomasz Figa wrote:
> Since all in-tree boards have been moved to device tree, we can now drop
> legacy code and make mach-s5pv210 DT-only. This patch does it.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---

This patch showed up in next-20140716 too.

>[...]
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index ed492cf..d6d0f92 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -19,181 +19,8 @@ config CPU_S5PV210
>  	help
>  	  Enable S5PV210 CPU support
>  
> -config S5PV210_SETUP_I2C1
> -	bool
> -	help
> -	  Common setup code for i2c bus 1.
> -
> -config S5PV210_SETUP_I2C2
> -	bool
> -	help
> -	  Common setup code for i2c bus 2.
> -
> -config S5PV210_SETUP_IDE
> -	bool
> -	help
> -	  Common setup code for S5PV210 IDE GPIO configurations
> -
> -config S5PV210_SETUP_FB_24BPP
> -	bool
> -	help
> -          Common setup code for S5PV210 with an 24bpp RGB display helper.
> -
> -config S5PV210_SETUP_KEYPAD
> -	bool
> -	help
> -	  Common setup code for keypad.
> -
> -config S5PV210_SETUP_SDHCI
> -        bool
> -        select S5PV210_SETUP_SDHCI_GPIO
> -        help
> -          Internal helper functions for S5PV210 based SDHCI systems
> -
> -config S5PV210_SETUP_SDHCI_GPIO
> -	bool
> -	help
> -	  Common setup code for SDHCI gpio.
> -
> -config S5PV210_SETUP_FIMC
> -	bool
> -	help
> -	  Common setup code for the camera interfaces.
> -
> -config S5PV210_SETUP_SPI
> -	bool
> -	help
> -	  Common setup code for SPI GPIO configurations.
> -
> -config S5PV210_SETUP_USB_PHY
> -	bool
> -	help
> -	  Common setup code for USB PHY controller
> -
> -menu "S5PC110 Machines"
> -
> -config MACH_AQUILA
> -	bool "Aquila"
> -	select CPU_S5PV210
> -	select S3C_DEV_FB
> -	select S3C_DEV_HSMMC
> -	select S3C_DEV_HSMMC1
> -	select S3C_DEV_HSMMC2
> -	select S5PV210_SETUP_FB_24BPP
> -	select S5PV210_SETUP_SDHCI
> -	select S5PV210_SETUP_USB_PHY
> -	select S5P_DEV_FIMC0
> -	select S5P_DEV_FIMC1
> -	select S5P_DEV_FIMC2
> -	select S5P_DEV_ONENAND
> -	help
> -	  Machine support for the Samsung Aquila target based on S5PC110 SoC
> -

This symbol is still referenced in sound/soc/samsung/Kconfig.

> -config MACH_GONI
> -	bool "GONI"
> -	select CPU_S5PV210
> -	select S3C_DEV_FB
> -	select S3C_DEV_HSMMC
> -	select S3C_DEV_HSMMC1
> -	select S3C_DEV_HSMMC2
> -	select S3C_DEV_I2C1
> -	select S3C_DEV_I2C2
> -	select S3C_DEV_USB_HSOTG
> -	select S5PV210_SETUP_FB_24BPP
> -	select S5PV210_SETUP_FIMC
> -	select S5PV210_SETUP_I2C1
> -	select S5PV210_SETUP_I2C2
> -	select S5PV210_SETUP_KEYPAD
> -	select S5PV210_SETUP_SDHCI
> -	select S5PV210_SETUP_USB_PHY
> -	select S5P_DEV_FIMC0
> -	select S5P_DEV_FIMC1
> -	select S5P_DEV_FIMC2
> -	select S5P_DEV_MFC
> -	select S5P_DEV_ONENAND
> -	select S5P_DEV_TV
> -	select S5P_GPIO_INT
> -	select SAMSUNG_DEV_KEYPAD
> -	help
> -	  Machine support for Samsung GONI board
> -	  S5PC110(MCP) is one of package option of S5PV210

Ditto.

> -config MACH_SMDKC110
> -	bool "SMDKC110"
> -	select CPU_S5PV210
> -	select S3C_DEV_I2C1
> -	select S3C_DEV_I2C2
> -	select S3C_DEV_RTC
> -	select S3C_DEV_WDT
> -	select S5PV210_SETUP_I2C1
> -	select S5PV210_SETUP_I2C2
> -	select S5PV210_SETUP_IDE
> -	select S5P_DEV_FIMC0
> -	select S5P_DEV_FIMC1
> -	select S5P_DEV_FIMC2
> -	select S5P_DEV_MFC
> -	select SAMSUNG_DEV_IDE
> -	help
> -	  Machine support for Samsung SMDKC110
> -	  S5PC110(MCP) is one of package option of S5PV210

Ditto.

> -endmenu
> -
>  menu "S5PV210 Machines"
>  
> -config MACH_SMDKV210
> -	bool "SMDKV210"
> -	select CPU_S5PV210
> -	select S3C_DEV_FB
> -	select S3C_DEV_HSMMC
> -	select S3C_DEV_HSMMC1
> -	select S3C_DEV_HSMMC2
> -	select S3C_DEV_HSMMC3
> -	select S3C_DEV_I2C1
> -	select S3C_DEV_I2C2
> -	select S3C_DEV_RTC
> -	select S3C_DEV_USB_HSOTG
> -	select S3C_DEV_WDT
> -	select S5PV210_SETUP_FB_24BPP
> -	select S5PV210_SETUP_I2C1
> -	select S5PV210_SETUP_I2C2
> -	select S5PV210_SETUP_IDE
> -	select S5PV210_SETUP_KEYPAD
> -	select S5PV210_SETUP_SDHCI
> -	select S5PV210_SETUP_USB_PHY
> -	select S5P_DEV_FIMC0
> -	select S5P_DEV_FIMC1
> -	select S5P_DEV_FIMC2
> -	select S5P_DEV_JPEG
> -	select S5P_DEV_MFC
> -	select SAMSUNG_DEV_ADC
> -	select SAMSUNG_DEV_BACKLIGHT
> -	select SAMSUNG_DEV_IDE
> -	select SAMSUNG_DEV_KEYPAD
> -	select SAMSUNG_DEV_PWM
> -	select SAMSUNG_DEV_TS
> -	help
> -	  Machine support for Samsung SMDKV210
> -

Ditto.

> -config MACH_TORBRECK
> -	bool "Torbreck"
> -	select ARCH_SPARSEMEM_ENABLE
> -	select CPU_S5PV210
> -	select S3C_DEV_HSMMC
> -	select S3C_DEV_HSMMC1
> -	select S3C_DEV_HSMMC2
> -	select S3C_DEV_HSMMC3
> -	select S3C_DEV_I2C1
> -	select S3C_DEV_I2C2
> -	select S3C_DEV_RTC
> -	select S3C_DEV_WDT
> -	select S5PV210_SETUP_I2C1
> -	select S5PV210_SETUP_I2C2
> -	select S5PV210_SETUP_SDHCI
> -	select SAMSUNG_DEV_IDE
> -	help
> -	  Machine support for aESOP Torbreck
> -
>  config MACH_S5PV210_DT
>  	bool "Samsung S5PV210/S5PC110 machine using Device Tree"
>  	select CLKSRC_OF

I assume one or more patches to remove the references to these symbols
in sound/soc/samsung/Kconfig are pending. Is that correct?


Paul Bolle
