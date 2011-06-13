From: robherring2@gmail.com (Rob Herring)
Date: Sun, 12 Jun 2011 21:32:28 -0500
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource based
	sched_clock
In-Reply-To: <20110423205036.795894921@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
Message-ID: <4DF576BC.5010206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On 04/23/2011 03:54 PM, Thomas Gleixner wrote:
> Most of ARM sched_clocks is using the timekeeping clocksource as the
> sched_clock. Only versatile uses a different clock for it, but there
> is no real reason why it can't use the clocksource as well.
>
> The core timekeeping code makes already sure that we don't wrap the
> timekeeper and we can base a sched_clock easily on that.
>
> It uses the read function of the clocksource and keeps track of time
> independent of the timekeeping code as the ARM sched_clock
> implementation does. It also uses it's own sequence counter so
> sched_clock is not dependent on xtime_lock. The update sequence is
> just adding offsets once in a while and runs from do_timer() which
> also makes sure that only one core tries to update it.
>
> Only lightly tested on orion. Please give it a go.
>
> Another 650 lines gone :)
>

What's happening with this patch series? Just wondering if I'll need to 
add yet another sched_clock implementation or not.

Rob
