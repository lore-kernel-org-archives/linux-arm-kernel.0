From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 25 Apr 2011 16:10:33 +0900
Subject: [patch 01/16] time: Provide clocksource based sched_clock()
In-Reply-To: <20110423205131.574884925@linutronix.de>
References: <20110423205036.795894921@linutronix.de>
	<20110423205131.574884925@linutronix.de>
Message-ID: <043e01cc0317$e234bd20$a69e3760$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> 
> Many embedded platforms use the clocksource which is used for
> timekeeping as their sched_clock as well. Though they need to take
> care about the wraparounds as sched_clock() wants to be monotonic
> increasing nsescs. The timekeeping code and the NOHZ core take care of
> the timekeeping clocksource wraparound so we can simply use the
> timekeeping clocksource if possible.
> 
> clocksources which can be used by the clksrc sched_clock must have the
> flag CLOCK_SOURCE_SCHED_CLOCK set. This works with the default (weak)
> sched_clock implementation but the clksrc based function is also
> provided for architectures where multi platform kernels might override
> it. If there is no CLOCK_SOURCE_SCHED_CLOCK available, then the
> function returns the jiffies based sched clock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested on Samsung stuff...

Tested-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>  include/linux/clocksource.h |    1
>  include/linux/sched.h       |    1
>  kernel/sched_clock.c        |   12 ----
>  kernel/time/Kconfig         |    4 +
>  kernel/time/timekeeping.c   |  125
> ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 131 insertions(+), 12 deletions(-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
