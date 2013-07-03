From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 16:15:13 +0300
Subject: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
In-Reply-To: <51D421BC.9050600@ti.com>
References: <51D28DB9.704@ti.com>
 <Pine.LNX.4.44L0.1307021302430.1086-100000@iolanthe.rowland.org>
 <20130703125719.GD15056@arwen.pp.htv.fi> <51D421BC.9050600@ti.com>
Message-ID: <20130703131513.GH15056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 04:06:04PM +0300, Roger Quadros wrote:
> On 07/03/2013 03:57 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Jul 02, 2013 at 01:17:58PM -0400, Alan Stern wrote:
> >> A PCI-based EHCI controller has two power sources: the core well (which
> >> is turned off during suspend) and the auxiliary well (which remains
> >> powered).  That's how remote wakeup works; it uses the auxiliary well.
> > 
> > This, kinda, matches what OMAP tries to do with pad wakeup. Just that
> > pad wakeup sits outside of the device itself. Perhaps we could look into
> > how PCI handles the aux well and take some inspiration from there.
> > 
> > Any pointers under drivers/pci/ would be great :-)
> > 
> From what I understood, auxiliary well is just a power source, and it keeps
> the EHCI controller powered even during suspend.
> 
> If that is true then it is different from our situation as we power down the
> EHCI controller completely.

right but our "auxiliary well" keeps PRCM powered which can wake EHCI up
;-)

What I'm saying is that from ehci-omap's perspective, there's very
little difference, specially since we route the wakeup through the same
IRQ line anyway. Perhaps we could take some inspiration from the PCI
land to make our hwmod/omap_device a little easier from driver
perspective.

Or maybe it doesn't make sense ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/22b54fc6/attachment.sig>
