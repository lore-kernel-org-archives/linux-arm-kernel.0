From: lznuaa@gmail.com (Zhi Li)
Date: Mon, 9 Feb 2015 08:48:55 -0600
Subject: coresignt etm/etb usage
In-Reply-To: <54D5BBB8.20905@gmail.com>
References: <CAHrpEqR0kPAPCvuFK0XdP9RTojH85xoATt1esbfGTCSPkPu0Tw@mail.gmail.com>
 <54D5BBB8.20905@gmail.com>
Message-ID: <CAHrpEqSMefBoSQpgfso9BJ3d2qg=uf2FhAJZQBV0UT_CUVw2Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 7, 2015 at 1:16 AM, Dirk Behme <dirk.behme@gmail.com> wrote:
> On 06.02.2015 22:56, Zhi Li wrote:
>>
>> mathieu:
>>
>> I try to enable etm/etb in our freescale platform.
>
>
>
> About which Freescale platform are you talking?
>
> I've tried using the patches for the Freescale i.MX6 some month ago. I've
> managed to get the nodes like below, too. But never managed to get the ETM
> tracing data into the ETB. Only with attached HW JTAG debugger trace data
> has been recorded. And I never figured out which additional configuration
> the HW JTAG is doing compared to the SW only solution.

Yes, i.MX6 have such errata. Need 6 JTAG clocks to enable ETM function.
we have a new chip. I try to check if new chip fix this issue.

But look like new coresight driver usage changed.

best regards
Frank Li

>
> Best regards
>
> Dirk
>
>
>> I have ported your patches into our tree.
>> coresign node already created in /sys/devices.
>>
>> 30041000.funnel  31001000.interrupt-controller  platform       software
>> 3007c000.etm     backlight.7                    regulators.10  system
>> 3007d000.etm     breakpoint                     replicator.1   timer.0
>> 30084000.etb     gpio-keys.9                    soc.2          virtual
>> 30087000.tpiu    max7322-reset.8                soc0
>>
>>
>> But my problem is how to test it.
>> Do you have document to show how to use it?
>>
>>
>> best regards
>> Frank Li
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
