From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2015 07:11:56 -0800
Subject: [RFC 8/9] ARM: OMAP4: hwmod_data: use module clocks from DT
In-Reply-To: <1450447141-29936-9-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
 <1450447141-29936-9-git-send-email-t-kristo@ti.com>
Message-ID: <20151218151156.GH23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [151218 05:57]:
> Replace the usage of prcm->clkstctrl with main_clk:s provided via DT.
> This is done in preparation to get rid of hwmod data from kernel.
...
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -334,10 +329,9 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
>  	.class		= &omap44xx_counter_hwmod_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
>  	.flags		= HWMOD_SWSUP_SIDLE,
> -	.main_clk	= "sys_32k_ck",
> +	.main_clk	= "counter_32k_mod_ck",
>  	.prcm = {
>  		.omap4 = {
> -			.clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
>  			.context_offs = OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
>  		},
>  	},

Care to describe why the main_clk now needs to be modified or
added? Can that too come from dts now?

Regards,

Tony
