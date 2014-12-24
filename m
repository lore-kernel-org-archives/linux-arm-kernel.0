From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Dec 2014 09:49:48 -0600
Subject: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
In-Reply-To: <549AA94A.8030209@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
Message-ID: <20141224154948.GA423@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/23/14 18:19, Felipe Balbi wrote:
> > On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> >> Hi Felipe,
> >>
> >> On 12/22/14 20:05, Felipe Balbi wrote:
> >>
> >> [...]
> >>
> >>>  CONFIG_SCSI_SCAN_ASYNC=y
> >>> -CONFIG_ATA=y
> >>> -CONFIG_SATA_AHCI_PLATFORM=y
> >>> -CONFIG_MD=y
> >>> +CONFIG_ATA=m
> >>> +CONFIG_SATA_AHCI_PLATFORM=m
> >>
> >> Isn't this needed for the rootfs on SATA devices?
> > 
> > there's no known boards with rootfs on SATA. Until then, we can reduce
> > the size.
> 
> What makes you say so?
> The decision for rootfs on SATA is taken dynamically.
> OMAP5 boards (specifically cm-t54) can have rootfs on SATA...

I'll leave the decision to Tony. Even though they _can_, they really
don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
annoying to find that special device which works (e.g it can't negotiate
lower speeds with SATA III devices and it won't support SATA I).

As of today, we don't know of anybody really shipping anything with
rootfs on SATA and distros would rather ship initiramfs than a giant
zImage anyway.

Tony, your call.

> >>> -CONFIG_USB=y
> >>> +CONFIG_HID_GENERIC=m
> >>> +CONFIG_USB_HIDDEV=y
> >>> +CONFIG_USB_KBD=m
> >>> +CONFIG_USB_MOUSE=m
> >>> +CONFIG_USB=m
> >>
> >> So, you don't consider USB a valid rootfs storage option?
> > 
> > read the original defconfig. This is *only* for usbcore.ko, EHCI is
> > disabled, XHCI is a module, MUSB is disabled. What will you use for
> > rootfs ?
> 
> Yes, thanks for pointing. Now I see indeed this is a sensible thing
> to do and probably should have been done a while ago.
> 
> Might be worth addressing/explaining this in the commit message.

right, I'll look at it after holiday season.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141224/8a34a38b/attachment.sig>
