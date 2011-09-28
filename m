From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Sep 2011 14:20:42 +0100
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <201109281504.34560.arnd@arndb.de>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110927210849.GD3994@ponder.secretlab.ca>
	<20110927221308.GA2674@opensource.wolfsonmicro.com>
	<201109281504.34560.arnd@arndb.de>
Message-ID: <20110928132042.GL3279@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 03:04:34PM +0200, Arnd Bergmann wrote:
> On Wednesday 28 September 2011, Mark Brown wrote:

> > Note that I'm not sure this answers the issue I was raising - the issue
> > isn't that the caller doesn't know what the error code means, the issue
> > is that in some cases the driver needs to take a decision about what
> > failure to get a resource means.  Does it mean that the driver can work
> > fine and be slightly less featureful or should it cause a deferral?

> Can you think of cases where this information cannot be put into the
> device tree or platform_data? If a board provides an optional feature,
> I think that should be a property of the device that the driver gets,
> so it can return an error when that feature is not around, or continue
> when it knows that the feature will never become available.

Not off the top of my head, most of the cases I'm aware of were cases
where the supply is mandatory but soft control is optional so don't need
to make this decision in the driver at all.  In the MMC case I didn't
push this as working with the people concerned was extremely painful.
