From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Nov 2012 14:14:57 +0100
Subject: [PATCH 1/6] clocksource: sunxi: Add Allwinner A1X Timer Driver
In-Reply-To: <1353019586-21043-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1353019586-21043-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121116141457.5c3c008c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Thu, 15 Nov 2012 23:46:20 +0100, Maxime Ripard wrote:
> +	/* Enable timer0 interrupt */
> +	val = readl(timer_base + TIMER_CTL_REG);
> +	writel(val | TIMER_CTL_ENABLE, timer_base + TIMER_CTL_REG);
> +
> +	sunxi_clockevent.mult = div_sc(TIMER_CLKSRC / TIMER_SCAL,
> +				NSEC_PER_SEC,
> +				sunxi_clockevent.shift);
> +	sunxi_clockevent.max_delta_ns = clockevent_delta2ns(0xff,
> +							    &sunxi_clockevent);
> +	sunxi_clockevent.min_delta_ns = clockevent_delta2ns(0x1,
> +							    &sunxi_clockevent);
> +	sunxi_clockevent.cpumask = cpumask_of(0);
> +
> +	clockevents_register_device(&sunxi_clockevent);

I haven't looked in details, but maybe it is possible here to use
clockevents_config_and_register() instead of
clockevents_register_device(). It would simplify this code a bit if it
works.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
