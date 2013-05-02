From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 02 May 2013 21:39:24 +0200
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <5182BFC6.3070709@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130502185322.GA29333@obsidianresearch.com>
 <201305022111.41043.arnd@arndb.de> <5182BFC6.3070709@gmail.com>
Message-ID: <5182C0EC.7040008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2013 09:34 PM, Sebastian Hesselbarth wrote:
> On 05/02/2013 09:11 PM, Arnd Bergmann wrote:
>> On Thursday 02 May 2013, Jason Gunthorpe wrote:
>>>> +static struct of_device_id orion_irq_dt_ids[] __initconst = {
>>>> + { .compatible = "marvell,orion-mpic", .data = orion_of_init },
>>>> + { }
>>>
>>> Is there a strong reason to change the compatible string? Looks to me
>>> like either the new driver or the old driver will bind depending on
>>> what is in the machine description. No need for a new string?
>>>
>>
>> The compatible string should change if the binding changes in an
>> incomptible way, and we should try not to change it unless it's
>> fundamentally flawed.
>
> Well, there is no _fundamental_ change in the binding syntax as it
> is only reg, interrupts, and clocks. But there is a semantic change
> in reg properties, as current orion irq controller wants the mask
> registers (0x04,0x08) only while this also needs cause register
> (0x00).
>
> Nothing that couldn't be handled while moving Orion arch to irqchip
> but if there are no further objections, I'd like to stick with the new
> compatible string - also having orion-spic in mind.

Taking Jason Gunthorpe's last reply, I will stick to the _old_
compatible string and name the bridge irq handler as Jason suggested.

I will send a v2 soon.

Sebastian
