From: radheys@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 16:02:11 +0000
Subject: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return
 check
In-Reply-To: <20180613072905.GE24314@lunn.ch>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180613072905.GE24314@lunn.ch>
Message-ID: <DM6PR02MB4361C8FE169512A8C8E75E41C77E0@DM6PR02MB4361.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: Wednesday, June 13, 2018 12:59 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: davem at davemloft.net; michal.simek at xilinx.com;
> netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return
> check
> 
> On Wed, Jun 13, 2018 at 12:05:19PM +0530, Radhey Shyam Pandey wrote:
> > Errors are already reported in xemaclite_mdio_setup so avoid
> > reporting it again.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > index ec4608e..2a0c06e 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > @@ -1143,9 +1143,7 @@ static int xemaclite_of_probe(struct
> platform_device *ofdev)
> >  	xemaclite_update_address(lp, ndev->dev_addr);
> >
> >  	lp->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-
> handle", 0);
> > -	rc = xemaclite_mdio_setup(lp, &ofdev->dev);
> > -	if (rc)
> > -		dev_warn(&ofdev->dev, "error registering MDIO bus\n");
> > +	xemaclite_mdio_setup(lp, &ofdev->dev);
> >
> >  	dev_info(dev, "MAC address is now %pM\n", ndev->dev_addr);
> 
> The patch itself is O.K.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> However, do you want to keep going if the MDIO bus fails? Maybe you
> should failed the probe?
Thanks for the review. Yes, I will fix it in next series.

-Radhey
> 
>     Andrew
