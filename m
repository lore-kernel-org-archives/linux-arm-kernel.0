From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 19 May 2011 11:08:49 +0200
Subject: [patch 4/7] clockevents: Provide combined configure and register
	function
In-Reply-To: <20110518210136.331975870@linutronix.de>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.331975870@linutronix.de>
Message-ID: <20110519090849.GA6251@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +extern void clockevents_config_and_register(struct clock_event_device *dev,
> +					    u32 freq, unsigned long min_delta,
> +					    unsigned long max_delta);

might be worth collecting these fields into a clocksource_params structure:

struct clocksource_params {
	u32		freq;
	unsigned long	min_delta;
	unsigned long	max_delta;
};

That way the initialization API looks even more streamlined:

extern void
clockevents_config_and_register(struct clock_event_device *dev,
				struct clocksource_params params);

and could be extended in the future, without having to update every single 
clocksource driver again.

But a good first step in any case:

Reviewed-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
