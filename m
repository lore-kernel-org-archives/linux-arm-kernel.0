From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Oct 2014 22:52:25 +0100
Subject: [PATCH] ARM/ARM64: arch-timer: fix arch_timer_probed logic
In-Reply-To: <alpine.DEB.2.11.1410272129170.5308@nanos>
References: <1413385580-23317-1-git-send-email-marc.zyngier@arm.com>
 <54463C55.8010209@linaro.org> <20141021110728.GD15293@leverpostej>
 <54463FA2.4070506@linaro.org> <544E1F6E.5050704@arm.com>
 <alpine.DEB.2.11.1410272129170.5308@nanos>
Message-ID: <544EBE99.6080300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 09:30 PM, Thomas Gleixner wrote:
> On Mon, 27 Oct 2014, Marc Zyngier wrote:
>> Hi Daniel,
>>
>> On 21/10/14 12:12, Daniel Lezcano wrote:
>>> On 10/21/2014 01:07 PM, Mark Rutland wrote:
>>>> Hi Daniel,
>>>>
>>>> On Tue, Oct 21, 2014 at 11:58:29AM +0100, Daniel Lezcano wrote:
>>>>> On 10/15/2014 05:06 PM, Marc Zyngier wrote:
>>>>>> Commit c387f07e6205 (clocksource: arm_arch_timer: Discard unavailable
>>>>>> timers correctly) changed the way the driver makes sure both the memory
>>>>>> and system-register timers have been probed before finalizing the probing.
>>>>>>
>>>>>> There is a interesting flaw in this logic that leads to this final step
>>>>>> never to be executed. Things seems to work pretty well until something
>>>>>> actually needs the data that is produced during this final stage.
>>>>>>
>>>>>> For example, KVM explodes on the first run of a guest when executed on
>>>>>> a platform that has both memory and sysreg nodes (Juno, for example).
>>>>>>
>>>>>> Just fix the damned logic, and enjoy booting VMs again.
>>>>>>
>>>>>> Tested on a Juno system.
>>>>>>
>>>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>>>> Reported-by: Riku Voipio <riku.voipio@linaro.org>
>>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>>> ---
>>>>>
>>>>> Applied to my tree. Also for -next.
>>>>
>>>> Is this going to hit -rc2? This was a regression introduced in -rc1.
>>>>
>>>> Without this fix we've also lost our high precision sched_clock on arm64
>>>> platforms.
>>>>
>>>
>>> Sure.
>>>
>>> Thomas or Ingo,
>>>
>>> is it possible to update the tip/urgent branch, so I can send the fixes
>>> against 3.18-rc1 ?
>>
>> Any update on this? -rc2 has landed, but arm/arm64 timers are still in a
>> rather bad shape. Can this please be merged as an urgent fix?
>
> Daniel, timers/urgent is on rc1 already. Please send your pull request.

Hi Thomas,

This pull request for one patch contains a fix for ARM/ARM64 platform:

  * Marc Zyngier fixed the probe logic for the ARM architected timers.

Thanks

   -- Daniel


The following changes since commit 59aa896db80479dec29f471a7ca2b9eeeeb7d38e:

   ARM/ARM64: arch-timer: fix arch_timer_probed logic (2014-10-26 
20:50:00 +0100)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git 
clockevents/3.18-fixes

for you to fetch changes up to 59aa896db80479dec29f471a7ca2b9eeeeb7d38e:

   ARM/ARM64: arch-timer: fix arch_timer_probed logic (2014-10-26 
20:50:00 +0100)





-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
