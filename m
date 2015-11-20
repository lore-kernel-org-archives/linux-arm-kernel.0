From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Nov 2015 18:02:09 +0000
Subject: [PATCH 03/10] dt-bindings: interrupt-controllers: add description
 of SIC1 and SIC2
In-Reply-To: <564F5DF8.7040908@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
 <1447982925-30138-4-git-send-email-vz@mleia.com>
 <20151120165835.GA17916@rob-hp-laptop> <564F5DF8.7040908@mleia.com>
Message-ID: <564F6021.7090000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/15 17:52, Vladimir Zapolskiy wrote:
> Hi Rob,
> 
> On 20.11.2015 18:58, Rob Herring wrote:
>> On Fri, Nov 20, 2015 at 03:28:38AM +0200, Vladimir Zapolskiy wrote:
>>> NXP LPC32xx has three interrupt controllers, namely root Main
>>> Interrupt Controller (MIC) and two supplementary Sub Interrupt
>>> Controllers (SIC1 and SIC2), four interrupt outputs from SIC1 and SIC2
>>> are connected to MIC.
>>>
>>> Also the change describes two additional optional properties:
>>> * interrupt-controller-name - human readable name of an interrupt
>>>   controller,
>>
>> Why? compatible is human readable. If you don't like that, then put the 
>> string in the driver.
> 
> in runtime I'd like to differentiate various IRQ chips by name. Here for
> example I have one compatible "*-sic" and two actual IRQ chips SIC1 and
> SIC2. If I read /proc/interrupts or /sys/kernel/debug/irq_domain_mapping
> I would prefer to visualize interrupts from SIC1 and SIC2.
> 
> I understand that this property is not hardware specific, but there are
> plenty of similar properties like "label" etc. Probably renaming of the
> property may help?

You can always generate the name based on the probing order or the address.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
