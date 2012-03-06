From: jason@lakedaemon.net (Jason)
Date: Tue, 6 Mar 2012 09:29:20 -0500
Subject: [PULL REQUEST v2] ARM: kirkwood: fdt: convert kirkwood init
 funcs to fdt
In-Reply-To: <alpine.LFD.2.02.1203051626370.31242@xanadu.home>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <alpine.LFD.2.02.1203051344130.31242@xanadu.home>
 <20120305191546.GK5050@titan.lakedaemon.net>
 <201203052016.26949.arnd@arndb.de>
 <20120305202941.GN5050@titan.lakedaemon.net>
 <alpine.LFD.2.02.1203051542190.31242@xanadu.home>
 <20120305211737.GO5050@titan.lakedaemon.net>
 <alpine.LFD.2.02.1203051626370.31242@xanadu.home>
Message-ID: <20120306142920.GQ5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 04:27:27PM -0500, Nicolas Pitre wrote:
> On Mon, 5 Mar 2012, Jason wrote:
> 
> > On Mon, Mar 05, 2012 at 03:43:42PM -0500, Nicolas Pitre wrote:
> > > On Mon, 5 Mar 2012, Jason wrote:
> > > 
> > > > On Mon, Mar 05, 2012 at 08:16:26PM +0000, Arnd Bergmann wrote:
> > > > > On Monday 05 March 2012, Jason wrote:
> > > > > > > 
> > > > > > > The clock frequency part being hardcoded to 200000 in the common .dtsi 
> > > > > > > file looks wrong.  The clock may differ, and it used to (and should) be 
> > > > > > > probed at run time, please see kirkwood_find_tclk().
> > > > > > 
> > > > > > So, should I EXPORT_SYMBOL_GPL(kirkwood_find_tclk); and have each driver
> > > > > > call it?
> > > > > 
> > > > > If the drivers want to use it, I think it has to be orion_find_tclk for
> > > > > drivers that are shared between multiple plat-orion platforms.
> > > > 
> > > > That's pretty much all of them  :-)
> > > > 
> > > > I'll rename it and move it to plat-orion/common.c.  This'll be fun.
> > > 
> > > No no...  This is not a function which is generic at all.  The _result_ 
> > > i.e. core clock frequency value is a generic thing, not the method to 
> > > determine it.
> > 
> > How about this?  Export a global variable, orion_tclk, and a function to
> > read it.  Then, make sure each sub arch sets the global.  Does this
> > sound viable until common clk lands?
> 
> Yep, looks fine.

I just got a first look at Andrew's patches for using the generic clk
across plat/orion.  There's a lot of good stuff in there.  I'll start
building my series on top of his (and obviously Mike's clk series).

thx,

Jason.
