From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 14:51:47 -0800
Subject: [PATCH 3/4] clk: ti: add support for default-rate property from DT
In-Reply-To: <1392282048-6284-4-git-send-email-t-kristo@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
 <1392282048-6284-4-git-send-email-t-kristo@ti.com>
Message-ID: <20140228225147.GS13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140213 01:04]:
> default-rate property can now be used to define default rates for clocks,
> which get configured during boot.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This can go with the drivers/clk patches as far as I'm concerned:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/prm_common.c |    2 ++
>  drivers/clk/ti/clk.c             |    1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index b4c4ab9..4703545 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -528,5 +528,7 @@ int __init of_prcm_init(void)
>  
>  	ti_dt_clockdomains_setup();
>  
> +	of_clk_set_init_rates();
> +
>  	return 0;
>  }
> diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
> index b1a6f71..23998b7 100644
> --- a/drivers/clk/ti/clk.c
> +++ b/drivers/clk/ti/clk.c
> @@ -156,6 +156,7 @@ void ti_dt_clk_init_provider(struct device_node *parent, int index)
>  		clk_init_cb = (of_clk_init_cb_t)match->data;
>  		pr_debug("%s: initializing: %s\n", __func__, np->name);
>  		clk_init_cb(np);
> +		of_clk_parse_init_rate(np, NULL);
>  	}
>  
>  	list_for_each_entry_safe(retry, tmp, &retry_list, link) {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
