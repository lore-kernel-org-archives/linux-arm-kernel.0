From: vkale@apm.com (Vinayak Kale)
Date: Thu, 14 Nov 2013 16:01:53 +0530
Subject: [PATCH V2 1/2] genirq: Add an accessor for IRQ_PER_CPU flag
In-Reply-To: <528387CF.5090105@arm.com>
References: <1384340725-26073-1-git-send-email-vkale@apm.com>
 <1384340725-26073-2-git-send-email-vkale@apm.com>
 <528387CF.5090105@arm.com>
Message-ID: <CAPrCYke4fguxq5cxX5-NpSNH55d9BNCyDsFPouGrT7M+4t3SoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


On Wed, Nov 13, 2013 at 7:38 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Vinayak,
>
> On 13/11/13 11:05, Vinayak Kale wrote:
>> This patch adds an accessor function for IRQ_PER_CPU flag.
>> The accessor function is useful to dertermine whether an IRQ is percpu or not.
>>
>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>> ---
>>  include/linux/irqdesc.h |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index 56fb646..acd8a3f 100644
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -152,6 +152,14 @@ static inline int irq_balancing_disabled(unsigned int irq)
>>       return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
>>  }
>>
>> +static inline int irq_is_percpu(unsigned int irq)
>> +{
>> +     struct irq_desc *desc;
>> +
>> +     desc = irq_to_desc(irq);
>> +     return (desc && (desc->status_use_accessors & IRQ_PER_CPU)) ? 1 : 0;
>
> I don't think it is worth checking for the validity of "desc" here. All
> the other accessors assume that you've not passed a stupid "irq" value.
hmm..Okay, will remove the 'desc' validity check from here.
