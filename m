From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 09:31:26 +0000
Subject: [PATCH v2 05/10] arm: zynq: Move slcr initialization to separate
 file
In-Reply-To: <20130327065551.GC16139@pengutronix.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303262143.23708.arnd@arndb.de> <20130327065551.GC16139@pengutronix.de>
Message-ID: <201303270931.26351.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Steffen Trumtrar wrote:
> On Tue, Mar 26, 2013 at 09:43:23PM +0000, Arnd Bergmann wrote:
> > On Tuesday 26 March 2013, Michal Simek wrote:
> > > Create separate slcr driver instead of pollute common code.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > 
> > Can't you move that code into the zynq_cpu_clk_setup function
> > instead, and only call of_clk_init(NULL) from platform code?
> > 
> if you are talking about the slcr function, than moving it into
> a separate file is the right move. This should actually become a
> real driver. The slcr is master over all clock, reset, pinmux and
> ddr registers. And as all those registers can be locked/unlocked
> via a slcr register (for whatever reason one would do that), there
> should be one master that controls this space.

Ok, I see. Thanks for the explanation. Should this be using the
drivers/mfd/syscon.c infrastructure then?

	Arnd
