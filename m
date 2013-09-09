From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Sep 2013 17:00:24 +0200
Subject: [PATCH v2 2/4] ARM: dts: add fec phy reset for imx6sl evk board
In-Reply-To: <20130909145333.GA5815@S2101-09.ap.freescale.net>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
 <1378182385-9205-3-git-send-email-B38611@freescale.com>
 <20130909145333.GA5815@S2101-09.ap.freescale.net>
Message-ID: <20130909150024.GU30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 10:53:36PM +0800, Shawn Guo wrote:
> On Tue, Sep 03, 2013 at 12:26:23PM +0800, Fugang Duan wrote:
> > Add fec phy gpio reset for imx6sl evk board. imx6sl evk board
> > use GPIO4_21 to do phy reset, so add phy-reset-gpios and
> > phy-reset-duration propery initial for fec device node.
> > 
> > Signed-off-by: Fugang Duan  <B38611@freescale.com>
> 
> I have to drop this patch for now, because it causes a regression for
> me.
> 
> Before this patch, we can at least get a working fec driver in kernel if
> U-Boot sets it up properly, e.g. we download kernel from network.  But
> with the patch, the fec driver stops working on linux-next in the same
> use case.

I think the FEC driver has doesn't wait enough time after it deasserts
the phy reset before it accesses the phy. At least I once got the
impression, but I haven't digged deeper so far.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
