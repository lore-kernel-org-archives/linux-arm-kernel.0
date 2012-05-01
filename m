From: marex@denx.de (Marek Vasut)
Date: Tue, 1 May 2012 15:55:48 +0200
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B7C53C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <201205010549.34309.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B7C53C@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <201205011555.48430.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > Well, let's fix it in V8. I suggest we do a stub handler in the ehci-mxs
> > for
> > usb_add_hcd() and call ehci_irq() from the imx-otg's IRQ handler like
> > it's
> > already done in this patchset.
> 
> I have not understood how you would like to do?

Still use IRQF_SHARED for the usb interrupt, but:
* The IRQ handler in ehci-mxs, that's set in hc_driver.irq would be always 
returning IRQ_NONE.
* The IRQ handler in imx-otg would call the callback registered via 
imx_otg_set_irq_handler() only if the port was actually in host mode

> 
> > But this patchset also works with the host-only port #1 on mx28
> > (obviously, you
> > can't enable gadget(device) mode for that port).
> 
> Currently, there is not generic PHY driver, so only one PHY can be
> supported at runtime, and only one controller can be enabled if you have
> used PHY driver.

Correct

> How can you let otg and host 1 work together with your patchset?

Sorry for not being clear enough, what I mean was that this patchset supports:
* Port0 in both Device and Host mode (separately, configured via platform data)
* Port1 in Host mode
And that Port0 and Port1 can NOT be enabled at the same time, so the above is 
mutually exclusive.

> > > Understanding your scope may help me review your patches.
> > > 
> > > > Best regards,
> > > > Marek Vasut
> > 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
