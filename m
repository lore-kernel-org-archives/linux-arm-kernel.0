From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 12 Mar 2010 16:00:40 +0100
Subject: [PATCH 1/2] Add support for Olimex SAM9-L9261 SBC
In-Reply-To: <20100312110032.2e57fdce@rechenknecht2k7>
References: <20100312105817.4392b594@rechenknecht2k7>
	<20100312110032.2e57fdce@rechenknecht2k7>
Message-ID: <4B9A5718.2040500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First and foremost, thank you for doing this job. It is indeed always a
good idea to submit work to the community.

Le 12/03/2010 11:00, Benjamin Valentin :

[..]

> diff -ru linux-2.6.34-rc1/drivers/video/atmel_lcdfb.c linux-2.6.34-rc1-olimex/drivers/video/atmel_lcdfb.c
> --- linux-2.6.34-rc1/drivers/video/atmel_lcdfb.c	2010-02-24 19:52:17.000000000 +0100
> +++ linux-2.6.34-rc1-olimex/drivers/video/atmel_lcdfb.c	2010-02-25 16:11:58.665578876 +0100

In a separate patch please. You will also have to sent it to
linux-fbdev-devel mailing list.

> @@ -21,6 +21,7 @@
>  #include <mach/board.h>
>  #include <mach/cpu.h>
>  #include <mach/gpio.h>
> +#include <asm/mach-types.h>
>  
>  #include <video/atmel_lcdc.h>
>  
> @@ -548,6 +549,10 @@
>  	if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
>  		value |= ATMEL_LCDC_INVFRAME_INVERTED;
>  
> +	if (machine_is_sam9_l9261()) {
> +		value |= ATMEL_LCDC_INVCLK_INVERTED;
> +	}
> +

Anyway, I think the driver is not the place to add this configuration.
You will have to configure it in the board file:
default_lcdcon2 field of the atmel_lcdfb_info structure.
Check the arch/avr32/boards/atngw100/mrmr.c file as an example.

>  	switch (info->var.bits_per_pixel) {
>  		case 1:	value |= ATMEL_LCDC_PIXELSIZE_1; break;
>  		case 2: value |= ATMEL_LCDC_PIXELSIZE_2; break;
> 

Bye,
-- 
Nicolas Ferre
