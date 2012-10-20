From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 20 Oct 2012 10:31:02 -0400 (EDT)
Subject: [PATCH 1/2] USB: Update EHCI-platform driver to devicetree.
In-Reply-To: <2209384.BKaXW2gI8I@bender>
Message-ID: <Pine.LNX.4.44L0.1210201027280.24222-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Oct 2012, Florian Fainelli wrote:

> Hi Tony,
> 
> On Saturday 20 October 2012 16:17:32 Tony Prisk wrote:
> > This patch adds devicetree support to the EHCI-platform driver,
> > and removes the now unneeded ehci-vt8500.c
> > 
> > Existing platform properties are maintained, with the exception
> > the power_(on/off) and suspend function pointers.
> 
> Ok, so I have recently sent a bit patchset to remove most OHCI/EHCI drivers
> that could be converted to the generic variants, series starts here:
> 1349701906-16481-1-git-send-email-florian at openwrt.org
> 
> in this patchset I added a new property to the EHCI platform data:
> need_io_watchdog, which needs to be handled too from DT ideally.

Actually the new property is "no_io_watchdog".  See

	http://marc.info/?l=linux-usb&m=134970247511140&w=2

> Adding device tree bindings is on my TODO after having a generic way
> to pass clocks to the ehci/ohci platform drivers, so you are right on time :)

At some point we'll need a way to handle the power_{on,off,suspend} 
callbacks.  I don't know how that should be done.

Alan Stern
