From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 13 Oct 2017 12:25:12 +0100
Subject: [PATCH 1/2] irqdesc: Add function to identify percpu_devid irqs
In-Reply-To: <4e5aa92c-221a-fb85-3b8a-198c3067ece9@arm.com>
References: <1507891466-52292-1-git-send-email-julien.thierry@arm.com>
 <4e5aa92c-221a-fb85-3b8a-198c3067ece9@arm.com>
Message-ID: <876c756d-93b8-8116-6708-2e70c4b0385b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/10/17 11:52, Marc Zyngier wrote:
> Hi Julien,
> 
> On 13/10/17 11:44, Julien Thierry wrote:
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   include/linux/irqdesc.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index 3e90a09..93960cf 100644
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -244,6 +244,14 @@ static inline int irq_is_percpu(unsigned int irq)
>>   	return desc->status_use_accessors & IRQ_PER_CPU;
>>   }
>>
>> +static inline int irq_is_percpu_devid(unsigned int irq)
>> +{
>> +	struct irq_desc *desc;
>> +
>> +	desc = irq_to_desc(irq);
>> +	return desc->status_use_accessors & IRQ_PER_CPU_DEVID;
>> +}
>> +
>>   static inline void
>>   irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
>>   {
>> --
>> 1.9.1
>>
> 
> Please write a proper commit message (for example explaining why
> irq_is_percpu is not necessarily the right thing). A cover letter also
> wouldn't hurt (that's pretty much customary if you send more than a
> single patch).
> 

Sorry, I'll do that.

Cheers,

-- 
Julien Thierry
