From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 May 2014 12:23:26 +0200
Subject: [PATCH v3 06/20] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <20140506153953.GF25849@saruman.home>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-7-git-send-email-gregory.clement@free-electrons.com>
 <20140506153953.GF25849@saruman.home>
Message-ID: <20140507122326.54f3febc@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Felipe Balbi,

On Tue, 6 May 2014 10:39:53 -0500, Felipe Balbi wrote:

> >  config USB_EHCI_HCD
> > diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> > index 7530468c9a4f..7a8db7f7dc01 100644
> > --- a/drivers/usb/host/Makefile
> > +++ b/drivers/usb/host/Makefile
> > @@ -19,6 +19,7 @@ xhci-hcd-$(CONFIG_PCI)	+= xhci-pci.o
> >  
> >  ifneq ($(CONFIG_USB_XHCI_PLATFORM), )
> >  	xhci-hcd-y		+= xhci-plat.o
> > +	xhci-hcd-$(CONFIG_USB_XHCI_MVEBU)	+= xhci-mvebu.o
> 
> hmm, this has the potential of resulting in:
> 
> 	xhci-hcd-m += xhci-mvebu.o
> 
> I guess it's best to turn this into:
> 
> ifneq ($(CONFIG_USB_XHCI_PLATFORM), )
> 	xhci-hcd-y += xhci-mvebu.o
> endif

I guess you meant:

ifneq ($(CONFIG_USB_XHCI_MVEBU), )
	xhci-hcd-y += xhci-mvebu.o
endif

Right?

If so, then what about instead making CONFIG_USB_XHCI_MVEBU a bool
instead of a tristate? It's more an option for the xhci-platform
driver than an additional separate module, IMO. What do you think?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
