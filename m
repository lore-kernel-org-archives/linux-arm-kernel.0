From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Apr 2013 11:23:29 +0900
Subject: [PATCH 1/3] ARM: also support TWD clock, instantiated from
 platform data
In-Reply-To: <1365005636-17526-2-git-send-email-g.liakhovetski@gmx.de>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
 <1365005636-17526-2-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130405022329.GB29203@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 06:13:54PM +0200, Guennadi Liakhovetski wrote:
> While gradually switching clock initialisation to DT some architectures
> can have TWD device in DT, but supplying clock initialised from platform
> data. This patch adds support for such configurations to ARM.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/kernel/smp_twd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 3f25650..8f12aa3 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -244,7 +244,7 @@ static void twd_get_clock(struct device_node *np)
>  
>  	if (np)
>  		twd_clk = of_clk_get(np, 0);
> -	else
> +	if (IS_ERR(twd_clk))
>  		twd_clk = clk_get_sys("smp_twd", NULL);
>  
>  	if (IS_ERR(twd_clk)) {
> -- 
> 1.7.2.5
> 
