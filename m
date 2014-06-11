From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 11 Jun 2014 22:03:02 +0100 (BST)
Subject: [PATCH v2] uhci-platform: use devm_ioremap resource
In-Reply-To: <Pine.LNX.4.44L0.1406111639420.890-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1406111639420.890-100000@iolanthe.rowland.org>
Message-ID: <alpine.DEB.2.10.1406112202450.2576@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jun 2014, Alan Stern wrote:

> On Wed, 11 Jun 2014, Julia Lawall wrote:
>
> > > > v2: pass correct arguments to devm_ioremap_resource
> > > > Not compile tested due to incompatible architecture.
> > >
> > > uhci-platform is compatible with all architectures.  But you have to
> > > add it to the .config file by hand.
> >
> > What should one do exactly?  I added
> >
> > CONFIG_USB_UHCI_PLATFORM=y
> >
> > to the end of my .config file, but then running make just overwrites it:
>
> By golly, you're right...  I didn't realize it would do that.
>
> I guess you have to edit the drivers/usb/host/Kconfig file, changing
>
> config USB_UHCI_PLATFORM
> 	bool
> 	default y if ARCH_VT8500
>
> to
>
> config USB_UHCI_PLATFORM
> 	bool
> 	default y
>
> or something equivalent.
>
> >
> > > make drivers/usb/host/uhci-platform.o
> > scripts/kconfig/conf --silentoldconfig Kconfig
> > #
> > # configuration written to .config
> > #
> >   CHK     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> >   CC      drivers/usb/host/uhci-platform.o
> > drivers/usb/host/uhci-platform.c:13:38: warning: ?struct usb_hcd? declared
> > inside parameter list [enabled by default]
> >  static int uhci_platform_init(struct usb_hcd *hcd)
>
> Do
>
> 	make drivers/usb/host/uhci-hcd.o
>
> instead of
>
> 	make drivers/usb/host/uhci-platform.o

OK, thanks for the explanations.

julia
