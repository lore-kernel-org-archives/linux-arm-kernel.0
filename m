From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat, 27 Nov 2010 13:16:24 +0100 (CET)
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <AANLkTikkVqWgpYEg505DwQ+pSegQv1g-Q8cDEpE-JCrV@mail.gmail.com>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<AANLkTikkVqWgpYEg505DwQ+pSegQv1g-Q8cDEpE-JCrV@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1011271306420.7659@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 26 Nov 2010, Micha? Miros?aw wrote:

> 2010/11/20 Hans Ulli Kroll <ulli.kroll@googlemail.com>:
> > Add support for PCI Bus on Gemini Devices SL3516
> >
> > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> > ---
> [...]
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a19a526..5d4b398 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -307,6 +307,7 @@ config ARCH_GEMINI
> > ? ? ? ?select CPU_FA526
> > ? ? ? ?select ARCH_REQUIRE_GPIOLIB
> > ? ? ? ?select ARCH_USES_GETTIMEOFFSET
> > + ? ? ? select PCI
> > ? ? ? ?help
> > ? ? ? ? ?Support for the Cortina Systems Gemini family SoCs
> >
> [...]
> 
> I think it's better to add ARCH_GEMINI to CONFIG_PCI dependencies.
> AFAIK IB-4220B NAS does not use PCI and doesn't need all that code.
> Board support entries could select PCI if the board is useless without
> it.
> 

I know this, I have some.

There are many boards with PCI i.e WBD 222.
Other ARM devices uses the same select inside ARCH_*
I don't want to pollute drivers/pci/Kconfig.

Ulli
