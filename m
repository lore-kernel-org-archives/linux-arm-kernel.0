From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 27 Sep 2010 01:08:34 +0100
Subject: [PATCH] s3c: add support for mini6410
In-Reply-To: <20100916172402.18683.30937.stgit@darius-desktop>
References: <20100916172402.18683.30937.stgit@darius-desktop>
Message-ID: <4C9FE082.4050808@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/10 18:24, Darius Augulis wrote:
> Add support for mini6410 board from FriendlyARM
> 
> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
>
> +obj-$(CONFIG_MACH_MINI6410)     += mach-mini6410.o
>  obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
>  obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
>  obj-$(CONFIG_MACH_SMARTQ)	+= mach-smartq.o
> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> new file mode 100644
> index 0000000..560e347
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -0,0 +1,154 @@
> +/* linux/arch/arm/mach-s3c64xx/mach-mini6410.c
> + *
> + * Copyright 2010 Darius Augulis <augulis.darius@gmail.com>
> + * Copyright 2008 Openmoko, Inc.
> + * Copyright 2008 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *	http://armlinux.simtec.co.uk/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> +*/

> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/dm9000.h>
> +#include <linux/serial_core.h>
> +#include <linux/types.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/map.h>
> +#include <mach/regs-gpio.h>
> +#include <mach/regs-srom.h>
> +#include <mach/s3c6410.h>
> +#include <plat/cpu.h>
> +#include <plat/devs.h>
> +#include <plat/regs-serial.h>

My preference is to split up the include blocks with a blank line.


> +#define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
> +#define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
> +#define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
> +
> +static struct s3c2410_uartcfg mini6410_uartcfgs[] __initdata = {
> +	[0] = {
> +		.hwport	= 0,
> +		.flags	= 0,
> +		.ucon	= UCON,
> +		.ulcon	= ULCON,
> +		.ufcon	= UFCON,
> +	},
> +	[1] = {
> +		.hwport	= 1,
> +		.flags	= 0,
> +		.ucon	= UCON,
> +		.ulcon	= ULCON,
> +		.ufcon	= UFCON,
> +	},
> +	[2] = {
> +		.hwport	= 2,
> +		.flags	= 0,
> +		.ucon	= UCON,
> +		.ulcon	= ULCON,
> +		.ufcon	= UFCON,
> +	},
> +	[3] = {
> +		.hwport	= 3,
> +		.flags	= 0,
> +		.ucon	= UCON,
> +		.ulcon	= ULCON,
> +		.ufcon	= UFCON,
> +	},
> +};

I'm beginging to think we should just have a standard
implementation of these.

Otherwise looks good, up to myself and Kukjin to agree
on who should merge.
