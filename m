From: horms@verge.net.au (Simon Horman)
Date: Mon, 28 Jan 2013 10:02:27 +0900
Subject: [PATCH 0/3] ARM: shmobile: sh-eth pins in DT for armadillo800eva
In-Reply-To: <1531226.VAPa4M6s5W@avalon>
References: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1301250856040.17518@axis700.grange>
 <20130125090544.GD30990@verge.net.au> <1531226.VAPa4M6s5W@avalon>
Message-ID: <20130128010227.GI3423@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 10:57:08AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 25 January 2013 18:05:44 Simon Horman wrote:
> > On Fri, Jan 25, 2013 at 09:09:54AM +0100, Guennadi Liakhovetski wrote:
> > > On Fri, 25 Jan 2013, Simon Horman wrote:
> > > > On Thu, Jan 24, 2013 at 05:07:30PM +0100, Guennadi Liakhovetski wrote:
> > > > > This patch series gets rid of gpio_request()-style ethernet pin
> > > > > configuration on armadillo800eva in reference implementation.
> > > > 
> > > > Hi Guennadi,
> > > > 
> > > > these changes seem to be reasonable to me.
> > > > 
> > > > Are there any dependencies for the sh_eth patch?
> > > > I assume this will be handled by David Miller through the net-next tree.
> > > > Are there any dependencies? The last time I checked the DT bindings
> > > > for sh_eth had not been merged.
> > > 
> > > Obviously, it can only be applied, if the
> > > Documentation/devicetree/bindings/net/sh_ether.txt file and the
> > > sh_eth_parse_dt() function exist. Also, if there are no objections against
> > > the new phy-reset-gpios DT property. Otherwise there are no dependencies -
> > > as long as the phy-reset-gpios property isn't found in DT, the patch
> > > doesn't affect the driver.
> > 
> > Thanks, I'm slightly concerned that the other patch(es) relating
> > to Documentation/devicetree/bindings/net/sh_ether.txt have gone missing in
> > action.
> > 
> > Do you have an interest in chasing them down or would you like me to?
> > 
> > > > For the remaining two patches, which I assume will go through my renesas
> > > > tree:
> > > > * Are there any dependencies that aren't satisfied by the of-intc
> > > > branch?
> > > 
> > > AFAICS, that your branch doesn't contain Laurent's pinctrl patches, which
> > > are needed for patch 1 to apply and for patch 3 to make sense. My earlier
> > > MMC DT / pinctrl patches aren't required for these patches to function,
> > > but these patches won't apply cleanly without them, since they touch the
> > > same code fragments. So, it would be easier to merge them in the order of
> > > submission.
> > > 
> > > > * Could you get some Acks. At least from Laurent?
> > > 
> > > Sure, let's give reviewers some more time :)
> > 
> > Indeed.
> > 
> > Laurent, if there are patches ready for me to take into the renesas tree
> > please let me know. I'm reluctant to add any more pinmux changes for 3.9.
> > But if a topic branch would help let me know.
> 
> I'd like the gpio_request_one() patches to go to v3.9 if possible. The other 
> pinctrl patches will need to wait until v3.10 I'm afraid.

Understood. I have now queued the gpio_request_one() patches up for v3.9.
