From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Oct 2012 15:30:43 -0400 (EDT)
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <5088399F.2000102@firmworks.com>
Message-ID: <Pine.LNX.4.44L0.1210241525550.1282-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Oct 2012, Mitch Bradley wrote:

> >> Ah, now I'm starting to get the picture.
> >>
> >> So by listing "usb-ehci" in its device ID table, a driver would
> >> essentially be saying that it can handle _all_ USB EHCI controllers.  
> 
> 
> Actually, it means that the driver can handle at least USB EHCI
> controllers that are 100% compatible with the EHCI spec (requiring
> nothing extra).  The driver might be able to handle almost-compatible
> controllers, possibly with the help of additional properties.

Unfortunately that's not saying very much.  The EHCI spec describes
only PCI-based controllers.  Every other sort does require something
extra.

> If a DT node lists "usb-ehci" as a "fallback", it's not guaranteed that
> a given version of that driver will work, but it's worth a try in the
> event that no more-specific driver is matched.

While I haven't checked in detail, it seems quite likely that this 
would not work with some of the devices that have "usb-ehci" listed in 
their compatible values.

Alan Stern
