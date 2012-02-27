From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Feb 2012 10:24:21 +0100
Subject: [PATCH][trivial] ARM: Remove redundant ';' from
 avic_irq_set_priority()
In-Reply-To: <alpine.LNX.2.00.1202262307210.6089@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1202262307210.6089@swampdragon.chaosbits.net>
Message-ID: <20120227092421.GX3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 11:09:40PM +0100, Jesper Juhl wrote:
> One semi-colon at the end of the return statement is sufficient.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Applied

Sascha

> ---
>  arch/arm/plat-mxc/avic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
> index 55f1569..689f81f 100644
> --- a/arch/arm/plat-mxc/avic.c
> +++ b/arch/arm/plat-mxc/avic.c
> @@ -60,7 +60,7 @@ static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
>  	unsigned int mask = 0x0F << irq % 8 * 4;
>  
>  	if (irq >= AVIC_NUM_IRQS)
> -		return -EINVAL;;
> +		return -EINVAL;
>  
>  	temp = __raw_readl(avic_base + AVIC_NIPRIORITY(irq / 8));
>  	temp &= ~mask;
> -- 
> 1.7.9.2
> 
> 
> -- 
> Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
> Don't top-post http://www.catb.org/jargon/html/T/top-post.html
> Plain text mails only, please.
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
