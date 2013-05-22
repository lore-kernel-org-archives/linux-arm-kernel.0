From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 May 2013 16:11:08 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522155218.1c2af492@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130522134336.GE18614@n2100.arm.linux.org.uk>
 <20130522155218.1c2af492@skate>
Message-ID: <201305221611.08823.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 May 2013, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
> 
> On Wed, 22 May 2013 14:43:36 +0100, Russell King - ARM Linux wrote:
> > On Wed, May 22, 2013 at 12:01:29PM +0200, Sebastian Hesselbarth wrote:
> > > I tried the above on Dove which is possibly affected by the workaround
> > > as it is also ARMv7. In Dove you can access unmapped addresses without
> > > any problems, but as Thomas already stated Armada 370/XP just hang.
> > > Must be some default AHB slave in Dove, which Armada 370/XP is missing.
> > 
> > It may be some clock setting somewhere on the 370/XP.  The Dove will hang
> > as well if you prod at peripherals which you've turned their clocks off.
> 
> The register in question (offset 0x20080 from the base address of the
> internal register) is part of the "core" registers, so I clearly don't
> see how the system could even be booting if this clock was gated. No?

It would hang if you add that offset to the wrong base address though.

	Arnd
