From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 11:31:38 +0100
Subject: [PATCH 03/10] net/fec: add mac field into platform data and
	consolidate fec_get_mac
In-Reply-To: <20101229100520.GB19347@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-4-git-send-email-shawn.guo@freescale.com>
	<20101229065329.GB31010@jasper.tkos.co.il>
	<20101229100520.GB19347@freescale.com>
Message-ID: <20101229103138.GT14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 29, 2010 at 06:05:21PM +0800, Shawn Guo wrote:
> On Wed, Dec 29, 2010 at 08:53:30AM +0200, Baruch Siach wrote:
> > Hi Shawn,
> > In the case of dual MAC that you later add support for, the address which one 
> > is being set? Is there a way to set both in kernel command line?
> > 
> The fec0 gets fec_mac and fec1 gets fec_mac + 1. The following code
> in function fec_get_mac takes care of it.
> 
> 	/* Adjust MAC if using default MAC address */
default MAC address means the address passed via cmdline?  Sounds
confusing to me.

> 	if (iap == fec_mac_default)
> 		dev->dev_addr[ETH_ALEN-1] = fec_mac_default[ETH_ALEN-1] + fep->pdev->id;
Can this overflow?  (I didn't check the code, so my concern might be
completely stupid here.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
