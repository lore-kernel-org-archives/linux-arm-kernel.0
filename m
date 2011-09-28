From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 28 Sep 2011 16:57:32 +0800
Subject: [PATCH v3 4/6] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <20110928062945.GC14191@pengutronix.de>
References: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
	<1317021651-17359-5-git-send-email-shawn.guo@linaro.org>
	<20110926110634.GR31404@pengutronix.de>
	<20110927134401.GE17997@S2100-06.ap.freescale.net>
	<20110927151546.GF17997@S2100-06.ap.freescale.net>
	<20110928062945.GC14191@pengutronix.de>
Message-ID: <20110928085730.GA18819@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 08:29:45AM +0200, Sascha Hauer wrote:
> On Tue, Sep 27, 2011 at 11:15:47PM +0800, Shawn Guo wrote:
> > > 
> > > I do not want to add mxc_cpu_type and cpu_is_mx6q() stuff, so I intend
> > > to remove early_initcall there, and let imx31/35_soc_init() explicitly
> > > calls mxc_init_l2x0().
> > > 
> > I'm changing my mind (so quickly).  It turns out we will fall into a
> > number of other traps if we build imx6q with imx3 without mxc_cpu_type
> > set up for imx6q, arch_idle(), __imx_ioremap(), etc.  So for now, I
> > want to add mxc_cpu_type for imx6q to cooperate with all these traps.
> 
> I'm fine with reducing the usage of cpu_is_* macros up to the point when
> we don't need them anymore. But as you already found out, it's better to
> do this seperately.
> 
I'm changing my mind again.  I decided to clean up these traps with a
patch series, which I'm sending right now.

-- 
Regards,
Shawn
