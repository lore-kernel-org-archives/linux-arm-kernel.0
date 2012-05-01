From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 1 May 2012 07:52:38 +0000
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201205010549.34309.marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <201205010521.14052.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B7C439@039-SN2MPN1-023.039d.mgd.msft.net>
 <201205010549.34309.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B7C53C@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> Well, let's fix it in V8. I suggest we do a stub handler in the ehci-mxs
> for
> usb_add_hcd() and call ehci_irq() from the imx-otg's IRQ handler like
> it's
> already done in this patchset.
> 
I have not understood how you would like to do?

 
> 
> But this patchset also works with the host-only port #1 on mx28
> (obviously, you
> can't enable gadget(device) mode for that port).
> 

Currently, there is not generic PHY driver, so only one PHY can be supported
at runtime, and only one controller can be enabled if you have used
PHY driver.

How can you let otg and host 1 work together with your patchset?

> > Understanding your scope may help me review your patches.
> >
> > > Best regards,
> > > Marek Vasut
> 
> Best regards,
> Marek Vasut
