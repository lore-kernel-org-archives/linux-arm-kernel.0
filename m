From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Aug 2012 14:16:03 +0000
Subject: [v3] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <20120819012303.GX22226@titan.lakedaemon.net>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120817152156.4d91ba16@skate> <20120819012303.GX22226@titan.lakedaemon.net>
Message-ID: <201208191416.03873.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 August 2012, Jason Cooper wrote:
> On Fri, Aug 17, 2012 at 03:21:56PM +0200, Thomas Petazzoni wrote:
> > Le Thu, 16 Aug 2012 14:37:08 -0400,
> > Jason Cooper <jason@lakedaemon.net> a ?crit :
> > 
> > > > Whole series applied to:
> > > > 
> > > > git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7
> > > 
> > > I'm getting the following build error with orion_nand enabled:
> > > 
> > >   CC      drivers/mtd/nand/orion_nand.o
> > > drivers/mtd/nand/orion_nand.c:24:27: fatal error: mach/hardware.h: No
> > > such file or directory
> > > compilation terminated.
> > 
> > Are you perhaps trying to enable the orion_nand driver for a mach-mvebu
> > platform (Armada 370 or XP)? If it's the case, then yes, this build
> > breakage is expected: we haven't enabled any of the I/O for now, so we
> > don't have hardware.h yet. This is not something that is broken due to
> > the address decoding changes.
> 
> Ok, I've added Arnd and Olof to the CC.  The above is exactly what I
> did.
> 
> Arnd, how extensive is the 'make randconfig' testing in next?  Is this
> something that needs to be fixed before we push?  I found it by a fluke,
> but the right randconfig would light it up as well.

If there is a bug you know about, you should fix it. In the above
example, I would guess that you should not actually need to include
mach/hardware.h, so the fix should be simple. In general, we should
eliminate mach/hardware.h where we can and put register locations
into resource, and offsets into the drivers themselves.

	Arnd
