From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 22 May 2015 16:56:04 +0100
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <CALszF6D-3pXHtyVMwhO0JkT-dCSSB98UNDHNN7-LD04Wdgd2cA@mail.gmail.com>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>	<15864413.ed8EFg1NLl@wuerfel>
 <CALszF6D-3pXHtyVMwhO0JkT-dCSSB98UNDHNN7-LD04Wdgd2cA@mail.gmail.com>
Message-ID: <555F5194.4040309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/15 16:29, Maxime Coquelin wrote:
> 2015-05-22 16:50 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> [one small request as I have four armv7-m folks on Cc already:
>>   could one of you try to fix the warning that I get with every
>>   single build: "/git/arm-soc/arch/arm/kernel/head-nommu.S: Assembler
>> messages: /git/arm-soc/arch/arm/kernel/head-nommu.S:167: Warning:
>> Use of r13 as a source register is deprecated when r15 is the
>> destination register."]
>
> Moving r13 to r12 and returning r12 seems to do the job (see below).
> But I don't know if there is a more elegant way, and if it is also
> valid for other architectures than armv7-m.

Why not just s/r13/r11/?

(works for me but I'm only working on single core system)
