From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 18:14:06 +0100
Subject: [PATCH] mvneta: add FIXED_PHY dependency
In-Reply-To: <20151109170849.GC3388@lunn.ch>
References: <4225885.EYXTHjRPmX@wuerfel> <6910088.dNmooXDTJR@wuerfel>
 <20151109170849.GC3388@lunn.ch>
Message-ID: <6970717.h7VjJkXjcM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 18:08:49 Andrew Lunn wrote:
> > > I suppose it comes down to, are we allowed to optionally implement
> > > part of the DT binding?
> > 
> > I'm not sure what you are asking. A lot of DT bindings have both
> > optional and mandatory properties. For mvneta, the "phy" and "phy-mode"
> > properties are listed as mandatory, so the driver can safely assume
> > that they are always present. If there are reasons to leave them out,
> > and for the driver to handle that case correctly, the binding
> > should be updated to mark them as optional.
> 
> Hi Arnd
> 
> You are looking at it from the perspective of the driver. I was
> meaning from the perspective of the DT blob. Can be blob assume the
> driver implements all of the binding, all of the time?

That question is not really relevant: the DT describes the hardware,
it doesn't matter whether there are drivers for all the bits or
whether all properties are read.

> You use fixed-phy when the MAC is connected to a switch, not a phy. Or
> when the MAC is connected to an SFP module. The driver can currently
> be built to not implement the fixed-phy party of the binding. Is that
> O.K. from the perspective of the DT blob? Or should the driver always
> implement all of the binding, in which these NOP stubs should be
> removed and fixed phy always be enabled for the drivers that use it.

Sure, that is ok.

	Arnd
