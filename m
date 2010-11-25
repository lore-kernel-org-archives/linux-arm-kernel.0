From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 25 Nov 2010 19:15:50 +0300
Subject: [PATCH v2 2/3] ARM: cns3xxx: Add architecture definition for
	EHCI/OHCI controller
In-Reply-To: <Pine.LNX.4.44L0.1011251031220.22247-100000@netrider.rowland.org>
References: <20101125135614.GA22212@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.44L0.1011251031220.22247-100000@netrider.rowland.org>
Message-ID: <20101125161550.GA2580@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 10:37:16AM -0500, Alan Stern wrote:
> > > 2010/11/25 Anton Vorontsov <cbouatmailru@gmail.com>:
> > > > On Thu, Nov 25, 2010 at 03:25:38PM +0800, Lin Mac wrote:
> > > > [...]
> > > >> > ??#include <linux/module.h>
> > > >> > ??#include <linux/io.h>
> > > >> > ??#include <linux/delay.h>
> > > >> > +#include <asm/atomic.h>
> > > >> It's not necessary for mach/pm.h already included it, right?
> > > >
> > > > Technically, it's not necessary. But in Linux we don't rely on
> > > > headers including other headers.
> 
> Just saw this.  Don't be ridiculous -- this happens all over the place.
> People generally aren't aware of it, because it's next to impossible to
> verify that all the headers needed by a source file are included
> directly.

Sure. But that doesn't mean we shouldn't try to keep these things
sane enough.

I just noticed that the patch introduced atomic_t usage, but didn't
include asm/atomic.h, so I corrected this before applying that patch.
So I don't see what's the fuss is about. :-)

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
