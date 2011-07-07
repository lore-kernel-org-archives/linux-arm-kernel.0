From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 7 Jul 2011 21:41:58 +0800
Subject: [PATCH] net/fec: gasket needs to be enabled for some i.mx
In-Reply-To: <20110707.041257.670268148869400054.davem@davemloft.net>
References: <20110630161935.GA7977@S2100-06.ap.freescale.net>
	<1309515082-7386-1-git-send-email-shawn.guo@linaro.org>
	<20110707.041257.670268148869400054.davem@davemloft.net>
Message-ID: <20110707134157.GA12722@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:12:57AM -0700, David Miller wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> Date: Fri,  1 Jul 2011 18:11:22 +0800
> 
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
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> --

Thanks, David.  I will try to get it through Sascha's tree after
the rebase again dt series.

Hi Sascha,

How should we proceed?  It seems Grant will take the fec-dt series
on his tree.  Would you then merge that tree into yours, so that I
can rebase this patch on your tree and get it go through there?

-- 
Regards,
Shawn
