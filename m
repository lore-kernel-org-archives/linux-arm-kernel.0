From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 17 Jul 2012 14:58:12 -0400 (EDT)
Subject: [PATCH] [RFC] arm: add documentation describing Marvell families
 of SoC
In-Reply-To: <alpine.LFD.2.02.1207171115161.9293@xanadu.home>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201207171509.30509.arnd@arndb.de>
 <alpine.LFD.2.02.1207171115161.9293@xanadu.home>
Message-ID: <alpine.LFD.2.02.1207171452250.9293@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jul 2012, Nicolas Pitre wrote:

> On Tue, 17 Jul 2012, Arnd Bergmann wrote:
> 
> > On Tuesday 17 July 2012, Thomas Petazzoni wrote:
> > > As stated in the introduction of the document, the families of ARM
> > > SoCs at Marvell are very complicated, and it is difficult for
> > > newcomers to understand the organization of this SoC family and how it
> > > relates to the Linux kernel support for those hardware platforms.
> > > 
> > > This document is only at RFC stage for now, it requires reviews and
> > > comments from the Marvell maintainers, the PXA maintainers and the MMP
> > > maintainers. For correctness of course, but also to add any other
> > > information that would be useful. For example, one of the thing that
> > > wasn't clear how to detail in the documentation is how the SoCs relate
> > > to each other in terms of hardware IP blocks. For example, most of the
> > > Kirkwood/Dove/Armada 370-XP/etc. hardware IPs (I2C, SPI, USB, SATA,
> > > etc.) are identical, while the PXA and MMP families are completely
> > > separate.
> > 
> > This is wonderful! Even if there are some pieces missing or incorrect,
> > it looks extremely valuable. I remember countless times of browsing
> > through the marvell web site and the source code trying to make sense
> > of how things fit together.
> > 
> > Thanks a lot for compiling the list!
> 
> Absolutely!
> 
> I think I have an old list that was compiled by Lennert.  I'll try to 
> dig it out in case this document could benefit from it.

Here's what I've dug out. This is dated October 2007.

----- >8

family			out of order			in order
==============================================================================
no mmu		|				|			     |
no cache	|	Falcon			|	Falcon D	     |
"966"		|				|	a.k.a. Dragonite     |
==============================================================================
no mmu		|				|			     |
cache		|	Osprey			|	Osprey D	     |
"946"		|				|			     |
==============================================================================
		|	single issue: Mohawk	|			     |
mmu		|	a.k.a. Feroceon 1850	|			     |
cache		|	a.k.a. Feroceon FR-331	|	single issue:	     |
"926"		|				|	Mohawk D	     |
		|	dual issue: Jolteon	|			     |
		|	a.k.a. Feroceon 2850	|			     |
==============================================================================

Variants:
- Falcon DMC - Multi-Core version of the Falcon D
- Falcon DMT - Multi-Thread version of the Falcon D
- Osprey DMT - Multi-Thread version of Osprey D

There is also the Flareon, which is what will be used in Dove:
- Based on the Jolteon
- v6/v7 support
- packaged with L2, VFP, AXI

All of these cores can be mixed-and-matched with L2, VFP, AXI, wMMXt,
etc.
