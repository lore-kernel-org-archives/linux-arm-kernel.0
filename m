From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 12:18:19 +0200
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <20120614100425.GC28714@n2100.arm.linux.org.uk>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
 <20120613221040.GJ30400@pengutronix.de>
 <20120614100425.GC28714@n2100.arm.linux.org.uk>
Message-ID: <20120614101819.GR30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 11:04:25AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 14, 2012 at 12:10:40AM +0200, Sascha Hauer wrote:
> > As the netx does not have fb support in mainline you can just drop this
> > one aswell. It has no use.
> 
> Are you sure?
> 
> Grepping for clcd in arch/arm/mach-netx shows that nxdb500 and nxeb500hmi
> seem to have all the necessary stuff to support the AMBA CLCD driver.

Damn, you are right. I wasn't aware the netx has a AMBA cell and just
grepped for netx in drivers/video.
In this case I suggest to just return NULL for every clock.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
