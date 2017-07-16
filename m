From: slash.tmp@free.fr (Mason)
Date: Sun, 16 Jul 2017 23:29:27 +0200
Subject: [PATCH] irqchip/gic: Use GIC_SPI symbolic constant
In-Reply-To: <86h8ycytse.fsf@arm.com>
References: <e25e0ac5-abe2-6024-f669-c5352183114e@free.fr>
 <86shhwywas.fsf@arm.com> <d0701807-74fb-f54e-ccff-378c15da076e@free.fr>
 <86h8ycytse.fsf@arm.com>
Message-ID: <8e73ee16-4470-2f37-2486-42f9095b1736@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2017 23:08, Marc Zyngier wrote:

> Mason wrote:
>
>> On 16/07/2017 22:13, Marc Zyngier wrote:
>>
>>> Mason wrote:
>>>
>>>> Use GIC_SPI explicitly instead of an implicit 0.
>>>
>>> What bug is this fixing? What benefit does this bring?
>>
>> The patch aims to replace an (implicit) literal constant
>> with the corresponding symbolic macro. IMO, it makes the
>> intent somewhat clearer, and, more importantly, grepping
>> for said symbol now returns the respective file/line.
>> (It took me a while to find the line.)
>>
>> Are you saying that changing the code at this point is
>> not worth the trouble?
> 
> You're assuming that this GIC_SPI macro has anything to do with the GIC
> driver. It doesn't. That's just a convenience macro for people writing
> DT, and definitely not something I'd ever want to rely on in the Linux
> driver. The binding defines the raw value, and not this macro.

AFAIU, you're referring to
Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
"The 1st cell is the interrupt type;
0 for SPI interrupts, 1 for PPI interrupts."

Doesn't it make sense to have symbolic constants for
the 0 and 1 above? In linux/irqchip/arm-gic.h ?

IIUC, headers in include/dt-bindings are just convenience
macros, and are not to be included from driver code?

Regards.
