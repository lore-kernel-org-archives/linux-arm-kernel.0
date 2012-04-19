From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Apr 2012 14:07:19 +0100
Subject: [PATCH v3 4/6] ARM: architected timers: add DT support
In-Reply-To: <201204191255.39952.arnd@arndb.de>
References: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
 <1334592810-4382-5-git-send-email-marc.zyngier@arm.com>
 <201204191255.39952.arnd@arndb.de>
Message-ID: <4F900E07.404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/12 13:55, Arnd Bergmann wrote:
> On Monday 16 April 2012, Marc Zyngier wrote:
>> Add runtime DT support and documentation for the Cortex A7/A15
>> architected timers.
>>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  .../devicetree/bindings/arm/arch_timer.txt         |   27 ++++++++++
>>  arch/arm/include/asm/arch_timer.h                  |    6 ++
>>  arch/arm/kernel/arch_timer.c                       |   53 +++++++++++++++++---
>>  3 files changed, 79 insertions(+), 7 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/arch_timer.txt
>>
> 
> This looks good, but do we actually still need the non-DT case?
> 
> Both vexpress and exynos5 allow booting through DT and we are not
> planning to add any new platforms with these timers that don't.

Yes, the non-DT code is a leftover from dark ages we'd rather forget.
I'll remove that code for the next iteration.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
