From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 17:40:37 +0200
Subject: [PATCH] [RFC] arm: add documentation describing Marvell
 families of SoC
In-Reply-To: <201207171509.30509.arnd@arndb.de>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201207171509.30509.arnd@arndb.de>
Message-ID: <20120717174037.0b7e9a79@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 17 Jul 2012 15:09:29 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> > This document is only at RFC stage for now, it requires reviews and
> > comments from the Marvell maintainers, the PXA maintainers and the
> > MMP maintainers. For correctness of course, but also to add any
> > other information that would be useful. For example, one of the
> > thing that wasn't clear how to detail in the documentation is how
> > the SoCs relate to each other in terms of hardware IP blocks. For
> > example, most of the Kirkwood/Dove/Armada 370-XP/etc. hardware IPs
> > (I2C, SPI, USB, SATA, etc.) are identical, while the PXA and MMP
> > families are completely separate.
> 
> This is wonderful! Even if there are some pieces missing or incorrect,
> it looks extremely valuable. I remember countless times of browsing
> through the marvell web site and the source code trying to make sense
> of how things fit together.
> 
> Thanks a lot for compiling the list!

You're welcome. Marvell engineers did the initial work, I added the
datasheet links, plus the PXA/MMP families.

> I would also mention that the core in this is "Feroceon", not just
> that it's ARMv5. Same for mv78xx0 and kirkwood.

Added.

> > +        PXA930, PXA935, PXA955
> > +             Core: ARMv5 compatible Sheeva core
> 
> This looks wrong. According to the Kconfig file, PXA93x actually uses
> the same core as PXA3xx, while PXA955 uses an ARMv7 PJ4 core.

Right. I shouldn't believe Wikipedia, it seems. According to
http://en.wikipedia.org/wiki/XScale#PXA930.2F935 :

""The PXA930 and PXA935 processor series were built using an
architecture developed by Marvell,[7] instead of using an Xscale or ARM
design. This design, called the Sheeva core,[8] is ARM-compliant.""

> > +MMP/MMP2 family (communication processor)
> > +-----------------------------------------
> > +             Core: ARMv5 compatible Marvell PJ1 (Mohawk)
> > +        MMP2, a.k.a Armada 610
> > +             Product Brief        :
> > http://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
> > +             Core: ARMv7 compatible Sheeva PJ4 core
> > +   Linux kernel directory: arch/arm/mach-mmp
> 
> I'd also like to bring up the question of merging the pxa and mmp
> directories again. It would simplify the task of building a
> multiplatform kernel significantly as they have shared device drivers
> with some duplicate header files (e.g. dma, gpio, ...).

I obviously can't comment on this.

It would however be really nice to have comments on the document from
the PXA/MMP people, because for now it has just been written based on
some quick reading of Kconfig files and random stuff on the web.

Also, any clues on how to make it clearly appear that the
Dove/Discovery/Kirkwood/Armada-370-XP families are completely separate
from the PXA/MMP/MMP2 families? I was thinking, for each family, to
list the device drivers that are actually being used for the different
IPs of the SoCs, but I don't know if it is actually useful or not.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
