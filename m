From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sat, 23 Apr 2011 14:33:05 -0700
Subject: [patch 03/16] arm: s5p: Use clocksource based sched_clock
In-Reply-To: <20110423205131.787423063@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205131.787423063@linutronix.de>
Message-ID: <4DB34591.7090605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/2011 1:54 PM, Thomas Gleixner wrote:
>  struct clocksource time_clocksource = {
>  	.name		= "s5p_clocksource_timer",
>  	.rating		= 250,
>  	.read		= s5p_timer_read,
>  	.mask		= CLOCKSOURCE_MASK(32),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCKS_SOURCE_SCHED_CLOCK,

Drop the extra 'S'. CLOCK_SOURCE_SCHED_CLOCK.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
