From: srinidhi.kasagar@stericsson.com (srinidhi)
Date: Fri, 26 Mar 2010 10:27:37 +0530
Subject: [PATCH 4/5] ARM: add PrimeCell generic DMA to PL011
In-Reply-To: <b328b2051003252142o1c142ca0h66135eb9129d1c99@mail.gmail.com>
References: <1268056365-17417-1-git-send-email-linus.walleij@stericsson.com>
	<b328b2051003252142o1c142ca0h66135eb9129d1c99@mail.gmail.com>
Message-ID: <1269579457.8895.5.camel@bnru03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

> This extends the PL011 UART driver with generic DMA engine support
> using the PrimeCell DMA engine interface.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/serial/amba-pl011.c |  649
> ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/amba/serial.h |    6 +
>  2 files changed, 653 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
> index aad86ec..41ed380 100644
> --- a/drivers/serial/amba-pl011.c
> +++ b/drivers/serial/amba-pl011.c
> @@ -7,6 +7,7 @@
>  *
>  *  Copyright 1999 ARM Limited
>  *  Copyright (C) 2000 Deep Blue Solutions Ltd.
> + *  Copyright (C) 2010 ST-Ericsson SA
>  *
>  * This program is free software; you can redistribute it and/or
> modify
>  * it under the terms of the GNU General Public License as published
> by
> @@ -47,10 +48,17 @@
>  #include <linux/amba/bus.h>
>  #include <linux/amba/serial.h>
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/completion.h>
> +#include <linux/amba/dma.h>
> 
>  #include <asm/io.h>
>  #include <asm/sizes.h>
> 
> +#include <mach/coh901318.h>
Is this accidentally added? Please update 5983/1 patch in Russell's
tracking system.

regards,
Srinidhi
