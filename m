From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:57:18 +0100
Subject: [PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
In-Reply-To: <1252387560-11234-1-git-send-email-thomas.ab@samsung.com>
References: <1252387560-11234-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20090915235718.GG13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2009 at 02:26:00PM +0900, thomas.ab at samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> In s3c64xx_setrate_clksrc() we used sclk->shift,
> but actually need to use sclk->divider_shift to
> correctly calculate the value for the divider register.

applied to next-s3c64xx-fixes.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index febac19..c972d2f 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -302,8 +302,8 @@ static int s3c64xx_setrate_clksrc(struct clk *clk, unsigned long rate)
>  		return -EINVAL;
>  
>  	val = __raw_readl(reg);
> -	val &= ~(0xf << sclk->shift);
> -	val |= (div - 1) << sclk->shift;
> +	val &= ~(0xf << sclk->divider_shift);
> +	val |= (div - 1) << sclk->divider_shift;
>  	__raw_writel(val, reg);
>  
>  	return 0;
> -- 
> 1.5.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
