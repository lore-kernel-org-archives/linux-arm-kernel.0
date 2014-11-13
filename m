From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 13 Nov 2014 10:37:09 +0100
Subject: [PATCH] ARM: at91: remove unused CONFIG_ARCH_AT91SAM9G45 option
In-Reply-To: <1415871190-32244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1415617517.4862.44.camel@x220>
 <1415871190-32244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20141113103709.35b053ad@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Nov 2014 10:33:10 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> The CONFIG_ARCH_AT91SAM9G45 config option was removed by ("ARM: at91: remove
> at91sam9g45/9m10 legacy board support") so cleanup the use of it.
> 
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  arch/arm/mach-at91/Makefile.boot | 6 ------
>  arch/arm/mach-at91/board.h       | 4 ----
>  2 files changed, 10 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
> index 5309f9b6aabc..29ed0fa374ca 100644
> --- a/arch/arm/mach-at91/Makefile.boot
> +++ b/arch/arm/mach-at91/Makefile.boot
> @@ -3,12 +3,6 @@
>  #   PARAMS_PHYS must be within 4MB of ZRELADDR
>  #   INITRD_PHYS must be in RAM
>  
> -ifeq ($(CONFIG_ARCH_AT91SAM9G45),y)
> -   zreladdr-y	+= 0x70008000
> -params_phys-y	:= 0x70000100
> -initrd_phys-y	:= 0x70410000
> -else
>     zreladdr-y	+= 0x20008000
>  params_phys-y	:= 0x20000100
>  initrd_phys-y	:= 0x20410000
> -endif
> diff --git a/arch/arm/mach-at91/board.h b/arch/arm/mach-at91/board.h
> index 836e9a537e0c..d268ec3781dd 100644
> --- a/arch/arm/mach-at91/board.h
> +++ b/arch/arm/mach-at91/board.h
> @@ -56,11 +56,7 @@ extern void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data);
>  extern void __init at91_add_device_nand(struct atmel_nand_data *data);
>  
>   /* I2C*/
> -#if defined(CONFIG_ARCH_AT91SAM9G45)
> -extern void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, int nr_devices);
> -#else
>  extern void __init at91_add_device_i2c(struct i2c_board_info *devices, int nr_devices);
> -#endif
>  
>   /* SPI */
>  extern void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices);



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
