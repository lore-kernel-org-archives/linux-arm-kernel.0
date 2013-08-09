From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 09 Aug 2013 09:49:26 +0200
Subject: [PATCH 06/18] ARM: IXP4xx: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-7-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Wed, 31 Jul 2013 15:31:05 -0700")
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
 <1375309877-16617-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <m3iozfqp6h.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.

Don't find anything wrong in this.

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>

> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -448,7 +448,7 @@ void __init ixp4xx_sys_init(void)
>  /*
>   * sched_clock()
>   */
> -static u32 notrace ixp4xx_read_sched_clock(void)
> +static u64 notrace ixp4xx_read_sched_clock(void)
>  {
>  	return *IXP4XX_OSTS;
>  }
> @@ -466,7 +466,7 @@ unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
>  EXPORT_SYMBOL(ixp4xx_timer_freq);
>  static void __init ixp4xx_clocksource_init(void)
>  {
> -	setup_sched_clock(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
> +	sched_clock_register(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
>  
>  	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
>  			ixp4xx_clocksource_read);

-- 
Krzysztof Halasa
