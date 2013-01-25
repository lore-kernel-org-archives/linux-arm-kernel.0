From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 25 Jan 2013 09:09:54 +0100 (CET)
Subject: [PATCH 0/3] ARM: shmobile: sh-eth pins in DT for armadillo800eva
In-Reply-To: <20130125043743.GP13691@verge.net.au>
References: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
 <20130125043743.GP13691@verge.net.au>
Message-ID: <Pine.LNX.4.64.1301250856040.17518@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

On Fri, 25 Jan 2013, Simon Horman wrote:

> On Thu, Jan 24, 2013 at 05:07:30PM +0100, Guennadi Liakhovetski wrote:
> > This patch series gets rid of gpio_request()-style ethernet pin 
> > configuration on armadillo800eva in reference implementation.
> 
> Hi Guennadi,
> 
> these changes seem to be reasonable to me.
> 
> Are there any dependencies for the sh_eth patch?
> I assume this will be handled by David Miller through the net-next tree.
> Are there any dependencies? The last time I checked the DT bindings
> for sh_eth had not been merged.

Obviously, it can only be applied, if the 
Documentation/devicetree/bindings/net/sh_ether.txt file and the 
sh_eth_parse_dt() function exist. Also, if there are no objections against 
the new phy-reset-gpios DT property. Otherwise there are no dependencies - 
as long as the phy-reset-gpios property isn't found in DT, the patch 
doesn't affect the driver.

> For the remaining two patches, which I assume will go through my renesas
> tree:
> * Are there any dependencies that aren't satisfied by the of-intc branch?

AFAICS, that your branch doesn't contain Laurent's pinctrl patches, which 
are needed for patch 1 to apply and for patch 3 to make sense. My earlier 
MMC DT / pinctrl patches aren't required for these patches to function, 
but these patches won't apply cleanly without them, since they touch the 
same code fragments. So, it would be easier to merge them in the order of 
submission.

> * Could you get some Acks. At least from Laurent?

Sure, let's give reviewers some more time :)

Thanks
Guennadi

> > Guennadi Liakhovetski (3):
> >   pinctrl: add ethernet pin groups to r8a7740
> >   ethernet: add a PHY reset GPIO DT binding to sh_eth
> >   ARM: shmobile: move pin configuration on armadillo800eva-reference to
> >     DT
> > 
> >  Documentation/devicetree/bindings/net/sh_ether.txt |    2 +
> >  .../boot/dts/r8a7740-armadillo800eva-reference.dts |    7 ++++
> >  .../board-armadillo800eva-reference.c              |   24 ---------------
> >  drivers/net/ethernet/renesas/sh_eth.c              |    9 +++++-
> >  drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |   31 ++++++++++++++++++++
> >  5 files changed, 48 insertions(+), 25 deletions(-)
> > 
> > -- 
> > 1.7.2.5
> > 
> > Thanks
> > Guennadi
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> > 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
