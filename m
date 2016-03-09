From: julien.grall@arm.com (Julien Grall)
Date: Wed, 9 Mar 2016 12:52:08 +0700
Subject: [PATCH v3 2/9] clocksource: arm_arch_timer: Extend
 arch_timer_kvm_info to get the virtual IRQ
In-Reply-To: <20160309032713.GF26583@lvm>
References: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
 <1457436573-6180-3-git-send-email-julien.grall@arm.com>
 <20160309032713.GF26583@lvm>
Message-ID: <56DFBA08.7060000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 09/03/2016 10:27, Christoffer Dall wrote:
> On Tue, Mar 08, 2016 at 11:29:26AM +0000, Julien Grall wrote:
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index b7ab588..d8887f3 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -701,6 +701,8 @@ static void __init arch_timer_common_init(void)
>>   	arch_timer_banner(arch_timers_present);
>>   	arch_counter_register(arch_timers_present);
>>   	arch_timer_arch_init();
>> +
>> +	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
>
> why is this in common_init and not just in init?

I thought we wanted to initialize virtual_irq for both the system 
registers timer and the memory timer. Although, as talked IRL, KVM 
mandates system registers timer. So I will initialize the virtual_irq in 
arch_timer_init.

Cheers,

-- 
Julien Grall
