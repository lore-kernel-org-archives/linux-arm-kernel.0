From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Jan 2012 06:37:36 -0800
Subject: [PATCH 23/31] ARM: amba: omap2: use common amba device
 initializers
In-Reply-To: <E1RoAnS-0005Fo-Lr@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAnS-0005Fo-Lr@rmk-PC.arm.linux.org.uk>
Message-ID: <20120120143736.GL22818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120120 00:58]:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/emu.c |   26 ++------------------------
>  1 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
> index 9c442e2..ce91aad 100644
> --- a/arch/arm/mach-omap2/emu.c
> +++ b/arch/arm/mach-omap2/emu.c
> @@ -30,29 +30,8 @@ MODULE_AUTHOR("Alexander Shishkin");
>  #define ETB_BASE	(L4_EMU_34XX_PHYS + 0x1b000)
>  #define DAPCTL		(L4_EMU_34XX_PHYS + 0x1d000)
>  
> -static struct amba_device omap3_etb_device = {
> -	.dev		= {
> -		.init_name = "etb",
> -	},
> -	.res		= {
> -		.start	= ETB_BASE,
> -		.end	= ETB_BASE + SZ_4K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	.periphid	= 0x000bb907,
> -};
> -
> -static struct amba_device omap3_etm_device = {
> -	.dev		= {
> -		.init_name = "etm",
> -	},
> -	.res		= {
> -		.start	= ETM_BASE,
> -		.end	= ETM_BASE + SZ_4K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	.periphid	= 0x102bb921,
> -};
> +static AMBA_APB_DEVICE(omap3_etb, "etb", 0x000bb907, ETB_BASE, { }, NULL);
> +static AMBA_APB_DEVICE(omap3_etm, "etm", 0x102bb921, ETM_BASE, { }, NULL);
>  
>  static int __init emu_init(void)
>  {
> @@ -66,4 +45,3 @@ static int __init emu_init(void)
>  }
>  
>  subsys_initcall(emu_init);
> -
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
