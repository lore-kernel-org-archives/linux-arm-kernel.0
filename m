From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 May 2012 10:58:37 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120520095502.GB25344@n2100.arm.linux.org.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205192042140.13185@xanadu.home>
 <20120520095502.GB25344@n2100.arm.linux.org.uk>
Message-ID: <201205201058.38144.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 20 May 2012, Russell King - ARM Linux wrote:
> On Sat, May 19, 2012 at 08:45:03PM -0400, Nicolas Pitre wrote:
> > On Sat, 19 May 2012, Arnd Bergmann wrote:
> > 
> > > On Saturday 19 May 2012, Jason Cooper wrote:
> > > > > Board files in mach-mvebu and the rest in plat-mvebu.  That would match 
> > > > > the spirit of the current split between mach-* and plat-*.
> > > > 
> > > > Took the words right out of my mouth.  Once DT conversions are complete,
> > > > mach-*/ would either go away, or hold legacy non-DT boards.
> > > > 
> > > > On a side note, I also like this because it would make converting old
> > > > board files like sheevaplug and guruplug to DT easier.  The legacy
> > > > implementation would be in mach-mvebu/ and the DT implementation would
> > > > be in plat-mvebu/.  Newcomers to the code would see a clearly defined
> > > > separation.
> > > 
> > > With that layout, where do the mach/* headers go?
> > 
> > I think arch/arm/plat-mvvebu/include/mach/* could work.
> 
> And try to avoid putting anything in the include/mach/ directory which
> isn't needed by any code outside of arch/arm/{plat,mach}-* directory.
> 
> In other words, headers needed only for code in arch/arm/plat-mvvebu/
> should be in that very same directory.

Ok, so let me make sure I got it all right:

* all *.c files that are used for multiple boards go to plat-mvebu
* all *-setup.c files go to mach-mvebu
* only headers that are used outside of {mach,plat}-mvebug go to
  plat-mvebu/include/mach
* headers used to inteface between the first two go to
  plat-mvebu/include/plat (?)

	Arnd
