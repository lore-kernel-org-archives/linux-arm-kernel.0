From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Nov 2013 15:01:10 +0100
Subject: [PATCH 1/4] ARM: sa1100: stop using mach/timex.h
In-Reply-To: <1384292466-31725-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1384292466-31725-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131126140110.GJ28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[expanded To: and Cc: to include the people scripts/get_maintainer.pl suggested]

On Tue, Nov 12, 2013 at 10:41:03PM +0100, Uwe Kleine-K?nig wrote:
> mach/timex.h is the last remaining header that is unused for multiarch
> builds but necessary for singlearch builds. To allow to get rid of it
> for singlearch builds, too, drop its usage in sa1100 arch code by
> substituting CLOCK_TICK_RATE by a local cpp symbol.
Who feels responsible to give (a reason for not giving) an Ack here?

Thanks
Uwe

> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-sa1100/time.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
> index 713c86c..83be0d6 100644
> --- a/arch/arm/mach-sa1100/time.c
> +++ b/arch/arm/mach-sa1100/time.c
> @@ -20,6 +20,8 @@
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
>  
> +#define SA1100_CLOCK_FREQ 3686400
> +
>  static u32 notrace sa1100_read_sched_clock(void)
>  {
>  	return readl_relaxed(OSCR);
> @@ -128,7 +130,7 @@ void __init sa1100_timer_init(void)
>  
>  	setup_irq(IRQ_OST0, &sa1100_timer_irq);
>  
> -	clocksource_mmio_init(OSCR, "oscr", CLOCK_TICK_RATE, 200, 32,
> +	clocksource_mmio_init(OSCR, "oscr", SA1100_CLOCK_FREQ, 200, 32,
>  		clocksource_mmio_readl_up);
>  	clockevents_config_and_register(&ckevt_sa1100_osmr0, 3686400,
>  					MIN_OSCR_DELTA * 2, 0x7fffffff);
> -- 
> 1.8.4.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
