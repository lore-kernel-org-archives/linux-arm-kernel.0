From: jason@lakedaemon.net (Jason)
Date: Tue, 28 Feb 2012 10:06:03 -0500
Subject: [PATCH WIP] ARM: kirkwood: covert orion-spi to fdt.
In-Reply-To: <201202281004.14366.arnd@arndb.de>
References: <20120228094059.GA27255@lunn.ch> <201202281004.14366.arnd@arndb.de>
Message-ID: <20120228150603.GY23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 10:04:14AM +0000, Arnd Bergmann wrote:
> On Tuesday 28 February 2012, Andrew Lunn wrote:
> > I think this code belongs on the board-dts.c file. kirkwood_clk_ctrl
> > is a global so can be set from anywhere. It is also set in other files
> > than common.c, eg pcie.c.
> 
> Ok, that makes sense.

Yes, my goal is to eventually eliminate common.c, pcie.c, etc.  If we do
it right, kirkwood_clock_gate() won't be necessary.

> > In the end, i hope this all goes away. I have patches based on Mike's
> > generic clk infrastructure, which adds clk/clkdev to all orion based
> > machines. So the SPI driver, in its probe function will get its clock,
> > enable it, and also find out the speed of it. The release function
> > also disables the clock, turning it off if nobody else is using it. 
> > 
> > I just hope the generic clk does not take too long to land.
> 
> Excellent, that will of course be the best solution in the long run.

Agreed.

thx,

Jason.
