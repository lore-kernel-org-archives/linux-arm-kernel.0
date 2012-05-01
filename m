From: marex@denx.de (Marek Vasut)
Date: Tue, 1 May 2012 05:21:13 +0200
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B7C3E3@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B7C3E3@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201205010521.14052.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > V7: * Pass only necessary data to the drivers registered by imx-otg
> > 
> >       (memory, irq, pointer to imx-otg device). This should fix issue
> > 
> > pointed
> > 
> >       out by Lothar Wassmann.
> >     
> >     * Have single IRQ handler in imx-otg, which then calls host/gadget
> > 
> > IRQ
> > 
> >       handlers only if they're registered via imx_otg_set_irq_handler()
> > 
> > call,
> > 
> >       depending on the current state of the OTG.
> 
> Hi Marek,
> 
> If the host and device interrupt handler are called by otg interrupt
> handler, then, the interrupt handlers are registered by host/device will
> be called twice as they are also registered by host/device themselves.

No they won't, I don't register them in ehci-mxs or ci13xxx-mxs anymore.

> 
> Besides, what kinds of function do you want to add at this patchset?

Device and Host mode, separate so far, configurable by platform data. I'm also 
looking into the OTG, but let's get this basic stuff right and mainline first.

> device-only?host-only? basic otg (id switch)? power management (As I have
> seen you add wakeup interrupt handler)?

There is a stub wakeup handler right now, we don't do powermanagement yet.

Peter, thanks for reviewing these :)

Best regards,
Marek Vasut
