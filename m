From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Sep 2011 12:00:12 +0100
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110928231410.GF2838@ponder.secretlab.ca>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110926152634.GN2946@opensource.wolfsonmicro.com>
	<CACxGe6swdnhk_GCAv3siSx4kxNQXmCLDbwBFjsX5VPNfCBc2Mg@mail.gmail.com>
	<201109271550.36427.arnd@arndb.de>
	<20110927210849.GD3994@ponder.secretlab.ca>
	<20110927221308.GA2674@opensource.wolfsonmicro.com>
	<20110928231410.GF2838@ponder.secretlab.ca>
Message-ID: <20110929110011.GL3697@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 06:14:10PM -0500, Grant Likely wrote:

> For your question, I still think it is the driver that gets to make
> the decision.  If it can proceed without a resource, then it should go
> ahead and succeed on the probe, and then arrange to either be notified
> of new gpio controller (or whatever) registrations, or poll for the
> resource to be set up.

Right, I do tend to agree.  This is something we'll have to bear in mind
when deploying this stuff - drivers that are doing this sort of stuff
are going to get surprised.
