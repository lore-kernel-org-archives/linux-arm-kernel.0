From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 1 May 2012 03:36:37 +0000
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201205010521.14052.marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B7C3E3@039-SN2MPN1-023.039d.mgd.msft.net>
 <201205010521.14052.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B7C439@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > If the host and device interrupt handler are called by otg interrupt
> > handler, then, the interrupt handlers are registered by host/device
> will
> > be called twice as they are also registered by host/device themselves.
> 
> No they won't, I don't register them in ehci-mxs or ci13xxx-mxs anymore.
> 
Have you changed any hcd code? The host interrupt is registered by hcd
core code: usb_add_hcd.

> >
> > Besides, what kinds of function do you want to add at this patchset?
> 
> Device and Host mode, separate so far, configurable by platform data. I'm
> also
> looking into the OTG, but let's get this basic stuff right and mainline
> first.
> 
Then, the aim for this patchset is only enable OTG port, 
and device/host function is selected by platform data, 
no otg function(id switch) will be supported, correct?

Understanding your scope may help me review your patches.

 
> 
> Best regards,
> Marek Vasut
