From: john.stultz@linaro.org (John Stultz)
Date: Thu, 18 Jul 2013 16:59:44 -0700
Subject: [PATCH v4 00/17] 64-bit friendly generic sched_clock()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51E88170.3080505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2013 04:21 PM, Stephen Boyd wrote:
> This patchset adds support for 64 bit counters in the generic
> sched_clock code and converts drivers over to use it. Based
> on v3.11-rc1.
>
> Changes since v3:
>   * Move to use seqcount to fix issues with 64-bit cyc counters
>   * Move to hrtimer to fix underflow/overflow errors in wraparound
>     calculation
>   * Use of 1 hour in clocks_calc_mult_shift
>   * Converted over drivers in drivers/clocksource

I've not been able to take a deep review yet, but this looks pretty much 
like what we discussed last week, so I'm happy with it so far. Has this 
gotten much testing (on both 32 and 64bit systems?)

One detail: Most of this is likely to go in via tip/timers/core, but the 
5/17 "arch_timer: Move to generic sched_clock" will need some 
synchronization with Catalin to make sure its ok to go in via tip. Not 
sure what other arm64 changes are pending that would depend or collide 
with that change.

thanks
-john
