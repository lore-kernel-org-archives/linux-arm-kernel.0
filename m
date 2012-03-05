From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Mar 2012 20:16:26 +0000
Subject: [PULL REQUEST v2] ARM: kirkwood: fdt: convert kirkwood init funcs
 to fdt
In-Reply-To: <20120305191546.GK5050@titan.lakedaemon.net>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <alpine.LFD.2.02.1203051344130.31242@xanadu.home>
 <20120305191546.GK5050@titan.lakedaemon.net>
Message-ID: <201203052016.26949.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 March 2012, Jason wrote:
> > 
> > The clock frequency part being hardcoded to 200000 in the common .dtsi 
> > file looks wrong.  The clock may differ, and it used to (and should) be 
> > probed at run time, please see kirkwood_find_tclk().
> 
> So, should I EXPORT_SYMBOL_GPL(kirkwood_find_tclk); and have each driver
> call it?

If the drivers want to use it, I think it has to be orion_find_tclk for
drivers that are shared between multiple plat-orion platforms.

> One alternate idea I had was to have kirkwood-dreamplug.dts root hold
> 
> tclk: clock-frequency = <200000000>;
> 
> and then have the drivers ask for it.  afaict, tclk is constant per
> board.
> 
> I'm fine with either way, but I'd rather have it in the dt.

IMHO it's best to leave any such hacks out of the device tree for
now, until we have the proper clk bindings in place for kirkwood,
and then we can just use those.

	Arnd
