From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 22 May 2012 10:25:28 -0400 (EDT)
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205211940.25488.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120521161131.GC24270@n2100.arm.linux.org.uk>
 <20120521165800.GR24238@titan.lakedaemon.net>
 <201205211940.25488.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1205221023050.13185@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 May 2012, Arnd Bergmann wrote:

> On Monday 21 May 2012, Jason Cooper wrote:
> > On Mon, May 21, 2012 at 05:11:31PM +0100, Russell King - ARM Linux wrote:
> > > On Mon, May 21, 2012 at 11:35:59AM -0400, Jason Cooper wrote:
> 
> > > I'd also suggest going against our current setup of not having "board/"
> > > subdirectories in mach-*.  Just name them board-foo.c.
> > 
> > This is what we are currently doing for boards in the midst of DT
> > conversion.  In mach-kirkwood/ there is board-dt.c, and
> > board-dreamplug.c.  board-dt.c is the DT code, while board-dreamplug.c
> > is board specific init code that hasn't been converted to DT yet.  Once
> > converted, board-dreamplug.c will disappear.  This follows what tegra is
> > doing.
> > 
> > We can leave the legacy, unconverted boards where they are
> > (mach-kirkwood/guruplug-setup.c), but what about the common code they
> > depend on (mpp.c, pcie.c, etc)?  That's what I was suggesting putting in
> > mach-mvebu/board/...
> 
> I like the idea of leaving the *-setup.c board files where they are,
> while moving all the other files (headers and the platform-wide .c
> files) to mach-mvebu.
> 
> However, given that we still don't have consensus on where things
> should really be and the merge window is already open, I would suggest
> don't try to do it all now for v3.5 but rather plan it for v3.6 once
> we agreed on one approach, and then do some of the next consolidation
> steps as well.

I'd suggest that mach-mvebu be created earlier for the new EBU ARmada 
SOC support though.


Nicolas
