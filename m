From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 14:21:05 -0700
Subject: [PATCH v5] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <5578C427.1070100@codeaurora.org>
References: <1428705191-15670-1-git-send-email-sboyd@codeaurora.org>
 <20150413134246.GS12732@n2100.arm.linux.org.uk>
 <557739AC.8000903@codeaurora.org>
 <20150610225744.GT7557@n2100.arm.linux.org.uk>
 <5578C427.1070100@codeaurora.org>
Message-ID: <55A971C1.8090308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 04:11 PM, Stephen Boyd wrote:
> On 06/10/2015 03:57 PM, Russell King - ARM Linux wrote:
>> diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
>> index 476092b86c6e..f2c4bf437ea7 100644
>> --- a/arch/arm/mach-shmobile/common.h
>> +++ b/arch/arm/mach-shmobile/common.h
>> @@ -13,7 +13,8 @@ extern void shmobile_smp_boot(void);
>>   extern void shmobile_smp_sleep(void);
>>   extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
>>   			      unsigned long arg);
>> -extern int shmobile_smp_cpu_disable(unsigned int cpu);
>> +extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
>> +extern void shmobile_invalidate_start(void);
>>
>> which your original patch did not include.  The tree I'm applying to
>> (-rc1) contains:
>>
>> extern int shmobile_smp_cpu_disable(unsigned int cpu);
>> extern void shmobile_invalidate_start(void);
>>
>> there.  Hence git quite rightfully declines to apply the patch.
>>
> Thanks. Fixed.
>

Sorry I just noticed that you applied 8392/1 instead of 8392/2 from the 
patch tracker. So shmobile_invalidate_start() came back.

I thought it would automatically supersede the previous patch but it 
looks like it just sticks around? I've never had to replace a patch 
before so I'll keep this in mind next time.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
