From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Jul 2011 12:07:59 +0200
Subject: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
In-Reply-To: <20110711093124.GA3239@n2100.arm.linux.org.uk>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<20110711093124.GA3239@n2100.arm.linux.org.uk>
Message-ID: <20110711100759.GG26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 10:31:24AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
> > The biggest issue I ran into was that as the clocks are all registered
> > by name with the API if you've got two instances of the same off-SoC
> > device in the system you'll not be able to disambiguate between the
> > clocks it provides.
> 
> Sigh.  That sounds like yet more trash.  Obviously whoever thought
> up that doesn't actually understand clks.

Nope. In the patches Jeremy posted clocks have a name, but this name
is not meant to be used with clk_get. clk_get is still implemented
in clkdev, so the matching between clocks and devices is independent
of the clock name.

In earlier versions of Jeremys patches the clock name was only present
when debugfs was compiled in and I think it can be changed back to this.

That said the debugfs support (which is not present in Jeremys latest
series) would break if two clocks with the same name have the same
parent, because the clock core would try to create to debugfs entries
with the same name.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
