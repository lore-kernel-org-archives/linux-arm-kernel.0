From: marex@denx.de (Marek Vasut)
Date: Tue, 1 May 2012 05:49:34 +0200
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B7C439@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <201205010521.14052.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B7C439@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201205010549.34309.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > > If the host and device interrupt handler are called by otg interrupt
> > > handler, then, the interrupt handlers are registered by host/device
> > 
> > will
> > 
> > > be called twice as they are also registered by host/device themselves.
> > 
> > No they won't, I don't register them in ehci-mxs or ci13xxx-mxs anymore.
> 
> Have you changed any hcd code? The host interrupt is registered by hcd
> core code: usb_add_hcd.

I pass 0 as IRQ, thinking about it, that's not really correct (it's actually 
very lame mistake).

Well, let's fix it in V8. I suggest we do a stub handler in the ehci-mxs for 
usb_add_hcd() and call ehci_irq() from the imx-otg's IRQ handler like it's 
already done in this patchset.

> 
> > > Besides, what kinds of function do you want to add at this patchset?
> > 
> > Device and Host mode, separate so far, configurable by platform data. I'm
> > also
> > looking into the OTG, but let's get this basic stuff right and mainline
> > first.
> 
> Then, the aim for this patchset is only enable OTG port,
> and device/host function is selected by platform data,
> no otg function(id switch) will be supported, correct?

Correct.

But this patchset also works with the host-only port #1 on mx28 (obviously, you 
can't enable gadget(device) mode for that port).

> Understanding your scope may help me review your patches.
> 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
