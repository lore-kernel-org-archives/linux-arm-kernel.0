From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 12:36:49 +0200
Subject: [PATCH] ARM: orion5x: fix mvebu_mbus_dt_init call
In-Reply-To: <20140604114006.476cef06@free-electrons.com>
References: <4280897.V3UkQjotOL@wuerfel>
 <20140604114006.476cef06@free-electrons.com>
Message-ID: <7365244.alxTZQocGr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014 11:40:06 Thomas Petazzoni wrote:
> 
> On Wed, 04 Jun 2014 11:06:40 +0200, Arnd Bergmann wrote:
> > The prototype for mvebu_mbus_dt_init() changed around the same time
> > as a new caller was added to orion5x. This adds the missing argument
> > to make orion5x behave correctly to avoid this build error:
> > 
> > mach-orion5x/board-dt.c: In function 'orion5x_dt_init':
> > mach-orion5x/board-dt.c:48:2: error: too few arguments to function 'mvebu_mbus_dt_init'
> >   BUG_ON(mvebu_mbus_dt_init());
> >   ^
> > In file included from mach-orion5x/board-dt.c:18:0:
> > include/linux/mbus.h:76:5: note: declared here
> >  int mvebu_mbus_dt_init(bool is_coherent);
> >      ^
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 

Ok, thanks!

I've added my patch to the next/soc2 branch now, which already contains
both branches that introduce the problem when combined.

This saves us creating a fixes branch on top of the mid-merge window
state of torvalds/next.

	Arnd
