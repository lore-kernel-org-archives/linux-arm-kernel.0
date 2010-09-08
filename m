From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 8 Sep 2010 12:56:33 +0530
Subject: [PATCH] omap: Fix CONFIG_LOCAL_TIMERS initialization for
	multi-omap
In-Reply-To: <20100908031748.GK22507@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
	<20100906180346.GC20849@atomide.com>
	<20100908030951.GH22507@atomide.com>
	<20100908031214.GI22507@atomide.com>
	<20100908031404.GJ22507@atomide.com>
	<20100908031748.GK22507@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3098@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, September 08, 2010 8:48 AM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org;
> bryan.wu at canonical.com
> Subject: [PATCH] omap: Fix CONFIG_LOCAL_TIMERS initialization for multi-
> omap
> 
> Fix CONFIG_LOCAL_TIMERS initialization for multi-omap
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-
> gp.c
> index 74fbed8..5a3e606 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -228,8 +228,10 @@ static void __init omap2_gp_clocksource_init(void)
>  static void __init omap2_gp_timer_init(void)
>  {
>  #ifdef CONFIG_LOCAL_TIMERS
> -	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
> -	BUG_ON(!twd_base);
> +	if (cpu_is_omap44xx()) {
> +		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
> +		BUG_ON(!twd_base);
> +	}
>  #endif
>  	omap_dm_timer_init();
> 
Acked-By: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards,
Santosh
