From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Nov 2014 13:55:51 +0100
Subject: IRQ #0 broken on ARM
In-Reply-To: <CALT56yP6WCnPR3y7-WGzKGS9y+tieR1JUt0wkvOgCPHUy7QVmg@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Sat, 22 Nov 2014 16:40:13
 +0400")
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
 <20141121110135.GS4042@n2100.arm.linux.org.uk>
 <546F1F45.7080103@arm.com> <87egsw5jen.fsf@free.fr>
 <CAL_JsqL50EAmcrM=mcLRwa0OwnhnnXx6ZFzkgfybfQ49ROn7zA@mail.gmail.com>
 <871tov5sz0.fsf@free.fr>
 <CALT56yP6WCnPR3y7-WGzKGS9y+tieR1JUt0wkvOgCPHUy7QVmg@mail.gmail.com>
Message-ID: <87wq6n4co8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

>>> Perhaps use NR_IRQS_LEGACY here.
>> Ah yes, good idea.
>
> What about using NUM_ISA_INTERRUPTS? This would be logical
> if viper & zeus were converted to call irq_domain_add_legacy_isa.
That would make include/mach/irqs.h depend on include/linux/irqdomain.h.

That's something that makes me fell uneasy, as this irqs.h could be very well
used in assembler files, and I must check it.

On the other hand, NR_IRQS_LEGACY is defined in include/asm/irq.h, and that one
looks a better candidate for inclusion in mach/irqs.h.

Cheers.

-- 
Robert
