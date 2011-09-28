From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Sep 2011 15:04:34 +0200
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110927221308.GA2674@opensource.wolfsonmicro.com>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110927210849.GD3994@ponder.secretlab.ca>
	<20110927221308.GA2674@opensource.wolfsonmicro.com>
Message-ID: <201109281504.34560.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2011, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:08:49PM -0600, Grant Likely wrote:
> 
> > Okay, will do.  How does EPROBE_DEFER 518 sound?
> 
> Note that I'm not sure this answers the issue I was raising - the issue
> isn't that the caller doesn't know what the error code means, the issue
> is that in some cases the driver needs to take a decision about what
> failure to get a resource means.  Does it mean that the driver can work
> fine and be slightly less featureful or should it cause a deferral?

Can you think of cases where this information cannot be put into the
device tree or platform_data? If a board provides an optional feature,
I think that should be a property of the device that the driver gets,
so it can return an error when that feature is not around, or continue
when it knows that the feature will never become available.

	Arnd
