From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 20 Feb 2013 11:54:52 -0500
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <201302201627.04224.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1302201055260.1671-100000@iolanthe.rowland.org>
 <201302201627.04224.arnd@arndb.de>
Message-ID: <20130220165452.GS23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan,

On Wed, Feb 20, 2013 at 04:27:04PM +0000, Arnd Bergmann wrote:
> On Wednesday 20 February 2013, Alan Stern wrote:
> > Currently there is no Kconfig option to control specifically whether
> > the ehci-orion driver gets built; it always gets built whenever
> > CONFIG_PLAT_ORION and CONFIG_USB_EHCI_HCD are both enabled.
> > 
> > Do you think it is a good idea to add an option for this?  Should it at
> > least be non-interactive, so that the driver always gets built under
> > the same conditions as currently?  A later patch can make it 
> > interactive, if desired.
> 
> I think it's good to have it interactive, because we are now building for
> multiplatform with Orion being one of many. It's useful to be able to
> build EHCI_HCD=y AND EHCD_HCD_ORION=m.

Yes, explicit is preferable.  On kirkwood usb has it's own gateable
clock.  The user should be able to conserve power by unloading the
module or building without it.

thx,

Jason.
