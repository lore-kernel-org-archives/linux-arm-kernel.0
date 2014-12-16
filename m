From: richard@nod.at (Richard Weinberger)
Date: Tue, 16 Dec 2014 11:21:13 +0100
Subject: at91: smc configuration using DT
In-Reply-To: <54900622.3030103@atmel.com>
References: <548F6514.1040706@sigma-star.at> <2463675.Tt7GDs0rfe@wuerfel>
 <548F6A71.30304@nod.at> <54900622.3030103@atmel.com>
Message-ID: <54900799.2020804@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.12.2014 um 11:14 schrieb Nicolas Ferre:
> Le 16/12/2014 00:10, Richard Weinberger a ?crit :
>> Am 15.12.2014 um 23:56 schrieb Arnd Bergmann:
>>> On Monday 15 December 2014 23:47:48 Richard Weinberger wrote:
>>>>
>>>> I'm sure I'm missing something.
>>>>
>>>> One of my boards is still using board files and uses sam9_smc_configure() to
>>>> setup NAND timings. I'd like to convert it to DT but I fail to see how to configure the smc.
>>>> What is the device tree equivalent of sam9_smc_configure()?
>>>>
>>>>
>>>
>>> I think it's actually missing, see the series "memory: add Atmel EBI
>>> (External Bus Interface) driver" from Boris Brezillon.
>>
>> Thanks a lot for your quick reply, Arnd!
>>
>> arch/arm/mach-at91/board-stamp9g20.c was removed by:
>>
>> commit fb3642ebb52cfab8eaa52fea677abec4d92182a0
>> Author: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Date:   Wed Nov 19 10:30:41 2014 +0100
>>
>>     ARM: at91: remove at91sam9260/at91sam9g20 legacy boards files
>>
>>     Remove old board files that use at91sam9260 or at91sam9g20 Atmel SoCs. The
>>     device tree is mature on these SoCs. It must be used now.
>>
>>     Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> How can this DT work for my board without proper NAND timings?
>>
>> If I need Boris's patch set first I consider commit fb3642ebb a bit rude as it breaks
>> things.
>>
>> *confused*,
>> //richard
> 
> Richard,
> 
> This action was announced several months ago on the at91.com forum and
> on this mailing-list: https://lkml.org/lkml/2014/9/10/293
> Please read this announce message for more background.
> Moreover, 3.19 is scheduled mid-february. It was also offered to help
> during this transition period... So I would not call it "rude".

I got access to this board a week ago. =)

> Yes, it definitively breaks things. But as noted by Arnd, we are
> actively working on a clean solution.

I'm glad to hear that.

> In the meantime, you have the possibility to configure the SMC with
> proper NAND timings in the bootloader(s).

Yeah, that will work!

Thanks,
//richard
