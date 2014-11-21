From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 22 Nov 2014 02:20:35 +0400
Subject: IRQ #0 broken on ARM
In-Reply-To: <87egsw5jen.fsf@free.fr>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
 <20141121110135.GS4042@n2100.arm.linux.org.uk>
 <546F1F45.7080103@arm.com> <87egsw5jen.fsf@free.fr>
Message-ID: <CALT56yM3Dh-gBZPPa+cETX6W50iPudZUMW8r_64ES6U7kBBhNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-22 0:32 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Marc Zyngier <marc.zyngier@arm.com> writes:
>>> Linus has decreed it to not be a valid IRQ number, and that's basically
>>> the end of the discussion.  Generic code, and drivers, will increasingly
>>> decide that IRQ0 is not valid, and objecting to it has, and will continue
>>> to elicit a response of "fix ARM".
>>
>> I'm fine with that.
> For pxa, why not do something like that [1] ?
>
> Cheers.
>
> --
> Robert
>
> [1]
> ---8>---
>
> From 551eaf75934bd84939a40781470ed3c04d17507a Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Fri, 21 Nov 2014 22:11:42 +0100
> Subject: [PATCH] ARM: pxa: arbitrarily set first interrupt number
>
> As IRQ0, the legacy timer interrupt should not be used as an interrupt
> number, shift the interrupts by a fixed number.
>
> As we had in a special case a shift of 16 when ISA bus was used on a
> PXA, use that value as the first interrupt number, regardless of ISA or
> not.

This will shift the issue from PXA_SSP3 interrupt to ISA IRQ0.
On the other hand ISA IRQs are used only on viper and zeus boards.
And those boards explicitly mark IRQ0 as unused (because it is not
routed through CPLD).

I have another question. As for me, those "ISA" interrupts being placed
in front of PXA interrupts look like some kind of legacy stuff. Do we
still require for "ISA" (well, PC/104) interrupts to be the first ones?


-- 
With best wishes
Dmitry
