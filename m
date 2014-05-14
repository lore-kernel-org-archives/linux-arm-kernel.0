From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 20:51:44 +0200
Subject: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <5373B908.5090904@gmail.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
 <5764751.ffUj9rhnMd@wuerfel> <5373B908.5090904@gmail.com>
Message-ID: <17808571.N5ZGjXFEVP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 20:42:16 Sebastian Hesselbarth wrote:
> >> For the driver, Antoine then would have to squeeze all PHY register
> >> mangling in phy-berlin2.c and see how to make ahci-platform aware of
> >> individual port nodes (I haven't looked up if it already exists, sorry)
> >> and announce only enabled port child nodes, right?
> > 
> > I've been thinking some more about this aspect. I don't actually have
> > a strong opinion on whether it's better to use the generic ahci-platform
> > driver, or to keep the multi-phy support as a special variant for
> > berlin. If we do the latter, it would however be good to define the
> > binding in a way that lets us later merge things into the generic phy
> > driver in case we get more of the same.
> 
> Hmm, IMHO multi-phy support is orthogonal to ahci-platform, isn't it?
> ahci-platform needs to know about the phy property and calls some
> helper that deals with the phy-specifier?
> 
> About a generic _phy_ driver, I am not so sure if berlin is the best
> template right now 
> 
> So, my call would be:
> - make ahci-platform aware of port sub-nodes and phy properties
> - have a berlin specific PHY driver

I'm not sure if we need sub-nodes per port, it should be enough
to have an array of phys, plus a way to match them up with the
ports.

	Arnd
