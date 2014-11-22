From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 22 Nov 2014 16:40:13 +0400
Subject: IRQ #0 broken on ARM
In-Reply-To: <871tov5sz0.fsf@free.fr>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
 <20141121110135.GS4042@n2100.arm.linux.org.uk>
 <546F1F45.7080103@arm.com> <87egsw5jen.fsf@free.fr>
 <CAL_JsqL50EAmcrM=mcLRwa0OwnhnnXx6ZFzkgfybfQ49ROn7zA@mail.gmail.com>
 <871tov5sz0.fsf@free.fr>
Message-ID: <CALT56yP6WCnPR3y7-WGzKGS9y+tieR1JUt0wkvOgCPHUy7QVmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-22 15:18 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Rob Herring <robherring2@gmail.com> writes:
>
>>>  #ifdef CONFIG_PXA_HAVE_ISA_IRQS
>>
>> You can get rid of this ifdef and kconfig symbol. It is only used here.
> Right.
>
>>> -#define PXA_IRQ(x)     (PXA_ISA_IRQ_NUM + (x))
>>> +#define PXA_IRQ(x)     (16 + (x))
>>
>> Perhaps use NR_IRQS_LEGACY here.
> Ah yes, good idea.

What about using NUM_ISA_INTERRUPTS? This would be logical
if viper & zeus were converted to call irq_domain_add_legacy_isa.

-- 
With best wishes
Dmitry
