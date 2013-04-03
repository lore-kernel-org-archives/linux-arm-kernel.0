From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 16:48:06 -0600
Subject: [PATCH] clocksource: tegra: enable arch_timer
In-Reply-To: <515CA060.7030100@gmail.com>
References: <1364988750-25058-1-git-send-email-josephl@nvidia.com>
 <515C2E8F.1030802@gmail.com> <515C7363.4040404@wwwdotorg.org>
 <515CA060.7030100@gmail.com>
Message-ID: <515CB1A6.6090308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 03:34 PM, Rob Herring wrote:
> On 04/03/2013 01:22 PM, Stephen Warren wrote:
>> On 04/03/2013 07:28 AM, Rob Herring wrote:
>>> On 04/03/2013 06:32 AM, Joseph Lo wrote:
>>>> Architected timer is the local timer for Cortex-A15. Adding the support
>>>> for Tegra.
>>>>
>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>
>>> My patch series to add CLOCKSOURCE_OF_DECLARE support to arch timer and
>>> sched_clock enhancements will make this unnecessary:
>>>
>>> http://www.spinics.net/lists/arm-kernel/msg234597.html
>>>
>>> Testing would be appreciated.
>>
>> Joseph (or Rob), what's the benefit of this change; what works with it
>> and/or what breaks without it?
> 
> I assume you mean Joseph's change.

Yes.

> Well, it enables local timers on A15.
> But mine will too for Tegra if you have the arch timer in the dtb.

Well, I meant what benefit would I see from enabling them, rather than
using the Tegra-specific timers as I believe is currently happening.

>> Rob, if I did apply this change, and you also apply that series of
>> yours, what is the result: compile-time breakage, run-time breakage,
>> just some redundant code that needs to be removed again?
> 
> Compile-time breakage as the functions called here are being removed.

OK, I definitely won't apply Joseph's patch then.

Aside from that, I took the git branch you mentioned in the patch you
linked to above, merged it into my dev tree, updated my bootloader to
actually initialize the TSC correctly, and I see the following during
boot, so I guess that's enough for:

Tested-by: Stephen Warren <swarren@nvidia.com>

on your patches.

> [    0.000000] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 4294967ms
> [    0.000000] Architected local timer running at 12.00MHz (virt).
> [    0.000000] Switching to timer-based delay loop
> [  117.431229] Calibrating delay loop (skipped), value calculated using timer frequency.. 24.00 BogoMIPS (lpj=120000)
> [  117.987221] Switching to clocksource arch_sys_counter
