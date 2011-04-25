From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Apr 2011 16:08:11 +0900
Subject: [patch 03/16] arm: s5p: Use clocksource based sched_clock
In-Reply-To: <20110423205131.787423063@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205131.787423063@linutronix.de>
Message-ID: <043d01cc0317$921bfa60$b653ef20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

(snip)

>  struct clocksource time_clocksource = {
>  	.name		= "s5p_clocksource_timer",
>  	.rating		= 250,
>  	.read		= s5p_timer_read,
>  	.mask		= CLOCKSOURCE_MASK(32),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
> CLOCKS_SOURCE_SCHED_CLOCK,

As Stephen Boyd said, with fixing CLOCK_SOURCE_SCHED_CLOCK :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
