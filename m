From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 9 Jul 2014 10:08:05 -0400 (EDT)
Subject: [PATCH v1 6/9] usb: xhci: Add NVIDIA Tegra XHCI host-controller
 driver
In-Reply-To: <CAL1qeaHT8Yz7kRY3Qm5i+bYCF4D5BT=BVZ6BMfQufyaQFkt0mw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1407091001150.873-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Jul 2014, Andrew Bresticker wrote:

> > I think at the very least you should add a function
> > "xhci_default_driver(struct hc_driver *driver)" to xhci-plat.c (or
> > even better to xhci.c and use it for PCI as well) that initializes all
> > function pointers to the default (internal) symbols, and can then be
> > overridden afterwards.
> 
> Currently all XHCI host drivers (PCI, platform, MVEBU) will be built
> into the xhci-hcd module.  I could append the Tegra driver to that
> module or introduce a xhci_init_driver() like EHCI does as Julius
> suggests.  USB folks, do you have a preference?

As the EHCI maintainer, I naturally approve of Julius's suggestion.  

Alan Stern
