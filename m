From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2009 10:43:54 +0000
Subject: [PATCH 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
In-Reply-To: <alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
	<20091203100707.1203.98247.stgit@localhost.localdomain>
	<20091203102700.GA30423@flint.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
Message-ID: <20091203104354.GB20379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 03:36:48AM -0700, Paul Walmsley wrote:
> Hello Russell,
> 
> On Thu, 3 Dec 2009, Russell King wrote:
> 
> > On Thu, Dec 03, 2009 at 03:07:08AM -0700, Paul Walmsley wrote:
> > > -static int clk_omap1_dummy_enable(struct clk *clk)
> > > +int clk_omap1_dummy_enable(struct clk *clk)
> > >  {
> > >  	return 0;
> > >  }
> > >  
> > > -static void clk_omap1_dummy_disable(struct clk *clk)
> > > +void clk_omap1_dummy_disable(struct clk *clk)
> > >  {
> > >  }
> > >  
> > > -static const struct clkops clkops_dummy = {
> > > -	.enable = clk_omap1_dummy_enable,
> > > -	.disable = clk_omap1_dummy_disable,
> > > -};
> > 
> > I've no idea why you're moving the clkops into these other files - I think
> > this is going far too far.  Why not just make the clkops structures non-
> > static?
> 
> clkops that are shared between multiple platforms, such as clkops_null, 
> are indeed non-static.  However, many of the clkops are only used by one 
> OMAP variant, so it seemed pointless to make them non-static.  No point in 
> polluting the symbol table unnecessarily.  Is there some reason that all 
> of them should be non-static?

You say this, but you're keeping the associated code around as well
which is pointless.

You also say about polluting the symbol table unnecessarily.  What
about the pollution caused by having two (or more) functions made
public rather than just one data structure?
