From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 3 May 2012 03:24:50 +0000
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201205011555.48430.marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <201205010549.34309.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B7C53C@039-SN2MPN1-023.039d.mgd.msft.net>
 <201205011555.48430.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B874F8@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> Still use IRQF_SHARED for the usb interrupt, but:
> * The IRQ handler in ehci-mxs, that's set in hc_driver.irq would be
> always
> returning IRQ_NONE.
> * The IRQ handler in imx-otg would call the callback registered via
> imx_otg_set_irq_handler() only if the port was actually in host mode
> 
The interrupt which is registered by hcd core is usb_hcd_irq, it will call
ehci_irq. The hc_driver.irq is included in usb_hcd_irq. 
