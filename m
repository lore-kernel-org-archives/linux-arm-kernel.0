From: john.stultz@linaro.org (John Stultz)
Date: Mon, 22 Jul 2013 10:07:10 -0700
Subject: [PATCH v4 00/17] 64-bit friendly generic sched_clock()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51ED66BE.8040006@linaro.org>
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
>
> Stephen Boyd (17):
>    clocksource: Extract max nsec calculation into separate function
>    sched_clock: Use seqcount instead of rolling our own
>    sched_clock: Use an hrtimer instead of timer
>    sched_clock: Add support for >32 bit sched_clock
>    arch_timer: Move to generic sched_clock framework
>    sched_clock: Remove sched_clock_func() hook
>    clocksource: bcm2835: Switch to sched_clock_register()
>    ocksource: dbx500-prcmu: Switch to sched_clock_register()
>    clocksource: dw_apb_timer_of: Switch to sched_clock_register()
>    clocksource: mxs_timer: Switch to sched_clock_register()
>    clocksource: nomadik: Switch to sched_clock_register()
>    clocksource: samsung_pwm_timer: Switch to sched_clock_register()
>    clocksource: tegra: Switch to sched_clock_register()
>    clocksource: time-armada-370-xp: Switch to sched_clock_register()
>    clocksource: sirf: Switch to sched_clock_register() and use 64 bits
>    clocksource: vf_pit_timer: Switch to sched_clock_register()
>    sched_clock: Deprecate setup_sched_clock()

Ok, so if there's no major objections with this set, here's my plan:

1) I'm going to queue 1-4 in a fortglx/3.12/sched-clock64 branch, I'll 
send git pull requests to both Thomas and Olof, so they can both merge 
the common base for the conversion code in both drivers/clocksource and 
arch/arm.

2) If I can get Catalin's ack on 5/17, I'll queue it and 6/17 for 
tip/timers/core.

3) I'll also queue the rest and send to Thomas or Daniel for 
tip/timers/core.

That sound ok to everyone?

thanks
-john
