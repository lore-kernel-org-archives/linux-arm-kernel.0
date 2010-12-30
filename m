From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Dec 2010 09:04:05 +0100
Subject: [PATCH 03/10] net/fec: add mac field into platform data and
	consolidate fec_get_mac
In-Reply-To: <20101230021243.GA20155@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-4-git-send-email-shawn.guo@freescale.com>
	<20101229065329.GB31010@jasper.tkos.co.il>
	<20101229100520.GB19347@freescale.com>
	<20101229103138.GT14221@pengutronix.de>
	<20101229115808.GF19347@freescale.com>
	<20101229124220.GD14221@pengutronix.de>
	<20101230021243.GA20155@freescale.com>
Message-ID: <20101230080405.GL14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Thu, Dec 30, 2010 at 10:12:44AM +0800, Shawn Guo wrote:
> On Wed, Dec 29, 2010 at 01:42:21PM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Dec 29, 2010 at 07:58:09PM +0800, Shawn Guo wrote:
> > > On Wed, Dec 29, 2010 at 11:31:38AM +0100, Uwe Kleine-K?nig wrote:
> > > > On Wed, Dec 29, 2010 at 06:05:21PM +0800, Shawn Guo wrote:
> > > > > On Wed, Dec 29, 2010 at 08:53:30AM +0200, Baruch Siach wrote:
> > > > > 	if (iap == fec_mac_default)
> > > > > 		dev->dev_addr[ETH_ALEN-1] = fec_mac_default[ETH_ALEN-1] + fep->pdev->id;
> > > > Can this overflow?  (I didn't check the code, so my concern might be
> > > > completely stupid here.)
> > > No. dev->dev_addr points to netdev_hw_addr->addr, which is a 32 bytes array.
> > I didn't mean an out-of-bound access, but what is if
> > fec_mac_default[ETH_ALEN-1] is 0xff and you add 1?  Does that result in
> > 0x100 or 0?  What if id is <0?  For big ids you might even handle a
> > carry to indixes <ETH_ALEN-2.
> > 
> First of all, all my patch did is changing fep->index to,
> fep->pdev->id, which should not bring any problem you are concerned.
> 
> Secondly, I do not understand how the overflow on 
> fec_mac_default[ETH_ALEN-1] can result in a carry on the next array
> element. Here is what I'm seeing with fec_mac=00:04:9f:01:30:ff.
There is no automatic carry to the next array element.  I just wondered
how overflow should be handled ...
 
> eth0      Link encap:Ethernet  HWaddr 00:04:9F:01:30:FF
> eth1      Link encap:Ethernet  HWaddr 00:04:9F:01:30:00
If this is intended, it's totally OK for me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
