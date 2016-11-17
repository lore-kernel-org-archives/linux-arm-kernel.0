From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Nov 2016 18:10:37 +0000
Subject: [PATCH v4 1/5] arm64: perf: Basic uncore counter support for
 Cavium ThunderX SOC
In-Reply-To: <20161111103029.GD16907@hardcore>
References: <cover.1477741719.git.jglauber@cavium.com>
 <73173d6ad2430eead5e9da40564a90a60961b6d9.1477741719.git.jglauber@cavium.com>
 <20161108235010.GC17771@arm.com> <20161111103029.GD16907@hardcore>
Message-ID: <20161117181036.GS22855@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 11:30:29AM +0100, Jan Glauber wrote:
> On Tue, Nov 08, 2016 at 11:50:10PM +0000, Will Deacon wrote:
> > On Sat, Oct 29, 2016 at 01:55:29PM +0200, Jan Glauber wrote:
> > > +/* node attribute depending on number of NUMA nodes */
> > > +static ssize_t node_show(struct device *dev, struct device_attribute *attr,
> > > +			 char *page)
> > > +{
> > > +	if (NODES_SHIFT)
> > > +		return sprintf(page, "config:16-%d\n", 16 + NODES_SHIFT - 1);
> > 
> > If NODES_SHIFT is 1, you'll end up with "config:16-16", which might confuse
> > userspace.
> 
> So should I use "config:16" in that case? Is it OK to use this also for
> NODES_SHIFT=0 ?

If you only need one bit, then "config:16" is the right thing to do.

Will
