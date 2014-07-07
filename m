From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 03:47:27 -0700
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
In-Reply-To: <20140702081142.GU28884@atomide.com>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
 <20140617131935.GB9070@saruman.home>
 <20140701194704.GG13396@saruman.home>
 <20140702081142.GU28884@atomide.com>
Message-ID: <20140707104727.GM28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140702 01:13]:
> * Felipe Balbi <balbi@ti.com> [140701 12:49]:
> > On Tue, Jun 17, 2014 at 08:19:35AM -0500, Felipe Balbi wrote:
> > > On Tue, Jun 17, 2014 at 04:04:51PM +0530, Sekhar Nori wrote:
> > > > ROM code on AM437x does not support writing to L2C-310 power control
> > > > register. The L2C driver, however, tries writing to this register for
> > > > all revisions >= r3p0.
> > > > 
> > > > This leads to a warning dump on boot which leads most users to believe
> > > > that L2 cache is non-functional.
> > > > 
> > > > Since the problem is understood, and cannot be addressed through software,
> > > > replace the warning with a pr_info() while maintaining the WARN_ON() for
> > > > other truly unexpected scenarios.
> > > > 
> > > > Reported-by: Nishanth Menon <nm@ti.com>
> > > > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > > 
> > > Tested with today's linux-next
> > > (5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) with am437x-sk, I can see
> > > that the WARNING goes away.
> > > 
> > > Tested-by: Felipe Balbi <balbi@ti.com>
> > 
> > ping here, I can't see this patch onl linus/master or next/master yet.
> 
> Sorry I've been waiting for my pull request against -rc1 to get
> merged first, no idea why that is still pending.

That's now merged into v3.16-rc4, so applying this into
omap-for-v3.16/fixes.

Regards,

Tony
