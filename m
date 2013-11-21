From: vkale@apm.com (Vinayak Kale)
Date: Thu, 21 Nov 2013 11:36:06 +0530
Subject: [PATCH V4 1/2] genirq: Add an accessor for IRQ_PER_CPU flag
In-Reply-To: <528CFC77.5050200@codeaurora.org>
References: <1384946021-22100-1-git-send-email-vkale@apm.com>
 <1384946021-22100-2-git-send-email-vkale@apm.com>
 <528CFC77.5050200@codeaurora.org>
Message-ID: <CAPrCYkefGMfweREk8bBKsO2VY4Tnc-fUZW8sw_K5ugRj5zJUFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 11:46 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 11/20/13 03:13, Vinayak Kale wrote:
>> This patch adds an accessor function for IRQ_PER_CPU flag.
>> The accessor function is useful to dertermine whether an IRQ is percpu or not.
>>
>> Signed-off-by: Vinayak Kale <vkale@apm.com>
>> ---
>
> This looks like a copy of Chris Smith's patch. Shouldn't Chris be the
> author and the commit text be whatever Chris sent?

In the cover letter of this patch series I did mention about Chris's
earlier patch. I didn't know his email-id earlier, have found the
mail-id now. CCing the mail-id to check whether it's still valid.

>
>>  include/linux/irqdesc.h |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index 56fb646..26e2661 100644
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
>> +     return desc->status_use_accessors & IRQ_PER_CPU;
>> +}
>> +
>>  static inline void
>>  irq_set_lockdep_class(unsigned int irq, struct lock_class_key *class)
>>  {
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
>
