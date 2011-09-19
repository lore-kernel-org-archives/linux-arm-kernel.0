From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Sep 2011 11:35:16 +0200
Subject: [PATCH v2 2/6] arm/imx6q: add core definitions and low-level
	debug uart
In-Reply-To: <1316097926-913-3-git-send-email-shawn.guo@linaro.org>
References: <1316097926-913-1-git-send-email-shawn.guo@linaro.org>
	<1316097926-913-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110919093516.GK31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 10:45:22PM +0800, Shawn Guo wrote:
> It adds the core definitions and low-level debug uart support
> for imx6q.
> 
>  
>  #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
> diff --git a/arch/arm/plat-mxc/include/mach/entry-macro.S b/arch/arm/plat-mxc/include/mach/entry-macro.S
> index 066d464..341f800 100644
> --- a/arch/arm/plat-mxc/include/mach/entry-macro.S
> +++ b/arch/arm/plat-mxc/include/mach/entry-macro.S
> @@ -1,6 +1,6 @@
>  /*
>   *  Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
> - *  Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + *  Copyright 2004-2011 Freescale Semiconductor, Inc. All Rights Reserved.
>   */
>  
>  /*
> @@ -11,6 +11,17 @@
>  
>  #include <mach/hardware.h>
>  
> +#ifdef CONFIG_ARM_GIC
> +#include <asm/hardware/entry-macro-gic.S>
> +
> +	.macro	disable_fiq
> +	.endm
> +
> +	.macro	arch_ret_to_user, tmp1, tmp2
> +	.endm
> +
> +#else

That's the third interrupt entry code handled here with ifdefs. I
remember there was some infrastructure to have multiple irq
controllers. I can't find any pointers, but I think Eric (added him
to Cc) told me about it.
As this is also the last roadblock to compile i.MX3 and i.MX5 into a
single kernel this might be the right moment to work on this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
