From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 08 Dec 2014 11:18:48 +0000
Subject: [PATCH 1/5] genirq: Add irqchip_set_wake_parent
In-Reply-To: <b3d72e4d562eb4f1e21a8c4953a6c12b@agner.ch>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
 <1417873576-10463-2-git-send-email-marc.zyngier@arm.com>
 <b3d72e4d562eb4f1e21a8c4953a6c12b@agner.ch>
Message-ID: <54858918.2030007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/14 15:34, Stefan Agner wrote:
> Thanks for the CC, interesting read for me, good preparation for the
> next revision of my Vybrid patchset. One thing I stumbled upon below:
> 
> On 2014-12-06 14:46, Marc Zyngier wrote:
>> This proves to be usefull with stacked domains.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  include/linux/irq.h |  1 +
>>  kernel/irq/chip.c   | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index 8badf34..7de85b8 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -459,6 +459,7 @@ extern void irq_chip_eoi_parent(struct irq_data *data);
>>  extern int irq_chip_set_affinity_parent(struct irq_data *data,
>>  					const struct cpumask *dest,
>>  					bool force);
>> +extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
>>  #endif
>>  
>>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 6f1c7a5..96c190b 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -948,6 +948,22 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
>>  
>>  	return -ENOSYS;
>>  }
>> +
>> +/**
>> + * irq_chip_set_wake - Set/reset wake-up on the parent interrupt
>                        ^
> This should be irq_chip_set_wake_parent I guess...

Good call.

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
