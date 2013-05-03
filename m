From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 20:43:42 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <2812721.61fsxKBgRj@wuerfel>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1500795.gEuGziRZET@wuerfel>
 <CACRpkdbDNoQSmFAyOMJRHSrnnuqpEfb0U9a7ZeaEztn1dAr_xA@mail.gmail.com>
 <2812721.61fsxKBgRj@wuerfel>
Message-ID: <CACRpkdaUKM1VzDhi3dMRh92XAYgg3KynvdmXKvCLfiCachP1EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 03 May 2013 16:06:57 Linus Walleij wrote:
>>
>> Not in my opinion but IIRC in 2008 or so some other
>> subsystem maintainer beat us up for not allowing it
>> to build on every other platform, and the rationale given
>> was that allowin this to build on e.g. x86_64 gives some
>> nice compile coverage.
>>
>> I don't know which argument wins
>
> I know that a certain other Linus frequently complains when ARM specific
> options show up on his x86 machine during "make oldconfig" ;-)

OK let's make it SoC-specific.

> One idea I had is to create a global CONFIG_SOC option that would
> hide all on-chip peripherals when building for a PC-like system.
> On ARM, we would always select CONFIG_SOC, except for a few special
> cases like ARCH_RPC, ARCH_FOOTBRIDGE and ARCH_SHARK.

Sounds like a deal. The AB chips aren't on-chip though
they sit on I2C or SPI actually. But they are still
strongly coupled with the SoC.

I just took a stroll around the premises and found this
Aardvark I2C/SPI "embedded systems interface".

This is a USB thing that makes it possible to connect
any I2C or SPI peripheral to the desktop ... I don't know how
such things should be used with Linux really, it seems like
it's something that normally gets used from userspace by
libusb but in theory we could have a kernel driver for this
and plug in whatever SoC I2C/SPI device into a desktop.

Whatever use it would be ... but could be useful for
developing drivers for a chip outside of the target
system I believe.

Yours,
Linus Walleij
