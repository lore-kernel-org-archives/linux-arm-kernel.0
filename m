From: john.stultz@linaro.org (John Stultz)
Date: Mon, 30 Sep 2013 10:49:32 -0700
Subject: [GIT PULL]: clocksource: new material for 3.13
In-Reply-To: <5249B7E2.5060201@linaro.org>
References: <5249B7E2.5060201@linaro.org>
Message-ID: <5249B9AC.8050209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2013 10:41 AM, Daniel Lezcano wrote:
>
> Hi Thomas,
>
> this pull request is based on 3.12-rc3 with the following content:
>
>  - Miroslav improved the RTC update by increasing the interval
> acceptable for an update in the sync_cmos_clock workqueue callback
>
>  - Prarit added a missing function declaration to fix a compilation
> issue on x86. Please *note*, this patch is coming from a pull from
> John's tree, it would make sense to cherry-pick this fix into
> timers/urgent
>
>  - Soren added FEAT_PERCPU to a clock device when it is local per cpu.
> This feature prevents the clock framework to choose a per cpu timer as
> a broadcast timer. This problem arised when the ARM global timer is
> used which is the case now on Xillinx.
>
>  - Stephen extended the generic sched_clock code to support 64bit
> counters and removes the setup_sched_clock deprecation, as that causes
> lots of warnings since there's still users in the arch/arm tree.
>
>  - Will and Sudeep implemented the event stream for architected timer.
> The event streams can be used to impose a timeout on a wfe, to
> safeguard against any programming error in case an expected event is
> not generated or even to implement wfe-based timeouts for userspace
> locking implementations.
>
>  - Zoran prevents to enter suspend mode if there are pending RTC
> timers to be handled, avoiding these ones to be delayed as well as the
> subsequent possible time critical code tied with them.
>


Hey Daniel,
    So this looks like a strange pull request. You based it on 3.12-rc3
instead of the current tip/timers/core (which is what your submitting
this to). Unfortunately since the branch you pulled from me was based on
tip/timers/core, this pull request seems to be submitting items that are
already in tip/timers/core (like the changes from Prarit, Miroslav and
Zoran).

Does any of the changes here actually depend on 3.12-rc3? If not you
might just re-generate the branch against tip/timers/core, and you'll
end up with a much cleaner pull request.

thanks
-john
