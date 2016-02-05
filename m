From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 5 Feb 2016 16:32:02 +0100
Subject: [PATCH v2] clocksource/arm_arch_timer: Enable and verify MMIO
 access
In-Reply-To: <56B4BFC8.6050201@arm.com>
References: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
 <20160201195816.GL4848@codeaurora.org> <56B4BFC8.6050201@arm.com>
Message-ID: <56B4C072.3040409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2016 04:29 PM, Robin Murphy wrote:
> On 01/02/16 19:58, Stephen Boyd wrote:
>> On 02/01, Robin Murphy wrote:
>>> So far, we have been blindly assuming that having access to a
>>> memory-mapped timer frame implies that the individual elements of that
>>> frame frame are already enabled. Whilst it's the firmware's job to give
>>> us non-secure access to frames in the first place, we should not rely
>>> on implementations always being generous enough to also configure CNTACR
>>> for those non-secure frames (e.g. [1]).
>>>
>>> Explicitly enable feature-level access per-frame, and verify that the
>>> access we want is really implemented before trying to make use of it.
>>>
>>> [1]:https://github.com/ARM-software/tf-issues/issues/170
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>
>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>
> Great, thanks!
>
> Daniel, am I right in hoping this is something you'll pick up, or should
> I be resending it to arm-soc?

I will be reviewing timers patches next week. I will take care of this one.

Thanks
   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
