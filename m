From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 16 Oct 2013 17:13:29 -0400 (EDT)
Subject: [PATCH v2] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <525EFD0B.2020607@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1310161711310.1264-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Oct 2013, Ryan Mallon wrote:

> > It's awfully hard to believe that enabling USB_OHCI_HCD_PLATFORM is 
> > responsible for all those other changes.
> 
> 
> The 'make savedefconfig' step minimises the defconfig by removing any
> options that are implicitly selected or options that no longer exist.
> E.g: 4d42942c: 'mtd: make MTD_CONCAT support mandatory' is responsible
> for CONFIG_MTD_CONCAT disappearing from the defconfig. Looks the other
> MTD options have also been removed.

...

> In short, yes the 'make savedefconfig' step is annoying because it
> creates weird diffs. However, the diffs are correct (cleaning up
> unused options, etc). The diffs should be inspected to catch things
> like the inotify case, but otherwise there should be no functional
> changes.

Sure, that's what I meant.  All that churn was caused by re-minimizing
the defconfig file, not by adding USB_OHCI_HCD_PLATFORM.

> > Maybe this should be done in two stages.  First create a patch that
> > describes the differences resulting from:
> > 
> > make ARCH=arm ep93xx_defconfig
> > make ARCH=arm savedefconfig
> > mv defconfig arch/arm/configs/ep93xx_defconfig
> 
> >
> > Then do this patch on top of that one.
> > 
> 
> Yeah, I think a pre-patch for "ep93xx: make savedefconfig" would be
> best.
> 
> Are you happy to collect all these patches once they are done? I
> could take the ep93xx parts, but my tree typically only has a 
> small handful of patches each merge window, so it is probably easier
> if you grab them all.

Greg KH and I can take both patches.

Alan Stern
