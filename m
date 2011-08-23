From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 23 Aug 2011 22:28:49 +0200
Subject: [PATCH 1/4] S3C2443: Move i2s clock definitions to common code
In-Reply-To: <06c001cc6146$b9f30be0$2dd923a0$%kim@samsung.com>
References: <201108201757.56483.heiko@sntech.de>
	<201108211925.05300.heiko@sntech.de>
	<06c001cc6146$b9f30be0$2dd923a0$%kim@samsung.com>
Message-ID: <201108232228.49647.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag 23 August 2011, 05:42:47 schrieb Kukjin Kim:
> Heiko St?bner wrote:
> > Am Sonntag 21 August 2011, 19:13:32 schrieb Russell King - ARM Linux:
> > > On Sat, Aug 20, 2011 at 06:01:29PM +0200, Heiko St?bner wrote:
> > > > +/* i2s-ref
> > > > + *
> > > > + * i2s bus reference clock, selectable from external, esysclk or
> 
> epllref
> 
> > > > + *
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
> 
> time)
> 
> > and it didn't report anything.
> 
> Hmm...as a note, happened following with checkpatch.pl :(
> 
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #35: FILE: arch/arm/mach-s3c2416/clock.c:57:
> +               .sources = (struct clk *[]) {
>                                        ^
> 
> total: 1 errors, 0 warnings, 38 lines checked
> 
> PATCH 34 S3C2416 Add HSSPI clock sourced from EPLL.txt has style problems,
> please review.
will do.

Today I also saw, that my definition of the hsspi pclk would have caused a 
conflict with the hsspi sclk definition of s3c2443.

So, as nobody uses the s3c2443's hsspi controller yet, I would also rename it 
to hsspi-if with the next patch iteration.


Heiko
