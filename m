From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 17 Jul 2012 11:45:08 -0400 (EDT)
Subject: [PATCH] [RFC] arm: add documentation describing Marvell families
 of SoC
In-Reply-To: <201207171509.30509.arnd@arndb.de>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201207171509.30509.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1207171115161.9293@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jul 2012, Arnd Bergmann wrote:

> On Tuesday 17 July 2012, Thomas Petazzoni wrote:
> > As stated in the introduction of the document, the families of ARM
> > SoCs at Marvell are very complicated, and it is difficult for
> > newcomers to understand the organization of this SoC family and how it
> > relates to the Linux kernel support for those hardware platforms.
> > 
> > This document is only at RFC stage for now, it requires reviews and
> > comments from the Marvell maintainers, the PXA maintainers and the MMP
> > maintainers. For correctness of course, but also to add any other
> > information that would be useful. For example, one of the thing that
> > wasn't clear how to detail in the documentation is how the SoCs relate
> > to each other in terms of hardware IP blocks. For example, most of the
> > Kirkwood/Dove/Armada 370-XP/etc. hardware IPs (I2C, SPI, USB, SATA,
> > etc.) are identical, while the PXA and MMP families are completely
> > separate.
> 
> This is wonderful! Even if there are some pieces missing or incorrect,
> it looks extremely valuable. I remember countless times of browsing
> through the marvell web site and the source code trying to make sense
> of how things fit together.
> 
> Thanks a lot for compiling the list!

Absolutely!

I think I have an old list that was compiled by Lennert.  I'll try to 
dig it out in case this document could benefit from it.

> > +Orion family
> > +------------
> > +
> > +  Flavors:
> > +        88F5082
> > +        88F5181
> > +        88F5181L
> > +        88F5182
> > +        88F5281
> > +        88F6183
> > +  Core: ARMv5 compatible
> > +  Linux kernel directory: arch/arm/mach-orion5x
> > +  No public datasheets available.
> 
> I would also mention that the core in this is "Feroceon", not just that it's ARMv5.
> Same for mv78xx0 and kirkwood.

They're not all Feroceons.  Some of the core names were: Mohawk, 
Jolteon, Flareon, and even Orion might have been a core name initially.  
Possibly others I can't remember now.

> > +        PXA930, PXA935, PXA955
> > +             Core: ARMv5 compatible Sheeva core
> 
> This looks wrong. According to the Kconfig file, PXA93x actually uses the
> same core as PXA3xx, while PXA955 uses an ARMv7 PJ4 core.

Oh, and BTW Flareon is also a PJ4.


Nicolas
