From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Jan 2011 18:21:20 -0800
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110124215213.GA27044@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
	<20110124202629.GE13589@atomide.com>
	<20110124215213.GA27044@n2100.arm.linux.org.uk>
Message-ID: <20110125022119.GG13589@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110124 13:51]:
> On Mon, Jan 24, 2011 at 12:26:29PM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [110124 12:16]:
> > > 
> > > So far tested on zoom3 only, but the following gets it booting
> > > on top of your patch.
> > 
> > Looks like there are some other patches needed too.. At least
> > omap4 still fails with these.
> 
> From what I remember, the problem I saw on OMAP4 was hwmod related as
> it seemed to be using ioremap() - which with its initialization moved
> before memory allocators were up and running causes an oops.

To me it seems _find_mpu_rt_base should be moved to omap_hwmod_late_init
as we don't want to have a static mapping for everything. AFAIK the
oh->_mpu_rt_va should not be needed early.

Any comments on that Paul? See also the two patches I'll post as a reply
to this thread make omap_hwmod_late_init a core_initcall.

The issue for omap4 still needs to be sorted out. And then we can 
see which omap initcalls really need to be core_initcalls.

Regards,

Tony
