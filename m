From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 28 May 2014 18:17:10 +0200
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <20140528020531.7816.5349@quantum>
References: <20140521073457.GD31687@pengutronix.de>
 <9956925.Qsz2bH3rDg@vostro.rjw.lan> <20140528020531.7816.5349@quantum>
Message-ID: <1731476.hDvqXAW3JF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 27, 2014 07:05:31 PM Mike Turquette wrote:
> Quoting Rafael J. Wysocki (2014-05-26 04:22:32)
> > On Monday, May 26, 2014 11:59:09 AM Viresh Kumar wrote:
> > > On 23 May 2014 21:44, S?ren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> > > > Viresh: Could you imagine something similar for cpufreq? You suggested
> > > > migrating to Hz resolution. I guess that would ideally mean to follow
> > > > the CCF to a 64-bit type for frequencies and increasing the resolution.
> > > > I have a messy patch migrating cpufreq and OPP to Hz and unsigned long
> > > > that works on Zynq. But cpufreq has so many users that it would become
> > > > quite an undertaking.
> > > > And we'd need some new/amended OPP DT binding.
> > > 
> > > If we are going to migrate to Hz from KHz, I think we must consider the
> > > 64 bit stuff right now, otherwise it will bite us later.
> > > 
> > > @Rafael: What do you think?
> > 
> > I agree as far as the 64-bit thing goes, but is switching to Hz really
> > necessary?
> 
> Rafael,
> 
> Why should CPUfreq migrate to 64-bit if not switching to Hz? CPU clock
> rates are specified as KHz in CPUfreq via an unsigned int. On 32-bit
> systems that comes out to a max of 4.29THz (terahertz!)!
> 
> Or maybe you meant, "I agree that the clock framework should switch to
> the 64-bit thing"?

That should have been something like "If we were to switch to Hz
resolution, it would be necessary to switch over to 64-bit too".

> Personally I'd like to see the clock framework and cpufreq get on the
> same page (data type) for specifying clock rates, and the clock
> framework really should not use a granularity like KHz. In fact we have
> some fractional rates like 13.25Hz ...

Well, as I said.  There's a cost to that and it is not particularly
clear to me whether or not that cost is justifiable.  And some architectures
don't even use the clock framework for cpufreq, mind you.  How many of them
do, actually?

Rafael
