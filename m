From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Aug 2011 02:18:02 -0700
Subject: OMAP3 kernels fail to build
In-Reply-To: <20110810072712.GD14281@n2100.arm.linux.org.uk>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
	<4E3FC3EC.2010909@ti.com>
	<20110808113039.GB15134@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1108092318180.12674@utopia.booyaka.com>
	<20110810072712.GD14281@n2100.arm.linux.org.uk>
Message-ID: <20110810091802.GC1939@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110810 00:21]:
> On Tue, Aug 09, 2011 at 11:26:16PM -0600, Paul Walmsley wrote:
> > On Mon, 8 Aug 2011, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Aug 08, 2011 at 04:39:32PM +0530, Santosh wrote:
> > > > On Monday 08 August 2011 04:30 PM, Russell King - ARM Linux wrote:
> > > >> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
> > > >>
> > > >> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
> > > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
> > > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
> > > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
> > > >> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
> > > >>
> > > > I thought below patch was suppose to fix it.
> > > > https://patchwork.kernel.org/patch/963462/
> > > 
> > > So, the problem has been known about for around a month.  Yet the broken
> > > patch still went upstream.
> > 
> > Which known "broken patch still went upstream" ?
> > 
> > The problem commits were 208466dc10083e734a8af71d10f923ee4bff950c ("usb: 
> > otg: OMAP4430: Powerdown the internal PHY when USB is disabled") and 
> > fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430: Power down 
> > the PHY during board init").  The above link makes this clear.  
> 
> The fact that there are _build_ _errors_ indicate that a patch which
> introduced this crap _was_ _broken_.  The fact that it was _reported_
> as broken well before the merge window and still went in during the
> merge window indicates that the OMAP workflow with regard to patches
> is simply BROKEN.

Or people go on vacation and just drop the ball like I did :)

Anyways, the best way to detect issues like this would be to get
make randconfig working for ARM.. And then have some machines doing
that with next tree.

Tony
