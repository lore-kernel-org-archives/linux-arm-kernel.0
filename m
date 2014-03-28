From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Mar 2014 08:56:32 -0700
Subject: [PATCH 43/75] ARM: l2c: omap2: remove explicit SMI calls to
 enable L2 cache
In-Reply-To: <E1WTYXm-0007Fl-Ec@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYXm-0007Fl-Ec@rmk-PC.arm.linux.org.uk>
Message-ID: <20140328155631.GC24308@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:21]:
> Now that OMAP2 uses the write_sec method, we don't need to enable the L2
> cache in OMAP2 specific code; this can be done via the normal mechanisms
> in the L2C code.  Remove the OMAP2 specific code.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>

>  arch/arm/mach-omap2/omap4-common.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 7abc1eb15bf9..343c354ae6f5 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -222,11 +222,6 @@ static int __init omap_l2_cache_init(void)
>  			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
>  			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
>  
> -	omap_smc1(0x109, aux_ctrl);
> -
> -	/* Enable PL310 L2 Cache controller */
> -	omap_smc1(0x102, 0x1);
> -
>  	outer_cache.write_sec = omap4_l2c310_write_sec;
>  	if (of_have_populated_dt())
>  		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
