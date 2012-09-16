From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 15 Sep 2012 19:40:04 -0600
Subject: [PATCH V5 2/5] ARM: bcm2835: add interrupt controller driver
In-Reply-To: <20120915183338.GJ12245@n2100.arm.linux.org.uk>
References: <1347690093-16910-1-git-send-email-swarren@wwwdotorg.org>
 <1347690093-16910-2-git-send-email-swarren@wwwdotorg.org>
 <20120915094543.GH12245@n2100.arm.linux.org.uk>
 <5054B708.5050005@wwwdotorg.org>
 <20120915183338.GJ12245@n2100.arm.linux.org.uk>
Message-ID: <50552DF4.5090906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2012 12:33 PM, Russell King - ARM Linux wrote:
> On Sat, Sep 15, 2012 at 11:12:40AM -0600, Stephen Warren wrote:
>> On 09/15/2012 03:45 AM, Russell King - ARM Linux wrote:
>>> On Sat, Sep 15, 2012 at 12:21:30AM -0600, Stephen Warren wrote:
>>>> +static struct irq_chip armctrl_chip = {
>>>> +	.name = "ARMCTRL-level",
>>>> +	.irq_mask = armctrl_mask_irq,
>>>> +	.irq_unmask = armctrl_unmask_irq
>>>> +};
>>>
>>> Might we want to enable CONFIG_GENERIC_IRQ_SHOW_LEVEL ?
>>
>> That sounds like a good idea. I'll patch that in locally without
>> reposting unless anyone has an objection to this.
> 
> Just to be clear, I think that's something that we should enable ARM-wide,
> not on a per-machine or per-SoC basis.

Yes, I see that makes sense, since CONFIG_PPC is the only place that
selects CONFIG_GENERIC_IRQ_SHOW_LEVEL right now.
