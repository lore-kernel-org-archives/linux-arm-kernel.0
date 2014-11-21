From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Nov 2014 11:17:25 +0000
Subject: IRQ #0 broken on ARM
In-Reply-To: <20141121110135.GS4042@n2100.arm.linux.org.uk>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
 <20141121110135.GS4042@n2100.arm.linux.org.uk>
Message-ID: <546F1F45.7080103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 21/11/14 11:01, Russell King - ARM Linux wrote:
> On Fri, Nov 21, 2014 at 10:52:37AM +0000, Marc Zyngier wrote:
>> On Fri, Nov 21 2014 at 10:31:05 am GMT, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>>> Hello,
>>>
>>> After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
>>> (ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
>>> on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).
>>
>> Well, this is a valid IRQ number if you're not using irq domains. I may
>> be a bit pedantic here, but I thing this is an important distinction.
> 
> Linus has decreed it to not be a valid IRQ number, and that's basically
> the end of the discussion.  Generic code, and drivers, will increasingly
> decide that IRQ0 is not valid, and objecting to it has, and will continue
> to elicit a response of "fix ARM".

I'm fine with that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
