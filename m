From: cj.chengjian@huawei.com (chengjian (D))
Date: Tue, 5 Sep 2017 17:22:26 +0800
Subject: [PATCH] arm64: Convert pr_warning to standard pr_warn
In-Reply-To: <20170905091051.GA4401@leverpostej>
References: <1504578518-77544-1-git-send-email-cj.chengjian@huawei.com>
 <20170905091051.GA4401@leverpostej>
Message-ID: <12ad3ebb-191b-b753-a773-250b0992f1c2@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

OK, I will do it now



> On Tue, Sep 05, 2017 at 10:28:38AM +0800, chengjian c00427203 wrote:
>> Convert pr_warning to standard pr_warn in arch/arm64/kernel/smp.c
>>
>> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
>> ---
>>   arch/arm64/kernel/smp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> Is this a step towards removing pr_warning entirely?
>
> If so, can you please fix up all occurences in arm64? i.e.
>
> [mark at leverpostej:~/src/linux]% git grep pr_warning linux-next/master:arch/arm64
> linux-next/master:arch/arm64:include/asm/syscall.h:             pr_warning("%s called with max args %d, handling only %d\n",
> linux-next/master:arch/arm64:include/asm/syscall.h:             pr_warning("%s called with max args %d, handling only %d\n",
> linux-next/master:arch/arm64:kernel/hw_breakpoint.c:            pr_warning("unknown slot type: %d\n", type);
> linux-next/master:arch/arm64:kernel/hw_breakpoint.c:            pr_warning("attempt to read from unknown breakpoint register %d\n", n);
> linux-next/master:arch/arm64:kernel/hw_breakpoint.c:            pr_warning("attempt to write to unknown breakpoint register %d\n", n);
> linux-next/master:arch/arm64:kernel/hw_breakpoint.c:            pr_warning("invalid breakpoint privilege level %d\n", privilege);
> linux-next/master:arch/arm64:kernel/smp.c:              pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> linux-next/master:arch/arm64:kernel/smp.c:              pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
>
> Otherwise, I don't think it make sense to only fix some occurences.
>
> Thanks,
> Mark.
>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 9f7195a..efcaa05 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -972,7 +972,7 @@ void smp_send_stop(void)
>>   		udelay(1);
>>   
>>   	if (num_online_cpus() > 1)
>> -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
>> +		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
>>   			   cpumask_pr_args(cpu_online_mask));
>>   }
>>   
>> @@ -1009,7 +1009,7 @@ void crash_smp_send_stop(void)
>>   		udelay(1);
>>   
>>   	if (atomic_read(&waiting_for_crash_ipi) > 0)
>> -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
>> +		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
>>   			   cpumask_pr_args(&mask));
>>   }
>>   
>> -- 
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
>
