From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Sep 2011 23:13:10 +0100
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110927210849.GD3994@ponder.secretlab.ca>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110926152634.GN2946@opensource.wolfsonmicro.com>
	<CACxGe6swdnhk_GCAv3siSx4kxNQXmCLDbwBFjsX5VPNfCBc2Mg@mail.gmail.com>
	<201109271550.36427.arnd@arndb.de>
	<20110927210849.GD3994@ponder.secretlab.ca>
Message-ID: <20110927221308.GA2674@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:08:49PM -0600, Grant Likely wrote:

> Okay, will do.  How does EPROBE_DEFER 518 sound?

Note that I'm not sure this answers the issue I was raising - the issue
isn't that the caller doesn't know what the error code means, the issue
is that in some cases the driver needs to take a decision about what
failure to get a resource means.  Does it mean that the driver can work
fine and be slightly less featureful or should it cause a deferral?
