From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Aug 2011 10:18:34 +0200
Subject: [[PATCH v2] ARM: i.MX: initialize l2x0 at early_init time
In-Reply-To: <1314326654-19128-1-git-send-email-jason.hui@linaro.org>
References: <1314326654-19128-1-git-send-email-jason.hui@linaro.org>
Message-ID: <20110826081834.GE31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 10:44:14AM +0800, Jason Liu wrote:
> This can make the l2 cache work at early time which
> will benefit the boot up time.
> 
> Tested on i.mx31pdk board, test result shows:
> 
> Before: arch_initcall(mxc_init_l2x0);
> 
> [    0.558755] console [ttymxc0] enabled
> 
> After: early_initcall(mxc_init_l2x0);
> 
> [    0.555716] console [ttymxc0] enabled
> 
> Signed-off-by: Jason Liu <jason.hui@linaro.org>

Applied for next.

Sascha

> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/cache-l2x0.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cache-l2x0.c b/arch/arm/mach-imx/cache-l2x0.c
> index 69d1322..e5538a4 100644
> --- a/arch/arm/mach-imx/cache-l2x0.c
> +++ b/arch/arm/mach-imx/cache-l2x0.c
> @@ -53,4 +53,4 @@ static int mxc_init_l2x0(void)
>  
>  	return 0;
>  }
> -arch_initcall(mxc_init_l2x0);
> +early_initcall(mxc_init_l2x0);
> -- 
> 1.7.4.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
