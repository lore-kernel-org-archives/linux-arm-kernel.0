From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 6 Jul 2014 17:22:00 +0200
Subject: [PATCH v10 2/2] dmaengine: sun6i: Add driver for the Allwinner
 A31 DMA controller
In-Reply-To: <20140704075710.GN31996@lukather>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140701124852.GB6064@leverpostej> <20140704075710.GN31996@lukather>
Message-ID: <201407061722.01279.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014, Maxime Ripard wrote:
> > > > It feels a little fragile to rely on the organisation of the clock tree
> > > > and the naming thereof. If the IP block is ever reused on an SoC with a
> > > > different clock tree layout then we have to handle things differently.
> > > 
> > > What do you suggest then?
> > 
> > I will admit that I don't have a better suggestion.
> > 
> > Without knowing which particular constraint on the mux parent clock we
> > care about it's difficult to suggest anything useful.
> 
> Well, I first made it into the mach- directory, and then was told to
> move it in the driver itself, so we're kind of running out of options
> :)

How about having a property in the clock provider node that forces a
specific value for the mux? I think that's generally the preferred solution
for any clock settings that go beyond what an OS can be expected to figure
out for itself.

	Arnd
