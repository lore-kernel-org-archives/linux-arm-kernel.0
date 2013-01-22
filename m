From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 21 Jan 2013 22:39:31 -0500 (EST)
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <201301212149.15139.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1301212227020.32663-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jan 2013, Arnd Bergmann wrote:

> Alan, one comment about your version: You keep maintaining the
> '#if IS_ENABLED' list in the main driver, which I think can actually
> get removed now.

I considered doing that.  The benefit of keeping it is that it warns 
about configs where the main driver is built but can never be used.

Still, you're right that its purpose is becoming less important.  I had 
planned to remove it when all the glue driver had been converted, but 
in fact it could be removed at any time.

>  Since the base driver can be built independent of
> the presence of platform glue drivers, there is no need to forbid
> it any more, and the #if block will cause merge conflicts for each
> patch that converts or adds another platform.

If the patches are done independently.  There are likely to be some
context conflicts anyway.

>  I think we can actually
> get the same results by turning the Kconfig logic around and making
> the platform glue drivers 'select USB_EHCI_HCD' than depending on
> it.

That's a good idea.  The Kconfig changes would have to be done 
carefully to make sure that the dependency on USB_ARCH_HAS_EHCI still 
applies to all the platform drivers.

Manjunath, would you like to send a patch to do this?

Alan Stern
