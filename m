From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 May 2014 17:35:20 -0700
Subject: [PATCH] ARM: OMAP2+: free use_gptimer_clksrc variable after boot
In-Reply-To: <1397494170-3111-1-git-send-email-ghorbel@pivasoftware.com>
References: <1397494170-3111-1-git-send-email-ghorbel@pivasoftware.com>
Message-ID: <20140506003520.GN25949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Oussama Ghorbel <ghorbel@pivasoftware.com> [140414 09:50]:
> The variable use_gptimer_clksrc is only used by two __init functions,
> So we can freely free it after boot.
> 
> Signed-off-by: Oussama Ghorbel <ghorbel@pivasoftware.com>

Thanks applying into omap-for-v3.16/fixes-not-urgent.

Tony

> ---
>  arch/arm/mach-omap2/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 74044aa..d4a6abd 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -361,7 +361,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
>  
>  /* Clocksource code */
>  static struct omap_dm_timer clksrc;
> -static bool use_gptimer_clksrc;
> +static bool use_gptimer_clksrc __initdata;
>  
>  /*
>   * clocksource
> -- 
> 1.8.3.2
> 
