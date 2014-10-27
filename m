From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Oct 2014 11:47:02 +0000
Subject: [PATCH 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <alpine.DEB.2.11.1410252136220.5308@nanos>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
 <1414232097-4328-2-git-send-email-marc.zyngier@arm.com>
 <alpine.DEB.2.11.1410252131110.5308@nanos>
 <alpine.DEB.2.11.1410252136220.5308@nanos>
Message-ID: <544E30B6.7060902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/14 20:42, Thomas Gleixner wrote:
> On Sat, 25 Oct 2014, Thomas Gleixner wrote:
> 
> Bah, hit send way too fast :)
> 
>> On Sat, 25 Oct 2014, Marc Zyngier wrote:
>>> +int irq_get_irqchip_state(unsigned int irq, int state)
> 
> get_state(state) does not make sense. get_state(which) probably more
> so. And 'which' wants to be an enum btw.
> 
>>> +	chip_bus_lock(desc);
>>> +	val = chip->irq_get_irqchip_state(data, state);
>>
>> Hmm. What's the irq_get_irqchip_state() callback supposed to return?
> 
> Either an error code or a boolean value, right? Does not mix very well
> I think. 
> 
> int irq_get_irqchip_state(unsigned int irq, enum xxx which, bool *val)
> 
> Might be a more clear interface.

Agreed, this makes a lot of sense. Will respin it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
