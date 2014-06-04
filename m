From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 4 Jun 2014 09:45:34 -0400
Subject: [PATCH] ARM: orion5x: fix mvebu_mbus_dt_init call
In-Reply-To: <7365244.alxTZQocGr@wuerfel>
References: <4280897.V3UkQjotOL@wuerfel>
 <20140604114006.476cef06@free-electrons.com>
 <7365244.alxTZQocGr@wuerfel>
Message-ID: <20140604134534.GC8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 12:36:49PM +0200, Arnd Bergmann wrote:
> On Wednesday 04 June 2014 11:40:06 Thomas Petazzoni wrote:
> > 
> > On Wed, 04 Jun 2014 11:06:40 +0200, Arnd Bergmann wrote:
> > > The prototype for mvebu_mbus_dt_init() changed around the same time
> > > as a new caller was added to orion5x. This adds the missing argument
> > > to make orion5x behave correctly to avoid this build error:
> > > 
> > > mach-orion5x/board-dt.c: In function 'orion5x_dt_init':
> > > mach-orion5x/board-dt.c:48:2: error: too few arguments to function 'mvebu_mbus_dt_init'
> > >   BUG_ON(mvebu_mbus_dt_init());
> > >   ^
> > > In file included from mach-orion5x/board-dt.c:18:0:
> > > include/linux/mbus.h:76:5: note: declared here
> > >  int mvebu_mbus_dt_init(bool is_coherent);
> > >      ^
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > 
> 
> Ok, thanks!
> 
> I've added my patch to the next/soc2 branch now, which already contains
> both branches that introduce the problem when combined.
> 
> This saves us creating a fixes branch on top of the mid-merge window
> state of torvalds/next.

Thanks, Arnd.  That was most likely my fault.  I also don't recall what
happened, but your fix is the correct one.  Thanks for catching that.

thx,

Jason.
