From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 10:53:41 -0800
Subject: [PATCH 6/8] arch/arm/mach-omap2/dpll3xxx.c: drop if around WARN_ON
In-Reply-To: <1351974625-10282-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1351974625-10282-1-git-send-email-Julia.Lawall@lip6.fr>
 <1351974625-10282-7-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20121214185340.GJ4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Julia Lawall <Julia.Lawall@lip6.fr> [121103 13:32]:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Just use WARN_ON rather than an if containing only WARN_ON(1).

Thanks applying this one into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
 
> A simplified version of the semantic patch that makes this transformation
> is as follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e;
> @@
> - if (e) WARN_ON(1);
> + WARN_ON(e);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  arch/arm/mach-omap2/dpll3xxx.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index eacf51f..ed855b0 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -478,8 +478,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
>  		if (!soc_is_am33xx() && !cpu_is_omap44xx() && !cpu_is_omap3630()) {
>  			freqsel = _omap3_dpll_compute_freqsel(clk,
>  						dd->last_rounded_n);
> -			if (!freqsel)
> -				WARN_ON(1);
> +			WARN_ON(!freqsel);
>  		}
>  
>  		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
> 
