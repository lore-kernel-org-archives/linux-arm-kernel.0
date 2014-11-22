From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Nov 2014 13:18:27 +0100
Subject: IRQ #0 broken on ARM
In-Reply-To: <CAL_JsqL50EAmcrM=mcLRwa0OwnhnnXx6ZFzkgfybfQ49ROn7zA@mail.gmail.com>
 (Rob Herring's message of "Fri, 21 Nov 2014 16:27:35 -0600")
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
 <20141121110135.GS4042@n2100.arm.linux.org.uk>
 <546F1F45.7080103@arm.com> <87egsw5jen.fsf@free.fr>
 <CAL_JsqL50EAmcrM=mcLRwa0OwnhnnXx6ZFzkgfybfQ49ROn7zA@mail.gmail.com>
Message-ID: <871tov5sz0.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robherring2@gmail.com> writes:

>>  #ifdef CONFIG_PXA_HAVE_ISA_IRQS
>
> You can get rid of this ifdef and kconfig symbol. It is only used here.
Right.

>> -#define PXA_IRQ(x)     (PXA_ISA_IRQ_NUM + (x))
>> +#define PXA_IRQ(x)     (16 + (x))
>
> Perhaps use NR_IRQS_LEGACY here.
Ah yes, good idea.

I'll sent a proper patch next time, not an attached piece of code.

Cheers.

-- 
Robert
