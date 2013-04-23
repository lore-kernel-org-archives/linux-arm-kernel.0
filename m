From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Apr 2013 14:26:07 -0700
Subject: [PATCH] ARM: OMAP: remove unused variable
In-Reply-To: <201304232323.27751.arnd@arndb.de>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
 <201304232323.27751.arnd@arndb.de>
Message-ID: <20130423212607.GL10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130423 14:28]:
> ARM: OMAP: remove unused variable
>     
> Commit 0583fe478a7 "ARM: convert arm/arm64 arch timer to use CLKSRC_OF init"
> has left the omap5_realtime_timer_init() function with a stale variable and
> broken whitespace. This fixes both.
>     
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I've applied this patch on top of the timer cleanup series

OK thanks.

Tony
 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 7dd6453..686e498 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -618,12 +618,10 @@ OMAP_SYS_32K_TIMER_INIT(5, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
>  			2, OMAP4_MPU_SOURCE);
>  void __init omap5_realtime_timer_init(void)
>  {
> -	int err;
> -
>  	omap5_sync32k_timer_init();
>  	realtime_counter_init();
>  
> -        clocksource_of_init();
> +	clocksource_of_init();
>  }
>  #endif /* CONFIG_SOC_OMAP5 */
>  
