From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 May 2014 17:14:56 +0200
Subject: [PATCH v3 06/20] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <20140507151008.GD769@saruman.home>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <1399335255-589-7-git-send-email-gregory.clement@free-electrons.com>
 <20140506153953.GF25849@saruman.home>
 <20140507122326.54f3febc@free-electrons.com>
 <20140507151008.GD769@saruman.home>
Message-ID: <20140507171456.3124ec71@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Felipe Balbi,

On Wed, 7 May 2014 10:10:08 -0500, Felipe Balbi wrote:

> > ifneq ($(CONFIG_USB_XHCI_MVEBU), )
> > 	xhci-hcd-y += xhci-mvebu.o
> > endif
> > 
> > Right?
> 
> correct :-)
> 
> > If so, then what about instead making CONFIG_USB_XHCI_MVEBU a bool
> > instead of a tristate? It's more an option for the xhci-platform
> > driver than an additional separate module, IMO. What do you think?
> 
> fine by me too. It simply adds a quirk callback to xhci-plat.

In the end, I settled on keeping the tristate, and used your
suggestion. Because since xhci-plat itself is a blind option, and
xhci-mvebu selects it, if xhci-mvebu is a bool, there would no longer
be a way to have xhci-plat as a module. At least that's my
understanding of the kconfig stuff :)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
