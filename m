From: balbi@ti.com (Felipe Balbi)
Date: Fri, 11 Jul 2014 11:23:48 -0500
Subject: [PATCH v2 0/2] ARM: shmobile: lager: USBHS callback elimination
In-Reply-To: <20140711154152.GC1777@verge.net.au>
References: <53BF35B7.9000105@renesas.com>
 <87oawxy69b.wl%kuninori.morimoto.gx@renesas.com>
 <20140711090005.GH12420@verge.net.au>
 <20140711151236.GG27864@saruman.home>
 <20140711154152.GC1777@verge.net.au>
Message-ID: <20140711162348.GF22572@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 05:41:52PM +0200, Simon Horman wrote:
> On Fri, Jul 11, 2014 at 10:12:37AM -0500, Felipe Balbi wrote:
> > On Fri, Jul 11, 2014 at 11:00:07AM +0200, Simon Horman wrote:
> > > [Cc Felipe Balbi]
> > > 
> > > On Thu, Jul 10, 2014 at 01:20:34AM -0700, Kuninori Morimoto wrote:
> > > > 
> > > > Hi
> > > > 
> > > > > Changes in v2:
> > > > > - move phy handle to struct usbhs_priv
> > > > > - add new default pipe type to driver
> > > > > - remove pipe type from Lager board code
> > > > > 
> > > > > Ulrich Hecht (2):
> > > > >   usb: renesas_usbhs: add R-Car Gen. 2 init and power control
> > > > >   ARM: shmobile: lager: remove USBHS callbacks
> > > > > 
> > > > >  arch/arm/mach-shmobile/board-lager.c | 126 ++++-------------------------------
> > > > >  drivers/usb/renesas_usbhs/Makefile   |   2 +-
> > > > >  drivers/usb/renesas_usbhs/common.c   |  66 ++++++++++++++++--
> > > > >  drivers/usb/renesas_usbhs/common.h   |   2 +
> > > > >  drivers/usb/renesas_usbhs/rcar2.c    |  76 +++++++++++++++++++++
> > > > >  drivers/usb/renesas_usbhs/rcar2.h    |   4 ++
> > > > >  include/linux/usb/renesas_usbhs.h    |   6 ++
> > > > >  7 files changed, 163 insertions(+), 119 deletions(-)
> > > > >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
> > > > >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.h
> > > > 
> > > > For all patches
> > > > 
> > > > Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > [snip]
> > > 
> > > > I tested these patches on Lager legacy, and these patches worked correctly.
> > > > 
> > > > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > 
> > > Hi,
> > > 
> > > it seems that the 2nd patch should go through my renesas tree
> > > but it depends on the first patch which should be taken by 
> > > Felipe Balbi (Cced).
> > > 
> > > Felipe, is there any chance that you could take this for v3.16?
> > > I am quite happy to make a branch for you to pull for renesas_usbhs
> > > if this would make your life easier.
> > 
> > you need to take both patches or just patch 1 ?
> 
> Please just take patch 1.

will do.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/d012ef40/attachment.sig>
