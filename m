From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Jan 2011 10:40:21 -0800
Subject: [PATCH RESEND v8 3/7] omap: gpmc: enable irq mode in gpmc
In-Reply-To: <1295443503-14515-4-git-send-email-s-ghorai@ti.com>
References: <1295443503-14515-1-git-send-email-s-ghorai@ti.com>
	<1295443503-14515-4-git-send-email-s-ghorai@ti.com>
Message-ID: <20110121184020.GD11678@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [110119 05:24]:
> add support the irq mode in GPMC.
> gpmc_init() function move after omap_init_irq() as it has dependecy on irq.
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index e066177..527374f 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -146,6 +146,7 @@ static void __init omap_2430sdp_init_irq(void)
>  	omap2_init_common_infrastructure();
>  	omap2_init_common_devices(NULL, NULL);
>  	omap_init_irq();
> +	gpmc_init();
>  }
>  
>  static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 8fb5f43..8304d16 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -335,6 +335,7 @@ static void __init omap_3430sdp_init_irq(void)
>  	omap2_init_common_infrastructure();
>  	omap2_init_common_devices(hyb18m512160af6_sdrc_params, NULL);
>  	omap_init_irq();
> +	gpmc_init();
>  }
...

I think I've commented on this before, but why don't you make gpmc_init
a subsys_initcall? There should be no reason to call this earlier.
If something does not work because of that, then that issue must be
fixed.

Tony
