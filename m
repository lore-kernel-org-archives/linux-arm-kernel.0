From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 13 Jan 2014 11:06:13 -0500 (EST)
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <52D40C42.2050408@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401131105130.1152-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jan 2014, Hans de Goede wrote:

> I agree that usb-Xhci would be the best compatible strings to use.
> 
> The problem with usb-ehci is that there already is a ppc specific driver binding to that
> compatible string, doing various ppc specific controller initialization.
> 
> Thinking more about this, there is one possible solution though, the ehci-ppc-of.c is
> guarded in Kconfig with:
> 
>          depends on PPC_OF
> 
> If we add an inverted check to the Kconfig option for platform-ehci.c, ie:
> 
> config USB_EHCI_HCD_PLATFORM
>          tristate "Generic EHCI driver for a platform device"
> 	depends on !PPC_OF
> 
> Then we can be certain that we don't end up with 2 drivers claiming the
> usb-ehci compatible on ppc platforms. I've done some quick research
> and it seems that ehci-platform.c is only used on arm and mips devices, so
> excluding its use on ppc should not be an issue.
> 
> Then later on someone, who has the actual hardware to test, can merge the
> ppc specific quirk handling into ehci-platform,c and ehci-ppc-of.c can go
> away entirely.
> 
> Alan, if you agree this is the best way forward, I'll do a v5 with the proposed
> changes.

That's okay with me.

Alan Stern
