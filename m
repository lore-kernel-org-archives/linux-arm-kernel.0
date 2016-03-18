From: fu.wei@linaro.org (Fu Wei)
Date: Fri, 18 Mar 2016 17:28:24 +0800
Subject: [PATCH v4 0/5] acpi, clocksource, kvm: add GTDT and ARM
 memory-mapped timer support
In-Reply-To: <CADyBb7snA3oGBiXfAuzsWemhGRQbw78SSUkhAe_6ufa+ajsiHA@mail.gmail.com>
References: <1458199917-30699-1-git-send-email-fu.wei@linaro.org>
 <56EAC832.6070203@codeaurora.org>
 <2196518.cd4jtVChuo@vostro.rjw.lan>
 <CADyBb7snA3oGBiXfAuzsWemhGRQbw78SSUkhAe_6ufa+ajsiHA@mail.gmail.com>
Message-ID: <CADyBb7tx=BvvuP1jLMMKug7jtUJV3gVkbvhUU3ZYvCeLfwUD6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 18 March 2016 at 12:22, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Rafael,
>
> Great thanks for your feedback!
>
> On 18 March 2016 at 08:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, March 17, 2016 10:07:30 AM Timur Tabi wrote:
>>> fu.wei at linaro.org wrote:
>>> > From: Fu Wei <fu.wei@linaro.org>
>>> >
>>> > This patchset:
>>> >      (1)Move some enums and marcos to header file for arm_arch_timer,
>>> >      improve the pr_* code by defining "pr_fmt(fmt)" in arm_arch_timer.c
>>> >
>>> >      (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>>> >      Parse all kinds of timer in GTDT table of ACPI:arch timer,
>>> >      memory-mapped timer and SBSA Generic Watchdog timer.
>>> >      This driver can help to simplify all the relevant timer drivers,
>>> >      and separate all the ACPI GTDT knowledge from them.
>>> >
>>> >      (3)Simplify ACPI code for arch timer in arm_arch_timer.c
>>> >
>>> >      (4)Add memory-mapped timer support in arm_arch_timer.c
>>>
>>> The SBSA watchdog driver is already in watchdog-next and will be merged
>>> into 4.6.  These five patches are necessary for the watchdog driver to
>>> probe on an ACPI system.
>>>
>>> I'm guessing since that v4 was posted in the middle of the 4.6 merge
>>> window, that these patches won't make it and we'll have to wait until
>>> 4.7 (at the earliest)?
>>
>> First off, the last version I've seen is the v3.  I must have overlooked
>> the v4 then, but I don't think it was CCed to linux-acpi (which should
>> have happened).
>
> Sorry for this, That is my fault. I updated the script of git-send-email for
> sending the v4 patchset, but lost a space between two "--cc". :-(

I have re-posted the v4 patchset:

https://lkml.org/lkml/2016/3/18/80

>
>>
>> Second, these patches require review from multiple maintainers and (or including)
>> people who actually know how the GTDT is supposed to be used.  I haven't
>> seen any responses from any of them yet, so the answer to your question is
>> "yes".
>>
>> I will have a couple of comments for patch [1/6] (in the v3), but it's
>> not been a priority due to the apparent overall lack of interest in this
>> series.
>
> Since this device is a generic  watchdog for ARM server, it is(will be) used
> in a lot of chips. So I think many people are interested in it. They
> haven't  provided
> any feedback, maybe due to my "--cc" mistake, or busy on something
> else now.  :-(
>
> I would like to learn your comments for patch [1/6] , then improve my
> v4, post v5
> ASAP.
>
> This patchset includes GTDT and memory-mapped timer patches, because my
> memory-mapped timer patches depends on GTDT.
> But maybe we can upstream GTDT separately?
>
> any suggestion?
>
> Thanks for your help!
>
>
>>
>> Thanks,
>> Rafael
>>
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
> Ph: +86 21 61221326(direct)
> Ph: +86 186 2020 4684 (mobile)
> Room 1512, Regus One Corporate Avenue,Level 15,
> One Corporate Avenue,222 Hubin Road,Huangpu District,
> Shanghai,China 200021



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
