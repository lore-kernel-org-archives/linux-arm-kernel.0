From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Sep 2013 10:01:44 +0800
Subject: [PATCH 2/2] ARM: dts: mxs: Add MSR M28CU3 board
In-Reply-To: <1380194177-5191-2-git-send-email-marex@denx.de>
References: <1380194177-5191-1-git-send-email-marex@denx.de>
 <1380194177-5191-2-git-send-email-marex@denx.de>
Message-ID: <20130927020142.GE25146@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 01:16:17PM +0200, Marek Vasut wrote:
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 98f6e2a..b5a709e 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -332,6 +332,13 @@ static void __init crystalfontz_init(void)
>  	update_fec_mac_prop(OUI_CRYSTALFONTZ);
>  }
>  
> +static void __init m28cu3_init(void)
> +{
> +	enable_clk_enet_out();

Since commit daa7d39 (net: freescale: fec: add support for optional
enet_out clk), we can have fec driver enable the clock if you do not
need the clock at the platform initialization.

Shawn

> +
> +	update_fec_mac_prop(OUI_DENX);
> +}
> +
>  static const char __init *mxs_get_soc_id(void)
>  {
>  	struct device_node *np;
> @@ -459,6 +466,8 @@ static void __init mxs_machine_init(void)
>  		apx4devkit_init();
>  	else if (of_machine_is_compatible("crystalfontz,cfa10036"))
>  		crystalfontz_init();
> +	else if (of_machine_is_compatible("msr,m28cu3"))
> +		m28cu3_init();
>  
>  	of_platform_populate(NULL, of_default_bus_match_table,
>  			     NULL, parent);
> -- 
> 1.8.4.rc3
> 
