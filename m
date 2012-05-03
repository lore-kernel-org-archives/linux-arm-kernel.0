From: marex@denx.de (Marek Vasut)
Date: Thu, 3 May 2012 15:27:15 +0200
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B874F8@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <201205011555.48430.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B874F8@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <201205031527.16149.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chen Peter-B29397,

> > Still use IRQF_SHARED for the usb interrupt, but:
> > * The IRQ handler in ehci-mxs, that's set in hc_driver.irq would be
> > always
> > returning IRQ_NONE.
> > * The IRQ handler in imx-otg would call the callback registered via
> > imx_otg_set_irq_handler() only if the port was actually in host mode
> 
> The interrupt which is registered by hcd core is usb_hcd_irq, it will call
> ehci_irq. The hc_driver.irq is included in usb_hcd_irq.

Hm, that's correct. I'll dive in and see if there's any other way around. I 
think I saw IRQF_DISABLED somewhere there, but that might be just some phantom. 
Either way, is this direction I'm taking the correct one (have irq handler in 
imx-otg and send IRQs to gadget/host drivers from there)?

Also, any other comments about this patchset before I roll out another version?

Thanks!

Best regards,
Marek Vasut
