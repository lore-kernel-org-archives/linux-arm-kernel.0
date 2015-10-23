From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 23 Oct 2015 16:33:54 -0400 (EDT)
Subject: MUSB peripheral DMA regression caused by driver core runtime PM
 change
In-Reply-To: <20151023192044.GX3078@atomide.com>
Message-ID: <Pine.LNX.4.44L0.1510231629430.1644-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Oct 2015, Tony Lindgren wrote:

> > Thus the sequence of events should be:
> > 
> > 	Allocate the musb device;
> > 	Runtime-enable the omap2430 (since it is now safe to do so);
> > 	Runtime-enable the musb and declare it irq_safe (this will
> > 		automatically runtime-resume the omap2430);
> > 	Register the musb.
> > 
> > If things are done this way, no special action needs to be taken.
> 
> Yes good point, that requires changing the init for the whole
> drivers/musb though.

This will have to be done anyway, since the way it is now (if I 
understand correctly), the musb is registered and made available to 
userspace before its parent is operational (i.e., at full power).

> Also, we should reorganize the whole musb and make
> the platform glue and musb core drivers completely separate using a
> shared interrupt where needed.
> 
> For the regression for the -rc series? Do you see any better
> alternatives to what I posted?

No.

Alan Stern
