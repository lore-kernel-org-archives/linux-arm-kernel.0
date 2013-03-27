From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 27 Mar 2013 07:55:51 +0100
Subject: [PATCH v2 05/10] arm: zynq: Move slcr initialization to separate
 file
In-Reply-To: <201303262143.23708.arnd@arndb.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <dc278dadd3614b4736f43a09b9c5d7ccd2232403.1364319776.git.michal.simek@xilinx.com>
 <201303262143.23708.arnd@arndb.de>
Message-ID: <20130327065551.GC16139@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Mar 26, 2013 at 09:43:23PM +0000, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Michal Simek wrote:
> > Create separate slcr driver instead of pollute common code.
> > 
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Can't you move that code into the zynq_cpu_clk_setup function
> instead, and only call of_clk_init(NULL) from platform code?
> 
if you are talking about the slcr function, than moving it into
a separate file is the right move. This should actually become a
real driver. The slcr is master over all clock, reset, pinmux and
ddr registers. And as all those registers can be locked/unlocked
via a slcr register (for whatever reason one would do that), there
should be one master that controls this space.

> I would like to eventually add a default call to of_clk_init(NULL)
> for all platforms, and that would be a step in that direction.
> 

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
