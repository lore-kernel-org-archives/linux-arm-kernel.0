From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 23:00:46 +0800
Subject: [RFC part1 PATCH 2/7] ARM64 : Add dummy asm/cpu.h
In-Reply-To: <20131203171345.GC16025@e106331-lin.cambridge.arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-3-git-send-email-hanjun.guo@linaro.org>
 <20131203171345.GC16025@e106331-lin.cambridge.arm.com>
Message-ID: <529F439E.6070101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 01:13, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 04:36:46PM +0000, Hanjun Guo wrote:
>> ACPI requires a cpu.h, add a dummy one copied from arm. This will need
>> updated or replaced as ACPI based cpu hotplug for armv8 is worked out.
> What exactly requires cpu.h, and why?

CPI core will include this file and can not be compiled without it.

ACPI based CPU hotplug needs some functions below:
#ifdef CONFIG_HOTPLUG_CPU
extern int arch_register_cpu(int num);
extern void arch_unregister_cpu(int);
#endif

>
> Why copy the file verbatim rather than factoring it out?

ACPI based cpu hotplug is not implemented in this patch
set and will send out as drivers, so will factoring it
out at that time.
  

>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/cpu.h |   25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/cpu.h
>>
>> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
>> new file mode 100644
>> index 0000000..dbeb98d
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/cpu.h
>> @@ -0,0 +1,25 @@
>> +/*
>> + *  Copyright (C) 2004-2005 ARM Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef __ASM_ARM_CPU_H
>> +#define __ASM_ARM_CPU_H
>> +
>> +#include <linux/percpu.h>
>> +#include <linux/cpu.h>
>> +#include <linux/topology.h>
>> +
>> +struct cpuinfo_arm {
>> +	struct cpu	cpu;
>> +	u32		cpuid;
> We use a u64 elsewhere for the mpidr_el1 in arm64.

Good catch, will fix it

Thanks
Hanjun
