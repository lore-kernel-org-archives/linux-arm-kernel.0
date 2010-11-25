From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 25 Nov 2010 10:37:16 -0500 (EST)
Subject: [PATCH v2 2/3] ARM: cns3xxx: Add architecture definition for
	EHCI/OHCI controller
In-Reply-To: <20101125135614.GA22212@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.44L0.1011251031220.22247-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Nov 2010, Anton Vorontsov wrote:

> On Thu, Nov 25, 2010 at 09:51:23PM +0800, Lin Mac wrote:
> > 2010/11/25 Anton Vorontsov <cbouatmailru@gmail.com>:
> > > On Thu, Nov 25, 2010 at 03:25:38PM +0800, Lin Mac wrote:
> > > [...]
> > >> > ??#include <linux/module.h>
> > >> > ??#include <linux/io.h>
> > >> > ??#include <linux/delay.h>
> > >> > +#include <asm/atomic.h>
> > >> It's not necessary for mach/pm.h already included it, right?
> > >
> > > Technically, it's not necessary. But in Linux we don't rely on
> > > headers including other headers.

Just saw this.  Don't be ridiculous -- this happens all over the place.  
People generally aren't aware of it, because it's next to impossible to
verify that all the headers needed by a source file are included
directly.

In fact, there are many cases where it would be considered a _mistake_ 
not to rely on a nested include.  For example, include/linux/spinlock.h 
itself includes many other files which should not be included directly.

> > >  Think that someday mach/pm.h
> > > may not include asm/atomic.h, so the build will break.

Then whoever breaks the build by changing the header file will be
obliged to fix it.

Alan Stern
