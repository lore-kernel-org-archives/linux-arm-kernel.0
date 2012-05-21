From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 May 2012 07:58:14 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120521013050.GL24238@titan.lakedaemon.net>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120520111025.GC25344@n2100.arm.linux.org.uk>
 <20120521013050.GL24238@titan.lakedaemon.net>
Message-ID: <201205210758.14500.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 May 2012, Jason Cooper wrote:
> > > * all *.c files that are used for multiple boards go to plat-mvebu
> > > * all *-setup.c files go to mach-mvebu
> > > * only headers that are used outside of {mach,plat}-mvebug go to
> > >   plat-mvebu/include/mach
> 
> plat-mvebu/include/plat ?

Doesn't work because of the handful of places that #include <mach/*>
with a common name, like irqs.h or debug-macro.S.

> > > * headers used to inteface between the first two go to
> > >   plat-mvebu/include/plat (?)
> 
> plat-mvebu/include ?

That would still put them into a globally visible location since we
do gcc -I arch/arm/plat-${PLAT}/include.

> > That sounds reasonable.  The only eyebrow raising thing is having an
> > include/mach inside a plat-* directory... that seems an odd way to do
> > things as mach/ includes normally come from the mach-* directory.
> > 
> > So I wonder whether Nicolas' idea of "dt-only stuff in arch/arm/plat-*"
> > is the right idea.  It just makes plat-* the same as a mach-* but with
> > a different name, whereas it is supposed to be for stuff shared
> > between a bunch of mach-* directories.
> 
> In an ideal (dt) world, plat-*/ would hold all the dt source files, and
> arch/arm/boot/dts/ would become the new mach-*/.  mach-*/ is kept around
> for the few legacy, unconverted boards.
> 
> Or, am I barking up the wrong tree?

I think we're not likely to get there any time soon. Most platforms in fact
only have a mach-* directory at the moment and no plat-* directory.

	Arnd
