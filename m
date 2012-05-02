From: mturquette@ti.com (Mike Turquette)
Date: Tue, 1 May 2012 18:56:50 -0700
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120501181922.GD4089@opensource.wolfsonmicro.com>
References: <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
 <20120426095135.GG17184@pengutronix.de>
 <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
 <20120501091334.GG15541@lunn.ch>
 <20120501170001.GB4089@opensource.wolfsonmicro.com>
 <4FA0258D.8020807@codeaurora.org>
 <20120501181922.GD4089@opensource.wolfsonmicro.com>
Message-ID: <20120502015650.GE17311@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120501-19:19, Mark Brown wrote:
> On Tue, May 01, 2012 at 11:03:57AM -0700, Saravana Kannan wrote:
> 
> > Sorry for the annoyance I seem to have caused. I too have been
> > trying to get this in for a while before the other platforms started
> > using the new framework. Not everyone was free at the same time and
> > it's taken longer that I would have wished for.
> 
> > I did my best to limit the changes that would be needed without
> > making my patch useless. Appreciate your understanding.
> 
> To be honest it doesn't look like your patch is a particular issue here
> - there's wider process problems, for example we've managed to go
> through most of the release cycle and so far the only changes showing up
> in -next are:

I think that "wider process problems" is probably a euphemism, and I'll
take responsibility for that.  This has been a learning process for me
and I underestimated the percentage of my time that would be consumed by
common clk maintenance.  I'm trying to rectify that problem now.

> 
> Viresh Kumar (6):
>       SPEAr: clk: Add VCO-PLL Synthesizer clock
>       SPEAr: clk: Add Auxiliary Synthesizer clock
>       SPEAr: clk: Add Fractional Synthesizer clock
>       SPEAr: clk: Add General Purpose Timer Synthesizer clock
>       SPEAr: Switch to common clock framework
>       SPEAr13xx: Add common clock framework support
> 
> Mark Brown (1):
>       ARM: 7376/1: clkdev: Implement managed clk_get()
> 
> Sascha Hauer (1):
>       clk: add a fixed factor clock
> 
> viresh kumar (1):
>       ARM: 7392/1: CLKDEV: Optimize clk_find()
> 
> and obviously there's quite a bit more work which has been going on.

I could use some suggestions on the best way to resolve the merge issues
we have currently.  It appears that we have three bases that platforms
need to port over the common clk framework:

Russell's clkdev
Arnd's arm-soc
My clk-next branch

I was happy to push my changes to Linus directly (as discussed in
previous mails) but I'm starting to think that maybe having Arnd absorb
the clk-next branch as part of arm-soc would be the fastest way to
assist platforms that are porting over.

Do the platform folks agree?  Is this suggestion sane?

Thanks,
Mike
