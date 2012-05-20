From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 May 2012 12:10:25 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205201058.38144.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205192042140.13185@xanadu.home>
 <20120520095502.GB25344@n2100.arm.linux.org.uk>
 <201205201058.38144.arnd@arndb.de>
Message-ID: <20120520111025.GC25344@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2012 at 10:58:37AM +0000, Arnd Bergmann wrote:
> On Sunday 20 May 2012, Russell King - ARM Linux wrote:
> > And try to avoid putting anything in the include/mach/ directory which
> > isn't needed by any code outside of arch/arm/{plat,mach}-* directory.
> > 
> > In other words, headers needed only for code in arch/arm/plat-mvvebu/
> > should be in that very same directory.
> 
> Ok, so let me make sure I got it all right:
> 
> * all *.c files that are used for multiple boards go to plat-mvebu
> * all *-setup.c files go to mach-mvebu
> * only headers that are used outside of {mach,plat}-mvebug go to
>   plat-mvebu/include/mach
> * headers used to inteface between the first two go to
>   plat-mvebu/include/plat (?)

That sounds reasonable.  The only eyebrow raising thing is having an
include/mach inside a plat-* directory... that seems an odd way to do
things as mach/ includes normally come from the mach-* directory.

So I wonder whether Nicolas' idea of "dt-only stuff in arch/arm/plat-*"
is the right idea.  It just makes plat-* the same as a mach-* but with
a different name, whereas it is _supposed_ to be for stuff shared
between a bunch of mach-* directories.
