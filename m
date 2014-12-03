From: stefan@agner.ch (Stefan Agner)
Date: Wed, 03 Dec 2014 18:32:22 +0100
Subject: [PATCH 04/12] irqchip: nvic: support routable irq domain ops
In-Reply-To: <4576226.8jDcZiCptE@wuerfel>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-5-git-send-email-stefan@agner.ch>
 <4576226.8jDcZiCptE@wuerfel>
Message-ID: <2586ebb42daf66877335adaad4b4d3e6@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-03 11:49, Arnd Bergmann wrote:
> On Wednesday 03 December 2014 01:12:03 Stefan Agner wrote:
>> +#ifdef CONFIG_ARM_NVIC
>> +extern const struct irq_domain_ops *nvic_routable_irq_domain_ops;
>> +static inline void __init register_routable_domain_ops
>> +                                       (const struct irq_domain_ops *ops)
>> +{
>> +               nvic_routable_irq_domain_ops = ops;
>> +}
>> +#endif /* CONFIG_ARM_NVIC */
>>
> 
> As you mentioned, this conflicts with the gic specific declaration.
> Why not remove the #ifdef here and rename the function to
> nvic_register_routable_domain_ops() ?
> 
> If that doesn't work, I guess we need something more generic
> and move the routable_irq_domain_ops to some common location.
> 

This would move the ifdef to the MSCM driver code. I thought of having a
generic function to call, no matter what base IRQ chip is used.

Anyway, as tglx suggested in patch 3/12, I will try to use the IRQ
domain hierarchy stuff...

--
Stefan
