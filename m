From: horms@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 18:05:44 +0900
Subject: [PATCH 0/3] ARM: shmobile: sh-eth pins in DT for armadillo800eva
In-Reply-To: <Pine.LNX.4.64.1301250856040.17518@axis700.grange>
References: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
 <20130125043743.GP13691@verge.net.au>
 <Pine.LNX.4.64.1301250856040.17518@axis700.grange>
Message-ID: <20130125090544.GD30990@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 09:09:54AM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Fri, 25 Jan 2013, Simon Horman wrote:
> 
> > On Thu, Jan 24, 2013 at 05:07:30PM +0100, Guennadi Liakhovetski wrote:
> > > This patch series gets rid of gpio_request()-style ethernet pin 
> > > configuration on armadillo800eva in reference implementation.
> > 
> > Hi Guennadi,
> > 
> > these changes seem to be reasonable to me.
> > 
> > Are there any dependencies for the sh_eth patch?
> > I assume this will be handled by David Miller through the net-next tree.
> > Are there any dependencies? The last time I checked the DT bindings
> > for sh_eth had not been merged.
> 
> Obviously, it can only be applied, if the 
> Documentation/devicetree/bindings/net/sh_ether.txt file and the 
> sh_eth_parse_dt() function exist. Also, if there are no objections against 
> the new phy-reset-gpios DT property. Otherwise there are no dependencies - 
> as long as the phy-reset-gpios property isn't found in DT, the patch 
> doesn't affect the driver.

Thanks, I'm slightly concerned that the other patch(es) relating
to Documentation/devicetree/bindings/net/sh_ether.txt have gone missing in
action.

Do you have an interest in chasing them down or would you like me to?

> > For the remaining two patches, which I assume will go through my renesas
> > tree:
> > * Are there any dependencies that aren't satisfied by the of-intc branch?
> 
> AFAICS, that your branch doesn't contain Laurent's pinctrl patches, which 
> are needed for patch 1 to apply and for patch 3 to make sense. My earlier 
> MMC DT / pinctrl patches aren't required for these patches to function, 
> but these patches won't apply cleanly without them, since they touch the 
> same code fragments. So, it would be easier to merge them in the order of 
> submission.
> 
> > * Could you get some Acks. At least from Laurent?
> 
> Sure, let's give reviewers some more time :)

Indeed.

Laurent, if there are patches ready for me to take into the renesas tree
please let me know. I'm reluctant to add any more pinmux changes for 3.9.
But if a topic branch would help let me know.
