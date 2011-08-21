From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 21 Aug 2011 19:25:04 +0200
Subject: [PATCH 1/4] S3C2443: Move i2s clock definitions to common code
In-Reply-To: <20110821171332.GF28546@n2100.arm.linux.org.uk>
References: <201108201757.56483.heiko@sntech.de>
	<201108201801.29541.heiko@sntech.de>
	<20110821171332.GF28546@n2100.arm.linux.org.uk>
Message-ID: <201108211925.05300.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 21 August 2011, 19:13:32 schrieb Russell King - ARM Linux:
> On Sat, Aug 20, 2011 at 06:01:29PM +0200, Heiko St?bner wrote:
> > +/* i2s-ref
> > + *
> > + * i2s bus reference clock, selectable from external, esysclk or epllref
> > + *
> > + * Note, this used to be two clocks, but was compressed into one.
> > +*/
> > +
> > +struct clk *clk_i2s_srclist[] = {
> > +	[0] = &clk_i2s_eplldiv.clk,
> > +	[1] = &clk_i2s_ext,
> > +	[2] = &clk_epllref.clk,
> > +	[3] = &clk_epllref.clk,
> > +};
> 
> Is there any reason not to make this static (have you run your patch
> through checkpatch.pl ?)
Yep I did run all of them through checkpatch (after beeing scolded last time) 
and it didn't report anything.

But for this move of code I simply grabbed the code fragments and put them 
into their new location (i.e. it was this way in mach-s3c2443/clock.c) and 
should have probably taken a closer look at what I'm moving.

So it seems you are right, it should probably be static as everything else is 
also static.

Heiko
