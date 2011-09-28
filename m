From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 28 Sep 2011 18:14:10 -0500
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110927221308.GA2674@opensource.wolfsonmicro.com>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110926152634.GN2946@opensource.wolfsonmicro.com>
	<CACxGe6swdnhk_GCAv3siSx4kxNQXmCLDbwBFjsX5VPNfCBc2Mg@mail.gmail.com>
	<201109271550.36427.arnd@arndb.de>
	<20110927210849.GD3994@ponder.secretlab.ca>
	<20110927221308.GA2674@opensource.wolfsonmicro.com>
Message-ID: <20110928231410.GF2838@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 11:13:10PM +0100, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:08:49PM -0600, Grant Likely wrote:
> 
> > Okay, will do.  How does EPROBE_DEFER 518 sound?
> 
> Note that I'm not sure this answers the issue I was raising - the issue
> isn't that the caller doesn't know what the error code means, the issue
> is that in some cases the driver needs to take a decision about what
> failure to get a resource means.  Does it mean that the driver can work
> fine and be slightly less featureful or should it cause a deferral?

Right. That was answering a different question.

For your question, I still think it is the driver that gets to make
the decision.  If it can proceed without a resource, then it should go
ahead and succeed on the probe, and then arrange to either be notified
of new gpio controller (or whatever) registrations, or poll for the
resource to be set up.

g.
