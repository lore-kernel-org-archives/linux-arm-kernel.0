From: linuxzsc@gmail.com (Richard Zhao)
Date: Mon, 25 Apr 2011 22:41:32 +0800
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110425105744.GA30859@opensource.wolfsonmicro.com>
References: <alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
	<20110421123542.GE11788@opensource.wolfsonmicro.com>
	<20110425020348.GA6540@shlinux1.ap.freescale.net>
	<20110425105744.GA30859@opensource.wolfsonmicro.com>
Message-ID: <20110425144132.GA1873@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 11:57:45AM +0100, Mark Brown wrote:
> On Mon, Apr 25, 2011 at 10:03:49AM +0800, Richard Zhao wrote:
> > On Thu, Apr 21, 2011 at 01:35:42PM +0100, Mark Brown wrote:
> 
> > > Please bear in mind that due to the fact that we've currently got one
> > > clock implementation per subarchitecture anything off-SoC has some
> > > serious barriers to implementation in kernel.  For the system management
> > > units you'd be looking at very new systems, this is a new development.
> 
> > How many arch have off-soc clocks? Where's the source? 
> > At least for arm, nearly all is memory mapped clock registers. clk is free
> > to override, we just need abstract the most common things.
> 
> Even for many ARMs it's common for the clock tree to be rooted in the
> PMIC (since it will always be on), and of course the full system clock
> tree will not just include the CPU but also any other digital components
> in the system.
Yes, I see pmic or other on-board osc may be clock source. I just didn't realize
anyone will put them to clk. 

Thanks
Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
