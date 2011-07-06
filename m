From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 6 Jul 2011 13:14:07 +0800
Subject: [PATCH] net/fec: gasket needs to be enabled for some i.mx
In-Reply-To: <20110704065523.GX6069@pengutronix.de>
References: <20110630161935.GA7977@S2100-06.ap.freescale.net>
	<1309515082-7386-1-git-send-email-shawn.guo@linaro.org>
	<20110704065523.GX6069@pengutronix.de>
Message-ID: <20110706051406.GA26324@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 08:55:23AM +0200, Sascha Hauer wrote:
> David,
> 
> On Fri, Jul 01, 2011 at 06:11:22PM +0800, Shawn Guo wrote:
> > On the recent i.mx (mx25/50/53), there is a gasket inside fec
> > controller which needs to be enabled no matter phy works in MII
> > or RMII mode.
> > 
> > The current code enables the gasket only when phy interface is RMII.
> > It's broken when the driver works with a MII phy.  The patch uses
> > platform_device_id to distinguish the SoCs that have the gasket and
> > enables it on these SoCs for both MII and RMII mode.
> > 
> > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/clock-imx25.c                 |    2 +-
> >  arch/arm/mach-imx/clock-imx27.c                 |    2 +-
> >  arch/arm/mach-imx/clock-imx35.c                 |    2 +-
> >  arch/arm/mach-mx5/clock-mx51-mx53.c             |    4 +-
> >  arch/arm/plat-mxc/devices/platform-fec.c        |   17 ++++++++-------
> >  arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
> >  drivers/net/fec.c                               |   26 ++++++++++++++++++++--
> 
> I either need your Ack for this or we need to split this up into two
> patches. Pushing this through the net tree is probably not a good idea.
> 
I need to do another rebase on 'next' as David just applied the dt
series.

-- 
Regards,
Shawn
