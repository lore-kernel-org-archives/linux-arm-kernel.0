From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 May 2012 19:30:04 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205152135.26759.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515173909.383a0d8a@skate> <201205151626.49173.arnd@arndb.de>
 <201205152135.26759.arnd@arndb.de>
Message-ID: <20120516173004.GA12741@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 09:35:26PM +0000, Arnd Bergmann wrote:
> On Tuesday 15 May 2012, Arnd Bergmann wrote:
> 
> > Another way would be to reorganize those directories upfront:
> > 
> > plat-orion -> mach-orion
> > mach-*/*.c -> mach/orion/*/*.c
> > mach-*/include/mach/* -> mach-orion/include/mach/*.h
> > 
> > and then go from there. The differences between the headers are fairly
> > small already, so that should be manageable.
> 
> Actually we could do a trivial move of all files into one directory at any
> time, e.g. at the end of the merge window, to minimize conflicts with
> other patches.
> 
> This is a semi-automated move of all plat-orion based machines into
> a single mach-orion directory, and we could of course add the new stuff
> in there as well. I've specifically tried to keep this move simple,
> even if that means a lot of the easy cleanups for code that are mostly
> identical are not done here. Cleanups after this could come one at
> a time to reduce this duplication and simplify the platform.
> 
> Obvious next steps are to merge the various Makefile and Kconfig files
> as well as all the headers, and to actually allow building stuff together.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It boots on my kirkwood QNAP TS109P+ and all the devices seem present
and correct.

Tested-by: Andrew Lunn <andrew@lunn.ch>

   Andrew
