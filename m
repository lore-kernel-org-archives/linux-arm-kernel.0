From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 06 Aug 2013 11:04:45 +0200
Subject: [PATCH v4 14/17] clocksource: time-armada-370-xp: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-15-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-15-git-send-email-sboyd@codeaurora.org>
Message-ID: <5200BC2D.6050200@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/2013 01:21, Stephen Boyd wrote:
> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> 
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clocksource/time-armada-370-xp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index efdca32..2bec8dc 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -71,7 +71,7 @@ static u32 ticks_per_jiffy;
>  
>  static struct clock_event_device __percpu **percpu_armada_370_xp_evt;
>  
> -static u32 notrace armada_370_xp_read_sched_clock(void)
> +static u64 notrace armada_370_xp_read_sched_clock(void)
>  {
>  	return ~readl(timer_base + TIMER0_VAL_OFF);
>  }
> @@ -258,7 +258,7 @@ void __init armada_370_xp_timer_init(void)
>  	/*
>  	 * Set scale and timer for sched_clock.
>  	 */
> -	setup_sched_clock(armada_370_xp_read_sched_clock, 32, timer_clk);
> +	sched_clock_register(armada_370_xp_read_sched_clock, 32, timer_clk);
>  
>  	/*
>  	 * Setup free-running clocksource timer (interrupts
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
