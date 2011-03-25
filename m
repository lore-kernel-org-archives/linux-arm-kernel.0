From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 Mar 2011 08:26:20 +0100
Subject: [PATCH 1/6] mach-netx: delete hardcoded periphid
In-Reply-To: <1300874630-14708-1-git-send-email-linus.walleij@stericsson.com>
References: <1300874630-14708-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110325072620.GD7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 11:03:50AM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The periphid of the AMBA CLCD controller is hardcoded to a value
> that the CLCD driver does not even support.
> 
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

My i.MX branch is not very suitable for this patch, can you feed this
into the patch system?

Sascha

> ---
>  arch/arm/mach-netx/fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
> index 5b84bcd..b991323 100644
> --- a/arch/arm/mach-netx/fb.c
> +++ b/arch/arm/mach-netx/fb.c
> @@ -103,7 +103,6 @@ static struct amba_device fb_device = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	.irq		= { NETX_IRQ_LCD, NO_IRQ },
> -	.periphid	= 0x10112400,
>  };
>  
>  int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
> -- 
> 1.7.3.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
