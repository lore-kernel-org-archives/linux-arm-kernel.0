From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Jul 2014 12:40:56 +0200
Subject: [PATCH v1 6/9] usb: xhci: Add NVIDIA Tegra XHCI host-controller
 driver
In-Reply-To: <Pine.LNX.4.44L0.1407091001150.873-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1407091001150.873-100000@iolanthe.rowland.org>
Message-ID: <201407101240.56828.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 July 2014, Alan Stern wrote:
> On Tue, 8 Jul 2014, Andrew Bresticker wrote:
> 
> > > I think at the very least you should add a function
> > > "xhci_default_driver(struct hc_driver *driver)" to xhci-plat.c (or
> > > even better to xhci.c and use it for PCI as well) that initializes all
> > > function pointers to the default (internal) symbols, and can then be
> > > overridden afterwards.
> > 
> > Currently all XHCI host drivers (PCI, platform, MVEBU) will be built
> > into the xhci-hcd module.  I could append the Tegra driver to that
> > module or introduce a xhci_init_driver() like EHCI does as Julius
> > suggests.  USB folks, do you have a preference?
> 
> As the EHCI maintainer, I naturally approve of Julius's suggestion.  

I'm not a USB maintainer, but I also agree that's the best way forward,
since it's similar to what all other similar drivers in the kernel do.

	Arnd
