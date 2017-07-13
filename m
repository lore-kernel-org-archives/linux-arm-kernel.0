From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 13 Jul 2017 11:16:12 +0100
Subject: [PATCH 2/6] irqchip/tango: Use irq_gc_mask_disable_and_ack_set
In-Reply-To: <13014560-e6a5-85b4-1f76-b83e9c44879d@sigmadesigns.com> (Marc
 Gonzalez's message of "Wed, 12 Jul 2017 14:34:06 +0200")
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-3-opendmb@gmail.com>
 <13014560-e6a5-85b4-1f76-b83e9c44879d@sigmadesigns.com>
Message-ID: <yw1x7ezctzf7.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> Hello,
>
> I've added Mans (the code's author) to the recipient list.
>
> Regards.
>
> On 07/07/2017 21:20, Doug Berger wrote:
>
>> From: Florian Fainelli <f.fainelli@gmail.com>
>> 
>> Any usage of the irq_gc_mask_disable_reg_and_ack() function should be
>> replaced with either the irq_gc_mask_disable_and_ack_set() or the
>> irq_gc_mask_set_and_ack_set() function depending on which corrects
>> the bugs in irq_gc_mask_disable_reg_and_ack() for a given usage.
>> 
>> For the Tango irqchip driver, irq_gc_mask_disable_and_ack_set() seems to
>> be what is intended, so use it.
>> 
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Doug Berger <opendmb@gmail.com>

As I said elsewhere, this looks more correct although I haven't tested it.

Acked-by: Mans Rullgard <mans@mansr.com>

>> ---
>>  drivers/irqchip/irq-tango.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
>> index bdbb5c0ff7fe..0c085303a583 100644
>> --- a/drivers/irqchip/irq-tango.c
>> +++ b/drivers/irqchip/irq-tango.c
>> @@ -141,7 +141,7 @@ static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
>>  	for (i = 0; i < 2; i++) {
>>  		ct[i].chip.irq_ack = irq_gc_ack_set_bit;
>>  		ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
>> -		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_reg_and_ack;
>> +		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
>>  		ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
>>  		ct[i].chip.irq_set_type = tangox_irq_set_type;
>>  		ct[i].chip.name = gc->domain->name;
>> 
>

-- 
M?ns Rullg?rd
