From: gadiyar@ti.com (Gadiyar, Anand)
Date: Mon, 2 Aug 2010 17:48:11 +0530
Subject: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
In-Reply-To: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
References: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323E686D4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 13dc979..b557cc2 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c

<snip>

> @@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
>  	 */
>  	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
>  
> +	/*
> +	 * Override default outer_cache.disable with a OMAP4
> +	 * specific one
> +	*/

Minor comment - you need a space before the '*'

> +	outer_cache.disable = omap4_l2x0_disable;
> +
>  	return 0;
>  }
>  early_initcall(omap_l2_cache_init);
