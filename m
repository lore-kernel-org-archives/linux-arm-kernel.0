From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 10:29:04 +0100
Subject: [PATCH 1/2] ARM: S3C64XX: Add USB external clock definition
In-Reply-To: <4BF18846.9030809@gmail.com>
References: <4BF18846.9030809@gmail.com>
Message-ID: <20100518092904.GI26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 08:17:42PM +0200, Maurus Cuelenaere wrote:
> This adds the xusbxti clock to S3C64XX platform.

ok, applied to for-2635/s3c6410-clock
 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/clock.c              |    7 +++++++
>  arch/arm/plat-samsung/include/plat/clock.h |    1 +
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
> index 2ac2e7d..6830bb7 100644
> --- a/arch/arm/mach-s3c64xx/clock.c
> +++ b/arch/arm/mach-s3c64xx/clock.c
> @@ -88,6 +88,12 @@ struct clk clk_48m = {
>  	.enable		= clk_48m_ctrl,
>  };
>  
> +struct clk clk_xusbxti = {
> +	.name		= "xusbxti",
> +	.id		= -1,
> +	.rate		= 48000000,
> +};
> +
>  static int inline s3c64xx_gate(void __iomem *reg,
>  				struct clk *clk,
>  				int enable)
> @@ -762,6 +768,7 @@ static struct clk *clks[] __initdata = {
>  	&clk_27m,
>  	&clk_48m,
>  	&clk_h2,
> +	&clk_xusbxti,
>  };
>  
>  /**
> diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
> index 60b6269..efbc984 100644
> --- a/arch/arm/plat-samsung/include/plat/clock.h
> +++ b/arch/arm/plat-samsung/include/plat/clock.h
> @@ -74,6 +74,7 @@ extern struct clk clk_ext;
>  extern struct clk clk_h2;
>  extern struct clk clk_27m;
>  extern struct clk clk_48m;
> +extern struct clk clk_xusbxti;
>  
>  extern int clk_default_setrate(struct clk *clk, unsigned long rate);
>  extern struct clk_ops clk_ops_def_setrate;
> -- 
> 1.7.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
