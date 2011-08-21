From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 21 Aug 2011 23:11:55 +0200
Subject: [PATCH 1/4] S3C2443: Move i2s clock definitions to common code
In-Reply-To: <201108212226.16669.marek.vasut@gmail.com>
References: <201108201757.56483.heiko@sntech.de>
	<201108211925.05300.heiko@sntech.de>
	<201108212226.16669.marek.vasut@gmail.com>
Message-ID: <201108212311.56046.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 21 August 2011, 22:26:16 schrieb Marek Vasut:
> On Sunday, August 21, 2011 07:25:04 PM Heiko St?bner wrote:
> > Am Sonntag 21 August 2011, 19:13:32 schrieb Russell King - ARM Linux:
> > > On Sat, Aug 20, 2011 at 06:01:29PM +0200, Heiko St?bner wrote:
> > > > +/* i2s-ref
> > > > + *
> > > > + * i2s bus reference clock, selectable from external, esysclk or
> > > > epllref + *
> > > > + * Note, this used to be two clocks, but was compressed into one.
> > > > +*/
> > > > +
> > > > +struct clk *clk_i2s_srclist[] = {
> > > > +	[0] = &clk_i2s_eplldiv.clk,
> > > > +	[1] = &clk_i2s_ext,
> > > > +	[2] = &clk_epllref.clk,
> > > > +	[3] = &clk_epllref.clk,
> > > > +};
> > > 
> > > Is there any reason not to make this static (have you run your patch
> > > through checkpatch.pl ?)
> > 
> > Yep I did run all of them through checkpatch (after beeing scolded last
> > time) and it didn't report anything.
> > 
> > But for this move of code I simply grabbed the code fragments and put
> > them into their new location (i.e. it was this way in
> > mach-s3c2443/clock.c) and should have probably taken a closer look at
> > what I'm moving.
> > 
> > So it seems you are right, it should probably be static as everything
> > else is also static.
> 
> And you don't really understand why everything else is static, right ? ;-)
yep :-) - until now

But a quick lookup did help [lifetime of the variable extends across the 
entire run of the program, i.e. a global variable and local to the source file 
it's defined in]. 

> (don't take it as an offense)
none taken ... in fact it was a welcome push to reread variable storage 
classes and lifetime again [last time was some years ago] :-).

Heiko
