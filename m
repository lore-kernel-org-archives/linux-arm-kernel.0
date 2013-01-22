From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 15:38:55 +0000
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <Pine.LNX.4.44L0.1301221011190.1510-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1301221011190.1510-100000@iolanthe.rowland.org>
Message-ID: <201301221538.55975.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Alan Stern wrote:
> In order to prevent this, you have to make sure that each glue driver
> depends on USB_ARCH_HAS_EHCI.  A simple way to do this is to surround
> the Kconfig entries for those drivers with "if USB && 
> USB_ARCH_HAS_EHCI" ... "endif".

I was actually thinking we could remove the use of USB_ARCH_HAS_EHCI
as well once we have inverted the logic for selecting USB_EHCI_HCD,
but there is another problem with that, because then we still need
something to select USB_ARCH_HAS_HCD, or kill that symbol as well.

	Arnd
