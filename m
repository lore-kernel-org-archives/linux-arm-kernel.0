From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 02 Sep 2015 18:17:36 +0100
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E722F2.50905@free.fr> (Mason's message of "Wed, 02 Sep 2015
 18:25:22 +0200")
References: <55E5CED8.7000408@free.fr> <55E5D945.3040504@gmail.com>
 <55E722F2.50905@free.fr>
Message-ID: <yw1xy4goyc3z.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 01/09/2015 18:58, Florian Fainelli wrote:
>
>> On 01/09/15 09:14, Mason wrote:
>>
>>> I'm trying to port to my ARM platform: IRQ handling code written for MIPS.
>>> https://github.com/mansr/linux-tangox/blob/master/drivers/irqchip/irq-tangox.c
>> 
>> Calling clear_c0_status() and write_c0_status() in tangox_irq_handler()
>> sounds like a layering violation here, this should be taken care of by
>> the interrupt code once proper parenting between the MIPS IRQ controller
>> and your tangox controller is established.
>
> Following Mans' suggestion, I deleted the arch-specific code, and
> the driver now compiles and links.
>
> Unfortunately, I still can't get it to work, and I've been banging
> my head against the wall over this device tree monstrosity.
>
> tangox_irq_init() fails in irq_of_parse_and_map()
>
> I see that
> irqchip_init is called
> gic_of_init is called
> but of_irq_parse_one(dev, index, &oirq) fails... :-(

Use the latest DT from my tree.  It looks like you're missing some
changes.

-- 
M?ns Rullg?rd
mans at mansr.com
