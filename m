From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 20 Jun 2011 17:05:20 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <201106202209.35152.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1106201704340.2113-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Arnd Bergmann wrote:

> On Monday 20 June 2011 20:39:02 Alan Stern wrote:
> > On Mon, 20 Jun 2011, Alexander Holler wrote:
> > 
> > > I see it that way: packed is needed to be sure that at least for struct 
> > > ehci_regs there are no padding bytes inbetween the members.
> > 
> > But is it really needed?
> 
> No. When the structure is marked packed, it's broken because it relies
> on undefined behavior. If it's not packed, there is no problem.
> 
> > > It might 
> > > work without, but that depends on the compiler (-version, architecture, 
> > > whatever).
> > 
> > Have there ever been any combinations of compiler, version, 
> > architecture, whatever, that had unwanted padding bytes in this 
> > structure?
> 
> Only on compilers that are not able to build Linux kernels anyway.

Just as I thought.  There's no reason to accept the proposed patch; 
we're fine the way we are now.

Alan Stern
