From: vikram186@gmail.com (Vikram Narayanan)
Date: Sun, 24 Apr 2011 19:50:55 +0530
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <4DB0F249.6000307@codeaurora.org>
References: <BANLkTi=q8-1ybXNky04A6WA7+VA5ZgOB-g@mail.gmail.com>
	<4DB0F249.6000307@codeaurora.org>
Message-ID: <BANLkTinkkMkyy3OnSiOqgUBHiytFPparbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 8:43 AM, Jeff Ohlstein <johlstei@codeaurora.org> wrote:
> Vikram Narayanan wrote:
>> And also, are clocksoure and clockevents dependent on each other? I
>> see in some platforms, that they have used 2 different timers for the
>> above. Can a same clock be used for both clocksource and clockevents?
>> Please throw some light on this. If it can be used so, what ties up
>> the clocksource and clockevent?
>
> You can look at msm for an example of a single timer being used both as
> a clocksource and a clockevent. We end up shutting off the clocksource
> whenever we shut down the clockevent. This does cause some issues.
> Switching clocksources at runtime does not work. It will also cause
> problems if you implement your own sched_clock function, as it will have
> little choice but to return a stale cached value whenever the clockevent
> is disabled, such as in the suspend path.
Thanks for the example. I will refer to that. And I have another
question, If dynamic ticks are implemented, say if I am using the same
clocksource and clockevent, the wall time will only be updated at that
dyn_tick interval. Will that create any issue? or should I use a
constant source for the clocksource? or how to handle this in an
effective way.
* Clocksource and clockevents with the same timer.
* Also I want to make use of the tickless kernel functionality.

Vikram

>
> Jeff
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
