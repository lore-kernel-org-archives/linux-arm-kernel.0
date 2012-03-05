From: jason@lakedaemon.net (Jason)
Date: Mon, 5 Mar 2012 14:15:46 -0500
Subject: [PULL REQUEST v2] ARM: kirkwood: fdt: convert kirkwood init
 funcs to fdt
In-Reply-To: <alpine.LFD.2.02.1203051344130.31242@xanadu.home>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <20120302200034.GQ11986@titan.lakedaemon.net>
 <201203022035.44672.arnd@arndb.de>
 <201203022118.05796.arnd@arndb.de>
 <alpine.LFD.2.02.1203051344130.31242@xanadu.home>
Message-ID: <20120305191546.GK5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 01:49:35PM -0500, Nicolas Pitre wrote:
> On Fri, 2 Mar 2012, Arnd Bergmann wrote:
> 
> > On Friday 02 March 2012, Arnd Bergmann wrote:
> > > On Friday 02 March 2012, Jason wrote:
> > > > The following changes since commit 759a45185ac0e4dfaf8bbfcb390ec73aca4b7a34:
> > > > 
> > > >   ARM: kirkwood: convert uart0 to devicetree. (2012-02-27 16:21:44 +0000)
> > > > 
> > > > are available in the git repository at:
> > > >   git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_test
> > > > 
> > > 
> > > Applied to next/dt branch.
> > 
> > On second thought, I should probably wait for the maintainer to comment
> > as well ;-)
> > 
> > Nico, does this look ok to you?
> 
> The clock frequency part being hardcoded to 200000 in the common .dtsi 
> file looks wrong.  The clock may differ, and it used to (and should) be 
> probed at run time, please see kirkwood_find_tclk().

So, should I EXPORT_SYMBOL_GPL(kirkwood_find_tclk); and have each driver
call it?

One alternate idea I had was to have kirkwood-dreamplug.dts root hold

tclk: clock-frequency = <200000000>;

and then have the drivers ask for it.  afaict, tclk is constant per
board.

I'm fine with either way, but I'd rather have it in the dt.

thx,

Jason.
