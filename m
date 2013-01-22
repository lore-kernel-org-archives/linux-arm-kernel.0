From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Jan 2013 22:00:27 +0100
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <201301221538.55975.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1301221011190.1510-100000@iolanthe.rowland.org>
 <201301221538.55975.arnd@arndb.de>
Message-ID: <20130122210027.GN1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 03:38:55PM +0000, Arnd Bergmann wrote:
> On Tuesday 22 January 2013, Alan Stern wrote:
> > In order to prevent this, you have to make sure that each glue driver
> > depends on USB_ARCH_HAS_EHCI.  A simple way to do this is to surround
> > the Kconfig entries for those drivers with "if USB && 
> > USB_ARCH_HAS_EHCI" ... "endif".
> 
> I was actually thinking we could remove the use of USB_ARCH_HAS_EHCI
> as well once we have inverted the logic for selecting USB_EHCI_HCD,
> but there is another problem with that, because then we still need
> something to select USB_ARCH_HAS_HCD, or kill that symbol as well.

+1 for killing it. Such symbols get more and more meaningless anyway
with multiarch kernels-

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
