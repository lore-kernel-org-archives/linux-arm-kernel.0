From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 10:29:09 +0000
Subject: BUG: sleeping function called from invalid context
In-Reply-To: <20111124090514.GW19986@pengutronix.de>
References: <4ECCDAA2.4070502@prolan.hu>
 <CAOMZO5DSvLU0ACJPZ69tzY0PjMijibSzwCEwBhu=5=mg7ncF=g@mail.gmail.com>
 <20111123183640.GQ19986@pengutronix.de>
 <20111123225124.GK9581@n2100.arm.linux.org.uk>
 <20111124071406.GS19986@pengutronix.de>
 <20111124090141.GN9581@n2100.arm.linux.org.uk>
 <20111124090514.GW19986@pengutronix.de>
Message-ID: <20111124102909.GO9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 10:05:14AM +0100, Uwe Kleine-K?nig wrote:
> On Thu, Nov 24, 2011 at 09:01:41AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 24, 2011 at 08:14:06AM +0100, Uwe Kleine-K?nig wrote:
> > > On Wed, Nov 23, 2011 at 10:51:24PM +0000, Russell King - ARM Linux wrote:
> > > > So really, there's no excuse not to fix this for the imx/mxwhatever SoCs
> > > > today - the clk framework is totally irrelevant as far as this goes.
> > > I think doing the clk_prepare seperation and converting to the clk
> > > framework in one step will be easier.
> > 
> > From a point of view of being able to separate the changes so there isn't
> > a flag day, you're wrong.  clk_prepare() is already present in the kernel
> > as dummy functions, and all you need to do at this point is arrange for
> > the drivers to make the appropriate calls.  There's no need to write one
> > line of code behind clk_prepare() at the current time.
> Yeah, but adding clk_prepare to the serial driver doesn't help me to get
> rid of the BUG reported in this thread without giving it some meaning in
> the platform, right?

So, let's be honest about why this bug isn't being fixed then.  Your
attitude to this problem is ignore it and to do nothing, rather than
trying to fix it via a perfectly good transition path provided for
you.

Okay, now we can see clearly why the bug is still there.  Thanks.

Given such an attitude, remind me why I should care whether iMX breaks
while we do the consolidation and cleanup work to core code, such as
the recent restart changes.
