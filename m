From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 13:50:30 +0100
Subject: [PATCH] spi/pl022: Enable clock in probe an use runtime_idle
In-Reply-To: <20111024120342.GQ8708@ponder.secretlab.ca>
References: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
	<20111024120342.GQ8708@ponder.secretlab.ca>
Message-ID: <20111024125030.GB17693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 02:03:42PM +0200, Grant Likely wrote:
> On Fri, Oct 21, 2011 at 04:08:44PM +0200, Ulf Hansson wrote:
> > Since we are always runtime resumed when leaving probe
> > the clock must be enabled. To accomplish that we are able
> > to be runtime suspended after probe in the case when no
> > request is going to be recieved, a runtime_idle function
> > has been implemented.
> > 
> > Change-Id: I6cb86f2cad30ecaab16f512daf4674b039b18213
> > Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> > Reviewed-on: http://gerrit.lud.stericsson.com/gerrit/34447
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Since it depends on Russell's tree, I'm okay with it going in that way.

I've received this patch in the patch system, but I'm not planning to
apply it yet because it depends on two branches in my tree (amba and clk).
