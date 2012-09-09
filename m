From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Sep 2012 00:50:59 +0100
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <1347202862-1617-1-git-send-email-lars@metafoo.de>
References: <1347202862-1617-1-git-send-email-lars@metafoo.de>
Message-ID: <20120909235059.GA2643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2012 at 05:01:02PM +0200, Lars-Peter Clausen wrote:

> The managed clk functions are currently only available when the generic clk
> lookup framework is build. But the managed clk functions are merely wrappers
> around clk_get and clk_put and do not depend on any specifics of the generic
> lookup functions and there are still quite a few custom implementations of the
> clk API. So make the managed functions available whenever the clk API is
> implemented.

> The patch also removes the custom implementation of devm_clk_get for the
> coldfire platform.

I posted a patch for this (clk: Move devm_ APIs out of clkdev into
HAVE_CLK) towards the end of the last release cycle and I think reposted
it since and it had been sent to the patch tracker too (though I can't
find any record of anything except the submission mail now).  It would
be *really* good to get this merged.

Who's looking after clkdev these days?  Mike doesn't seem to take
patches as he's expecting Russell to take them which was happening for a
while but I'm not sure that's the case any more, especially given
Russell's followup here.  Due to the patch tracker the usual things for
following up on unapplied patches don't work terribly well, it's much
less likely that it's just an oversight there.
