From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 14 Oct 2011 18:32:33 +0800
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <20111014100504.GC2966@opensource.wolfsonmicro.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<20111014081024.GA9485@b20223-02.ap.freescale.net>
	<20111014100504.GC2966@opensource.wolfsonmicro.com>
Message-ID: <20111014103233.GB9485@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 11:05:04AM +0100, Mark Brown wrote:
> On Fri, Oct 14, 2011 at 04:10:26PM +0800, Richard Zhao wrote:
> > On Thu, Sep 22, 2011 at 03:26:56PM -0700, Mike Turquette wrote:
> 
> snip essentially Mike's entire mail - *please* delete irrelevant quotes
> from your replies, it makes it very much easier to find the new text in
> your mail and is much more friendly to people reading mail on mobile
> devices.
I snip not enough? sorry for that. I'll be carefull.
> 
> > > +static int __clk_enable(struct clk *clk)
> > > +{
> 
> > Could you expose __clk_enable/__clk_disable? I find it hard to implement
> > clk group. clk group means, when a major clk enable/disable, it want a set
> > of other clks enable/disable accordingly.
> 
> Shouldn't this be something the core is implementing?  I'd strongly
> expect that the clock drivers are relatively dumb and delegate all the
> decision making to the core API.  Otherwise it's going to be hard for
> the core to implement any logic that involves working with more than one
> clock like rate change notification, or guarantee that driver requests
> made through the API are satisfied, as the state of the clocks will be
> changing underneath it.
