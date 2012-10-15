From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 15 Oct 2012 14:30:00 +0100
Subject: [RFC] Get early_printk() to work on socfpga board
In-Reply-To: <20121015124852.GA26559@elf.ucw.cz>
References: <1342637233-13965-1-git-send-email-dinguyen@altera.com>
 <20121015124852.GA26559@elf.ucw.cz>
Message-ID: <20121015133000.GA14915@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Mon, Oct 15, 2012 at 02:48:52PM +0200, Pavel Machek wrote:
> Add ioremap, so that early_printk() works. Add common 8250.S so that
> code is not duplicated with picoxcell.
>     
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
> new file mode 100644
> index 0000000..8db01ee
> --- /dev/null
> +++ b/arch/arm/include/debug/8250.S
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (c) 2011 Picochip Ltd., Jamie Iles
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Derived from arch/arm/mach-davinci/include/mach/debug-macro.S to use 32-bit
> + * accesses to the 8250.
> + */

The APB on picoxcell only supports 32-bit accesses so we have to use 
32-bit accesses for that platform, but others may need 8-bit accesses, 
so naming this 8250_32.S may be more appropriate?

I did try making 8/32 bit accesses acompile-time configuration and 
sharing with other platforms before but it looked a bit messy.

Otherwise:

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
