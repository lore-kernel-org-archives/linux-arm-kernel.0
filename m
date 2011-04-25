From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Apr 2011 15:44:51 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110425144132.GA1873@richard-laptop>
References: <20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
	<20110421123542.GE11788@opensource.wolfsonmicro.com>
	<20110425020348.GA6540@shlinux1.ap.freescale.net>
	<20110425105744.GA30859@opensource.wolfsonmicro.com>
	<20110425144132.GA1873@richard-laptop>
Message-ID: <20110425144451.GB31523@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 10:41:32PM +0800, Richard Zhao wrote:
> On Mon, Apr 25, 2011 at 11:57:45AM +0100, Mark Brown wrote:

> > Even for many ARMs it's common for the clock tree to be rooted in the
> > PMIC (since it will always be on), and of course the full system clock
> > tree will not just include the CPU but also any other digital components
> > in the system.

> Yes, I see pmic or other on-board osc may be clock source. I just didn't realize
> anyone will put them to clk. 

My point here is that right now nobody does anything like that unless
they really have to in part because this then makes the driver for the
off-SoC chip get tied in to the chip clock structure.
