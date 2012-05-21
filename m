From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 21 May 2012 11:57:24 -0400
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <20120521052322.GE12741@lunn.ch>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120520095110.GC12741@lunn.ch>
 <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
 <20120520132214.GD12741@lunn.ch>
 <20120521010855.GJ24238@titan.lakedaemon.net>
 <20120521052322.GE12741@lunn.ch>
Message-ID: <20120521155724.GP24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 07:23:22AM +0200, Andrew Lunn wrote:
> > > For the next cycle we need to improve working together on DT porting.
> > > There is a lot of work going on here, in kirkwood, orion5x, dove, and
> > > the two new Armada SoCs, all needing/porting drivers to DT.  I think
> > > we need a tree where patches are quickly added once they are stable,
> > > so that others can profit from the work.
> > 
> > I'm setting up a branch scheme that should handle this:
> > 
> > # main branch for pull-requests to Arnd/Olof
> > 
> > for-arm-soc
> 
> I would say that this branch needs to be stable, i.e. no rebasing.  We
> need to encourage everybody to use it as the basis for their work,
> since it will have everything applied that can be shared. No rebasing
> means that if something is broken, a patch is applied on top. Then
> just before the merge window you can squash the patch into the
> original work so we have a clean patchset going upwards.

Yes.

> > # branches that are ready to merge into for-arm-soc
> > 
> > board/<boardname>
> > 
> 
> Do you mean old style, none DT, boards?

No, new DT boards.

I moved my comment to be close to what it was referring to:
> > 	# branches which can be merged as depends
> > 	driver/<driver>
> > 	dt/<binding>
> 
> You need to explain that a bit more. Since dt/bindings means changes
> to drivers, don't you have the danger of merge conflicts?

Right, perhaps just a branch per patch series.  Since each submitted
patch series tends to be self-grouped.  My main goal was to come up with
a naming scheme to to indicate branches folks can base off of, merge as
depends, or just look at (staging/unstable).  Perhaps:

	for-arm-soc
	depend/orion_nand
	depend/kw_board_raidsonic
	staging/orion_spi

That should be a little cleaner

> Overall, maybe you are over engineering?

Probably.  ;-P

> We need comments from Arnd & Olof, since they run a system like this,
> and know if the complexity is needed for just one platform.
> 
> Also, my guess is, the next cycle is going to be extraordinary. We
> have major cleanup going on after merging into one/two directories. We
> have probably most of the DT support going in, two new SoC types
> getting supported, and hopefully Dove and Orion5x catching up with
> their DT support. So, many people will be working on core
> infrastructure, not individual board files. It is only after that is
> done, will the work return to everybody in there own corner working on
> just single boards.

If we get all that done in this cycle, they should only have to write
dts files...

thx,

Jason.
