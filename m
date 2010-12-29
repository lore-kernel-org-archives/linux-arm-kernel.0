From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 29 Dec 2010 19:58:09 +0800
Subject: [PATCH 03/10] net/fec: add mac field into platform data and
	consolidate fec_get_mac
In-Reply-To: <20101229103138.GT14221@pengutronix.de>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-4-git-send-email-shawn.guo@freescale.com>
	<20101229065329.GB31010@jasper.tkos.co.il>
	<20101229100520.GB19347@freescale.com>
	<20101229103138.GT14221@pengutronix.de>
Message-ID: <20101229115808.GF19347@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Dec 29, 2010 at 11:31:38AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Wed, Dec 29, 2010 at 06:05:21PM +0800, Shawn Guo wrote:
> > On Wed, Dec 29, 2010 at 08:53:30AM +0200, Baruch Siach wrote:
> > > Hi Shawn,
> > > In the case of dual MAC that you later add support for, the address which one 
> > > is being set? Is there a way to set both in kernel command line?
> > > 
> > The fec0 gets fec_mac and fec1 gets fec_mac + 1. The following code
> > in function fec_get_mac takes care of it.
> > 
> > 	/* Adjust MAC if using default MAC address */
> default MAC address means the address passed via cmdline?  Sounds
> confusing to me.
Will change the comment and fec_mac_default name to address
the concern.

> 
> > 	if (iap == fec_mac_default)
> > 		dev->dev_addr[ETH_ALEN-1] = fec_mac_default[ETH_ALEN-1] + fep->pdev->id;
> Can this overflow?  (I didn't check the code, so my concern might be
> completely stupid here.)
No. dev->dev_addr points to netdev_hw_addr->addr, which is a 32 bytes array.

-- 
Regards,
Shawn
