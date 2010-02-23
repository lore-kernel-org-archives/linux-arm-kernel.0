From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 24 Feb 2010 09:09:19 +1300
Subject: [PATCH] ep93xx: fix broken build of clock.c
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909021B9BFC@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909021B9BFC@mi8nycmail19.Mi8.com>
Message-ID: <4B8435EF.4060307@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Patch 5879/1: ep93xx: define magic numbers for pll1 and pll2 broke
> the ep93xx build due to one missing rename of EP93XX_SYSCON_CLOCK_SET2.
> The correct name should be EP93XX_SYSCON_CLKSET2.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index e894ee0..5f80092 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -462,7 +462,7 @@ static int __init ep93xx_clock_init(void)
>  	ep93xx_dma_clock_init();
>  
>  	/* Determine the bootloader configured pll2 rate */
> -	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET2);
> +	value = __raw_readl(EP93XX_SYSCON_CLKSET2);
>  	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
>  		clk_pll2.rate = clk_xtali.rate;
>  	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)

This fixes a build failure, and has been compile and boot tested.

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
