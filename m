From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 May 2012 18:51:22 -0400 (EDT)
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205182044.26409.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205161552490.1640@xanadu.home>
 <20120518191832.GC24238@titan.lakedaemon.net>
 <201205182044.26409.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1205181846360.11526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2012, Arnd Bergmann wrote:

> On Friday 18 May 2012, Jason Cooper wrote:
> > > 
> > > In this case, we have wildly different names referring to the same chip 
> > > family, and "orion" is far from hinting that it also constitute the 
> > > support for Kirkwood, Dove or (some not all) Armadas, unless you are 
> > > familiar with some legacy Marvell products.  This is why in this case I 
> > > think that a directory name change might be appropriate, especially if 
> > > we're going to cause churn by moving things around already.
> > > 
> > > I agree that mrvl_ebu_* is not pretty.  This could be mv_ebu_* or 
> > > mvebu_*.  Unless someone has another logical identifier to suggest which 
> > > would capture all that family of SOCs that came out of EBU in Marvell of 
> > > course.
> > 
> > I prefer mvebu_* ...  nice and concise.
> > 
> 
> On a related topic, any preferences on where we will put all the board
> files? I think it would be helpful to put them into a separate place from
> the main platform files, so e.g. have all *-setup.c files go to
> arch/arm/mach-mvebu/board/*.c instead of arch/arm/mach-mvebu/*-setup.c
> 
> The reasons I think this would help are that the directory is getting a
> bit crowded when we move five or more of the current platforms in there,
> and that I hope we can start ignoring them for most practical purposes
> as some point in the future when all boards have been made to work with
> DT, and at an even later point we can just delete that directory.
> The main disadvantage that this approach would bring is that it's not
> consistent with what any of the other platforms do.

Board files in mach-mvebu and the rest in plat-mvebu.  That would match 
the spirit of the current split between mach-* and plat-*.

Nicolas
