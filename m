From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 10:04:14 +0000
Subject: [PATCH WIP] ARM: kirkwood: covert orion-spi to fdt.
In-Reply-To: <20120228094059.GA27255@lunn.ch>
References: <20120228094059.GA27255@lunn.ch>
Message-ID: <201202281004.14366.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2012, Andrew Lunn wrote:
> I think this code belongs on the board-dts.c file. kirkwood_clk_ctrl
> is a global so can be set from anywhere. It is also set in other files
> than common.c, eg pcie.c.

Ok, that makes sense.

> In the end, i hope this all goes away. I have patches based on Mike's
> generic clk infrastructure, which adds clk/clkdev to all orion based
> machines. So the SPI driver, in its probe function will get its clock,
> enable it, and also find out the speed of it. The release function
> also disables the clock, turning it off if nobody else is using it. 
> 
> I just hope the generic clk does not take too long to land.

Excellent, that will of course be the best solution in the long run.

	Arnd
