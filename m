From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 26 Apr 2011 21:10:55 +0530
Subject: [patch 04/16] arm: davinci: Use clocksource based sched_clock
In-Reply-To: <20110423205131.902302687@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205131.902302687@linutronix.de>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CBA942B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 24, 2011 at 02:24:43, Thomas Gleixner wrote:

> -static cycle_t read_cycles(struct clocksource *cs)
> +static cycle_t notrace read_cycles(struct clocksource *cs)
>  {
>  	struct timer_s *t = &timers[TID_CLOCKSOURCE];
>  
>  	return (cycles_t)timer32_read(t);
>  }
>  
> -/*
> - * Kernel assumes that sched_clock can be called early but may not have
> - * things ready yet.
> - */
> -static cycle_t read_dummy(struct clocksource *cs)
> -{
> -	return 0;
> -}
> -
> -
>  static struct clocksource clocksource_davinci = {
>  	.rating		= 300,
> -	.read		= read_dummy,
> +	.read		= read_,

This should be read_cycles, I guess.

With that fixed, boot tested on DM365 and DA850 EVMs.

Thanks,
Sekhar
