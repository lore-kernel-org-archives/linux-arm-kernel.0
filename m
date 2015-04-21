From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 21 Apr 2015 15:37:17 -0500
Subject: [PATCH v5 07/11] ARM: imx: add msl support for imx7d
In-Reply-To: <CAL_Jsq+NV5Ok-P6JGZzNyQCD=PdwXbDY39XmwzKB0U+vuyHxVA@mail.gmail.com>
References: <1429628007-8892-1-git-send-email-Frank.Li@freescale.com>
 <1429628007-8892-8-git-send-email-Frank.Li@freescale.com>
 <20150421173110.GG10164@leverpostej>
 <CAHrpEqRAEMammfaovi6QQxGJfW-LZsgwg5rX4-3Y=+m6qhqeTg@mail.gmail.com>
 <CAL_Jsq+NV5Ok-P6JGZzNyQCD=PdwXbDY39XmwzKB0U+vuyHxVA@mail.gmail.com>
Message-ID: <CAHrpEqS5qQ7-0bEFEZ3tkeupL0cBU1aPiVnS5RWy=GBW9JAhWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 3:22 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Apr 21, 2015 at 1:51 PM, Zhi Li <lznuaa@gmail.com> wrote:
>> On Tue, Apr 21, 2015 at 12:31 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> +static void __init imx_ca7_smp_init_cpus(void)
>>>> +{
>>>> +       int i, ncores;
>>>> +       unsigned long val;
>>>> +
>>>> +       asm volatile("mrc p15, 1, %0, c9, c0, 2" : "=r" (val));
>>>> +       ncores = ((val >> 24) & 0x3) + 1;
>>>> +       if (setup_max_cpus < ncores)
>>>> +               ncores = (setup_max_cpus) ? setup_max_cpus : 1;
>>>> +
>>>> +       for (i = ncores; i < NR_CPUS; i++)
>>>> +               set_cpu_possible(i, false);
>>>> +}
>>>
>>> NAK.
>>>
>>> The set of available CPUs should come from the DT, as with other
>>> platforms.
>>
>> Can you give me a reference platform implement?
>
> All of the ones with no smp_operations.

Okay, I just remove it.

>
> Rob
