From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 Jun 2015 16:08:45 +0100
Subject: [PATCH v2 1/3] arm64: kernel: rename __cpu_suspend to keep it
 aligned with arm
In-Reply-To: <20150618145505.GE31480@e104818-lin.cambridge.arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-2-git-send-email-sudeep.holla@arm.com>
 <20150618145505.GE31480@e104818-lin.cambridge.arm.com>
Message-ID: <5582DEFD.8070106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/06/15 15:55, Catalin Marinas wrote:
> On Thu, Jun 18, 2015 at 03:41:32PM +0100, Sudeep Holla wrote:
>> This patch renames __cpu_suspend to cpu_suspend so that it's aligned
>> with ARM32. It also removes the redundant wrapper created.
>>
>> This is in preparation to implement generic PSCI system suspend using
>> the cpu_{suspend,resume} which now has the same interface on both ARM
>> and ARM64.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/include/asm/cpuidle.h | 8 ++------
>>   arch/arm64/include/asm/suspend.h | 2 +-
>>   arch/arm64/kernel/cpuidle.c      | 4 ++--
>>   arch/arm64/kernel/psci.c         | 2 +-
>>   arch/arm64/kernel/suspend.c      | 6 +++---
>>   5 files changed, 9 insertions(+), 13 deletions(-)
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Does this patch depend on the other patches from Mark and Lorenzo or it
> can be merged earlier?
>

Though it's independent patch, I think it will conflict with Mark's
changes. But since all the ARM64 related changes in that series are
already in ARM64 for-next/core, it applies cleanly on it and I even gave
it a quick testing. So it can be merged earlier if you are fine with that.

Regards,
Sudeep
