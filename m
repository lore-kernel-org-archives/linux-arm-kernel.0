From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 19:11:56 -0500 (EST)
Subject: [PATCH v2 4/4] irqchip: gic: Perform the gic_secondary_init()
 call via CPU notifier
In-Reply-To: <20130129231205.GA25176@MacBook-Pro.local>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
 <1359476319-23720-5-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1301291734140.6300@xanadu.home>
 <20130129231205.GA25176@MacBook-Pro.local>
Message-ID: <alpine.LFD.2.02.1301291907340.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jan 2013, Catalin Marinas wrote:

> On Tue, Jan 29, 2013 at 10:35:46PM +0000, Nicolas Pitre wrote:
> > On Tue, 29 Jan 2013, Catalin Marinas wrote:
> > 
> > > All the calls to gic_secondary_init() pass 0 as the first argument.
> > > Since this function is called on each CPU when starting, it can be done
> > > in a platform-independent way via a CPU notifier registered by the GIC
> > > code.
> > >
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Acked-by: Stephen Warren <swarren@nvidia.com>
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Acked-by: Rob Herring <rob.herring@calxeda.com>
> > > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > > Tested-by: Simon Horman <horms+renesas@verge.net.au>
> > > Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: David Brown <davidb@codeaurora.org>
> > > Cc: Bryan Huntsman <bryanh@codeaurora.org>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: Dinh Nguyen <dinguyen@altera.com>
> > > Cc: Shiraz Hashim <shiraz.hashim@st.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Thanks.
> 
> > What is your plan in terms of merge path and schedule?  My mcpm series
> > would depend on this.
> 
> I would like to get them in as soon as possible (ideally 3.9) as AArch64
> needs GIC support. I can base them on Rob's branch (already in -next)
> and send them the same route (the arm-soc tree if Olof/Arnd are ok to
> take them).

Well...  I'd prefer if my series was merged by RMK since this is mostly 
core ARM code.  That is posing dependency issues.

I think I'll just ignore your change for now and we'll fix things up 
during the v3.9-rc period.


Nicolas
