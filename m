From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 10 Dec 2013 23:07:18 +0800
Subject: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu possible/present
 maps and map logical cpu id to APIC id
In-Reply-To: <20131210125328.923F2C40A27@trevor.secretlab.ca>
References: <1385999094-3152-1-git-send-email-hanjun.guo@linaro.org> <
 1385999094-3152-3-git-send-email-hanjun.guo@linaro.org>
 <20131210125328.923F2C40A27@trevor.secretlab.ca>
Message-ID: <52A72E26.9080606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?10? 20:53, Grant Likely wrote:
> On Mon,  2 Dec 2013 23:44:47 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> When boot the kernel with MADT, the cpu possible and present maps should be
>> prefilled for cpu topology and acpi based cpu hot-plug.
>>
>> The logic cpu id maps to APIC id (GIC id) is also implemented, it is needed
>> for acpi processor drivers.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
> [...]
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index a0c2ca6..1428024 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -420,7 +420,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>   		if (err)
>>   			continue;
>>   
>> +#ifndef CONFIG_ACPI
>>   		set_cpu_present(cpu, true);
>> +#endif
>>   		max_cpus--;
>>   	}
>>   }
> This looks wrong. Will this break non-ACPI booting when CONFIG_ACPI is
> enabled? The decision on whether or not to run code must be made at
> runtime.

Yes, you are right. I'm reworking on this patch now.

Thanks
Hanjun
