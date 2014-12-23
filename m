From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Dec 2014 10:19:36 -0600
Subject: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
In-Reply-To: <54991A25.2030804@compulab.co.il>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
Message-ID: <20141223161936.GA9147@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> Hi Felipe,
> 
> On 12/22/14 20:05, Felipe Balbi wrote:
> 
> [...]
> 
> >  CONFIG_SCSI_SCAN_ASYNC=y
> > -CONFIG_ATA=y
> > -CONFIG_SATA_AHCI_PLATFORM=y
> > -CONFIG_MD=y
> > +CONFIG_ATA=m
> > +CONFIG_SATA_AHCI_PLATFORM=m
> 
> Isn't this needed for the rootfs on SATA devices?

there's no known boards with rootfs on SATA. Until then, we can reduce
the size.

> >  CONFIG_NETDEVICES=y
> >  # CONFIG_NET_VENDOR_ARC is not set
> >  # CONFIG_NET_CADENCE is not set
> > @@ -154,8 +151,8 @@ CONFIG_TI_CPSW=y
> >  # CONFIG_NET_VENDOR_WIZNET is not set
> >  CONFIG_AT803X_PHY=y
> >  CONFIG_SMSC_PHY=y
> > -CONFIG_USB_USBNET=y
> > -CONFIG_USB_NET_SMSC95XX=y
> > +CONFIG_USB_USBNET=m
> > +CONFIG_USB_NET_SMSC95XX=m
> 
> What about the NFS root for boards with only USB eth?

USB is a module already and it breaks PM when enabled.

> >  CONFIG_DEBUG_GPIO=y
> >  CONFIG_GPIO_SYSFS=y
> > -CONFIG_GPIO_TWL4030=y
> > -CONFIG_W1=y
> > +CONFIG_GPIO_TWL4030=m
> 
> w/o this devices wired to twl gpios will not come up and likely
> will miss the enumeration...

for example ?

> > -CONFIG_USB=y
> > +CONFIG_HID_GENERIC=m
> > +CONFIG_USB_HIDDEV=y
> > +CONFIG_USB_KBD=m
> > +CONFIG_USB_MOUSE=m
> > +CONFIG_USB=m
> 
> So, you don't consider USB a valid rootfs storage option?

read the original defconfig. This is *only* for usbcore.ko, EHCI is
disabled, XHCI is a module, MUSB is disabled. What will you use for
rootfs ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141223/d9e618f2/attachment-0001.sig>
