From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 Jul 2018 14:42:34 +0100
Subject: [PATCH 1/3] clocksource: drivers: set clockevent device cpumask
 to cpu_possible_mask
In-Reply-To: <2009eeb1-e925-fe5c-ac4a-9f3e41945127@linaro.org>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
 <2009eeb1-e925-fe5c-ac4a-9f3e41945127@linaro.org>
Message-ID: <229f0ac1-16b5-3fcf-3d0d-60ad59ea40f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 11/07/18 12:36, Daniel Lezcano wrote:
> On 11/07/2018 13:24, Sudeep Holla wrote:
>> Currently, quite a few clockevent devices have cpumask set to
>> cpu_all_mask which should be fine. However, cpu_possible_mask is more
>> accurate and if there are any other clockevent devices in the system
>> which have cpumask set to cpu_possible_mask, then having cpu_all_mask
>> may result in issues (mostly boot hang with forever loops in
>> clockevents_notify_released).
>>
>> So, lets replace all the clockevent device cpu_all_mask to
>> cpu_possible_mask in order to prevent above mentioned possible issue.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
> 
> Applied, thanks for the fix.
> 

Thomas was planning to take this, see [1]
-- 
Regards,
Sudeep

[1]
https://lore.kernel.org/lkml/alpine.DEB.2.21.1807102220320.1588 at nanos.tec.linutronix.de/
