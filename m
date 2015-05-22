From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 22 May 2015 16:04:24 +0200
Subject: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
In-Reply-To: <555E559F.8040403@suse.de>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
 <555D1C7D.1060205@suse.de>
 <CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
 <555E1CC4.9090605@suse.de>
 <CALszF6Bhc1MkDaqM3oJ93Rrxxbsss7=FA8WUpbtwmDERUdD0KA@mail.gmail.com>
 <555E559F.8040403@suse.de>
Message-ID: <CALszF6BFXfjWhRgyejJHXMw+EJZUzT_7FtbKhnjS+DJS=vv11Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-22 0:01 GMT+02:00 Andreas F?rber <afaerber@suse.de>:
> Am 21.05.2015 um 21:57 schrieb Maxime Coquelin:
>> Note that for now, I still use your bootloader.
>> I have done the changes to reset the timers in the afboot-stm32.
>> That's the reason why I asked you under which licence it is delivered
>> few months ago.
>
> Sorry, too many mails... The stm32 one is GPL-2.0, as parts of it were
> derived from a U-Boot fork. (Personally I prefer GPL-2.0+; fm4 and
> xmc4000 are MIT/X11.)

Not a problem, thanks for providing the licence.

>> I can share you the patch if you want, even if I understand it is more
>> about the concept that you are reluctant.
>>
>> On my side, I plan to move to U-Boot soon, as Kamil Lulko added STM32
>> support in mainline [1].
>
> You're free to use any bootloader you like, but you will find it
> difficult to build in USB etc. drivers given the sheer size of U-Boot.
> That was my motivation for writing the tiny one. ;)

I think the two bootloaders make sense. Indeed, using U-Boot restricts
the size of the Kernel.
I also have the stm32429i-eval board, with 32MB NOR and 32MB SD-Ram.
At least on this one I will use U-Boot, as tftp could be used to load
Kernel since it has Ethernet port.

>> In case of U-Boot, the timer reset should be de-asserted when jumping
>> into the Kernel, as Rob mentionned [0].
>
> Thanks, I've updated the xmc4000 one accordingly and can do the same for
> stm32. But you are right that I consider that an ugly workaround,
> although on the other hand my earlyprintk patches also depend on the
> bootloader setting up GPIOs and UART.

Yes, the Kernel always need to rely on the bootloader to provide a
minimal setup (clock/ddr/muxing...).

Regards,
Maxime
