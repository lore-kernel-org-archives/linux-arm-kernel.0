From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 20 May 2012 21:08:55 -0400
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <20120520132214.GD12741@lunn.ch>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120520095110.GC12741@lunn.ch>
 <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
 <20120520132214.GD12741@lunn.ch>
Message-ID: <20120521010855.GJ24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2012 at 03:22:14PM +0200, Andrew Lunn wrote:
> > I should really submit this :) What should it be based on? A new
> > revision of my previous patches, or should I assume that my work and
> > Andrew's clk work have already been merged? (apologies if this is a
> > dumb question)
> 
> Yes, you can assume both are in. arm-soc has them, so the 3.5-rc1
> should have them.
> 
> For the next cycle we need to improve working together on DT porting.
> There is a lot of work going on here, in kirkwood, orion5x, dove, and
> the two new Armada SoCs, all needing/porting drivers to DT.  I think
> we need a tree where patches are quickly added once they are stable,
> so that others can profit from the work.

I'm setting up a branch scheme that should handle this:

# main branch for pull-requests to Arnd/Olof

for-arm-soc

# branches that are ready to merge into for-arm-soc

board/<boardname>

	# branches which can be merged as depends

	driver/<driver>
	dt/<binding>

# branches which can be changed/rebased/etc

staging/*


Does that cover everthing?  Or is there something I missed?

thx,

Jason.
