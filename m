From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Dec 2016 18:43:33 +0000
Subject: [PATCH V8 3/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <1481653317.29291.19.camel@perches.com>
References: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
 <1480460259-8585-4-git-send-email-agustinv@codeaurora.org>
 <b009635d-8a10-5e22-4438-0019d79d01d3@arm.com>
 <78bfd90d47200347628f7dd98451122f@codeaurora.org>
 <1481653317.29291.19.camel@perches.com>
Message-ID: <413b214c-146e-a1ca-7e84-6fc96959d7c7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/16 18:21, Joe Perches wrote:
> On Tue, 2016-12-13 at 10:23 -0500, Agustin Vega-Frias wrote:
>> On 2016-12-07 13:16, Marc Zyngier wrote:
>>>> +	}
>>>> +
>>>> +	combiner->domain = irq_domain_create_linear(
>>>> +		pdev->dev.fwnode, combiner->nirqs, &domain_ops, combiner);
>>>
>>> On a single line, please. Do no listen to the checkpatch police that
>>> will tell you otherwise. It really hurt my eyes to see this opening
>>> bracket and *nothing* after that.
>>
>> Will do.
> 
> It seems generally preferred to have at least one argument on the
> same line as the function being called.
> 
> So, here are some options:
> 
> Maximally fill the lines to 80 columns with the value being set
> and function call while aligning to open parenthesis
> 
> 	combiner->domain = irq_domain_create_linear(pdev->dev.fwnode,
> 						    combiner->nirqs,
> 						    &domain_ops, combiner);

I can live with something like this.

> Use a separate line for the function call:
> 
> 	combiner->domain =
> 		irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
> 					 &domain_ops, combiner);

But I find this one pretty horrid.

> Or just ignore the 80 column limit wherever you deem appropriate.

Which is my usual advise. I consider the 80 column rule a good way of
limiting the complexity of code (if the nesting pushes you too far on
the right of the screen, you're doing something wrong), but not for
simple statements such as this one.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
