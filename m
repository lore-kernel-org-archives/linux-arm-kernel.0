From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 21 May 2012 07:23:22 +0200
Subject: kirkwood, nand, clocks and device-tree
In-Reply-To: <20120521010855.GJ24238@titan.lakedaemon.net>
References: <87fwaxes25.fsf@lebrac.rtp-net.org>
 <20120520095110.GC12741@lunn.ch>
 <alpine.DEB.2.00.1205201352090.23719@marmot.wormnet.eu>
 <20120520132214.GD12741@lunn.ch>
 <20120521010855.GJ24238@titan.lakedaemon.net>
Message-ID: <20120521052322.GE12741@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > For the next cycle we need to improve working together on DT porting.
> > There is a lot of work going on here, in kirkwood, orion5x, dove, and
> > the two new Armada SoCs, all needing/porting drivers to DT.  I think
> > we need a tree where patches are quickly added once they are stable,
> > so that others can profit from the work.
> 
> I'm setting up a branch scheme that should handle this:
> 
> # main branch for pull-requests to Arnd/Olof
> 
> for-arm-soc

I would say that this branch needs to be stable, i.e. no rebasing.  We
need to encourage everybody to use it as the basis for their work,
since it will have everything applied that can be shared. No rebasing
means that if something is broken, a patch is applied on top. Then
just before the merge window you can squash the patch into the
original work so we have a clean patchset going upwards.

> # branches that are ready to merge into for-arm-soc
> 
> board/<boardname>
> 
> 	# branches which can be merged as depends

Do you mean old style, none DT, boards?

> 	driver/<driver>
> 	dt/<binding>

You need to explain that a bit more. Since dt/bindings means changes
to drivers, don't you have the danger of merge conflicts?

Overall, maybe you are over engineering? We need comments from Arnd &
Olof, since they run a system like this, and know if the complexity is
needed for just one platform.

Also, my guess is, the next cycle is going to be extraordinary. We
have major cleanup going on after merging into one/two directories. We
have probably most of the DT support going in, two new SoC types
getting supported, and hopefully Dove and Orion5x catching up with
their DT support. So, many people will be working on core
infrastructure, not individual board files. It is only after that is
done, will the work return to everybody in there own corner working on
just single boards.

       Andrew
