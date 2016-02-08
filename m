From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Feb 2016 14:09:25 +0000
Subject: [PATCH v2] clocksource/arm_arch_timer: Enable and verify MMIO
 access
In-Reply-To: <56B89F98.7020909@linaro.org>
References: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
 <56B89F98.7020909@linaro.org>
Message-ID: <56B8A195.2050807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/16 14:00, Daniel Lezcano wrote:
> On 02/01/2016 01:00 PM, Robin Murphy wrote:
>> So far, we have been blindly assuming that having access to a
>> memory-mapped timer frame implies that the individual elements of that
>> frame frame are already enabled. Whilst it's the firmware's job to give
>> us non-secure access to frames in the first place, we should not rely
>> on implementations always being generous enough to also configure CNTACR
>> for those non-secure frames (e.g. [1]).
>>
>> Explicitly enable feature-level access per-frame, and verify that the
>> access we want is really implemented before trying to make use of it.
>>
>> [1]:https://github.com/ARM-software/tf-issues/issues/170
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
> 
> Hi Marc,
> 
> can you give your opinion on this patch ?

This seems to do the right thing, so FWIW:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
