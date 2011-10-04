From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Oct 2011 13:33:47 +0100
Subject: [PATCH v4 06/10] ARM: SoC: convert Exynos4 to SoC descriptor
In-Reply-To: <CAH9JG2ULZgHbnVBcO-QTqsO9iMPjDWqF4S23YQYW6fcPRSQRYw@mail.gmail.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-7-git-send-email-marc.zyngier@arm.com>
	<CAH9JG2ULZgHbnVBcO-QTqsO9iMPjDWqF4S23YQYW6fcPRSQRYw@mail.gmail.com>
Message-ID: <4E8AFD2B.4040104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/11 12:01, Kyungmin Park wrote:
> On Tue, Oct 4, 2011 at 2:35 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Convert Exynos4 to use the SoC descriptor to provide its SMP
>> and CPU hotplug operations.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/mach-exynos4/core.h                |    9 +++++++++
>>  arch/arm/mach-exynos4/cpu.c                 |    8 ++++++++
>>  arch/arm/mach-exynos4/hotplug.c             |    8 +++++---
>>  arch/arm/mach-exynos4/mach-armlex4210.c     |    3 +++
>>  arch/arm/mach-exynos4/mach-nuri.c           |    3 +++
>>  arch/arm/mach-exynos4/mach-origen.c         |    3 +++
>>  arch/arm/mach-exynos4/mach-smdk4212.c       |    3 +++
>>  arch/arm/mach-exynos4/mach-smdkv310.c       |    4 ++++
>>  arch/arm/mach-exynos4/mach-universal_c210.c |    3 +++
>>  arch/arm/mach-exynos4/platsmp.c             |   25 +++++++++++++++++++++----
>>  10 files changed, 62 insertions(+), 7 deletions(-)
>>  create mode 100644 arch/arm/mach-exynos4/core.h
>>
>> diff --git a/arch/arm/mach-exynos4/core.h b/arch/arm/mach-exynos4/core.h
>> new file mode 100644
>> index 0000000..ba9fcc8
>> --- /dev/null
>> +++ b/arch/arm/mach-exynos4/core.h
>> @@ -0,0 +1,9 @@
> 
> It's helpful to add header guard
> 
> #ifndef __EXYNOS4_CORE_H
> #define __EXYNOS4_CORE_H

Yep, will add.

>> +#include <asm/soc.h>
>> +
>> +extern struct arm_soc_smp_init_ops     exynos4_soc_smp_init_ops;
>> +extern struct arm_soc_smp_ops          exynos4_soc_smp_ops;
>> +extern struct arm_soc_desc             exynos4_soc_desc;
>> +
>> +extern int  exynos4_cpu_kill(unsigned int cpu);
>> +extern void exynos4_cpu_die(unsigned int cpu);
>> +extern int  exynos4_cpu_disable(unsigned int cpu);
> #endif
> 
> Tested-by: Kyungmin Park <kyungmin.park@samsung.com>

Thanks for testing.

	M.
-- 
Jazz is not dead. It just smells funny...
