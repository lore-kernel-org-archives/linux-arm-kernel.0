From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 30 Apr 2014 15:01:32 +0200
Subject: [RFC PATCH] sched_clock: also call register_current_timer_delay()
 if possible
In-Reply-To: <20140430124800.GC21876@arm.com>
References: <1398860614-29469-1-git-send-email-bigeasy@linutronix.de>
 <20140430124800.GC21876@arm.com>
Message-ID: <5360F42C.9080401@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2014 02:48 PM, Will Deacon wrote:
> Hi Sebastian,

Hi Will,

> As long as sched_clock is guaranteed to be a fixed frequency, always-on
> clocksource then this could work, but it removes the flexibility of having
> a separate delay clock and sched clock (is this useful?).



> Looking at your patch, I noticed that we need to extend the
> register_current_timer_delay function to deal with clocks that aren't as
> wide as cycle_t, otherwise we don't delay() for long enough when the clock
> overflows (this is potentially already an issue for architected timers <
> 64-bit). Could you cook a patch for that please?

Sure, I would change the type from long to u64 and fix all users. Would
that be okay for you?

> 
> Will

Sebastian
