From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Apr 2011 11:57:45 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110425020348.GA6540@shlinux1.ap.freescale.net>
References: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
	<20110421123542.GE11788@opensource.wolfsonmicro.com>
	<20110425020348.GA6540@shlinux1.ap.freescale.net>
Message-ID: <20110425105744.GA30859@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 10:03:49AM +0800, Richard Zhao wrote:
> On Thu, Apr 21, 2011 at 01:35:42PM +0100, Mark Brown wrote:

> > Please bear in mind that due to the fact that we've currently got one
> > clock implementation per subarchitecture anything off-SoC has some
> > serious barriers to implementation in kernel.  For the system management
> > units you'd be looking at very new systems, this is a new development.

> How many arch have off-soc clocks? Where's the source? 
> At least for arm, nearly all is memory mapped clock registers. clk is free
> to override, we just need abstract the most common things.

Even for many ARMs it's common for the clock tree to be rooted in the
PMIC (since it will always be on), and of course the full system clock
tree will not just include the CPU but also any other digital components
in the system.
