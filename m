From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 25 Feb 2015 13:04:47 +0100
Subject: [PATCH v2 14/18] ARM: Add STM32 family machine
In-Reply-To: <1424468240.24292.5.camel@x220>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220200019.GU19388@pengutronix.de>
 <1424468240.24292.5.camel@x220>
Message-ID: <CALszF6CGT35V71QKTrDx+1Ltrctv5F7t8Zq6Tq15zn2bZGQXwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-20 22:37 GMT+01:00 Paul Bolle <pebolle@tiscali.nl>:
> On Fri, 2015-02-20 at 21:00 +0100, Uwe Kleine-K?nig wrote:
>> On Fri, Feb 20, 2015 at 07:01:13PM +0100, Maxime Coquelin wrote:
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 97d07ed..cfd9532 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -774,6 +774,28 @@ config ARCH_OMAP1
>> >     help
>> >       Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
>> >
>> > +config ARCH_STM32
>> > +   bool "STMicrolectronics STM32"
>> > +   depends on !MMU
>> > +   select ARCH_REQUIRE_GPIOLIB
>> > +   select ARM_NVIC
>> > +   select AUTO_ZRELADDR
>> > +   select ARCH_HAS_RESET_CONTROLLER
>> > +   select RESET_CONTROLLER
>> > +   select PINCTRL
>> > +   select PINCTRL_STM32
>> > +   select CLKSRC_OF
>> > +   select ARMV7M_SYSTICK
>> > +   select COMMON_CLK
>> > +   select CPU_V7M
>> > +   select GENERIC_CLOCKEVENTS
>> > +   select NO_DMA
>> > +   select NO_IOPORT_MAP
>> > +   select SPARSE_IRQ
>> > +   select USE_OF
>> Please sort this list alphabetically.
>
> And drop
>     select NO_DMA
>
> You copied that from ARCH_EFM32, but it's pointless on arm (as arch/arm/
> doesn't provide a NO_DMA Kconfig symbol).

You are right, I will drop NO_DMA in v3.

Thanks,
Maxime

>
> I submitted a patch last year to drop it from ARCH_EFM32, which Uwe
> Acked, but then nothing happened. I'm to blame, as I should have sent a
> reminder.
>
>> > +   help
>> > +     Support for STMicorelectronics STM32 processors.
>> > +
>> >  endchoice
>> >
>> >  menu "Multiple platform selection"
>
>
> Paul Bolle
>
