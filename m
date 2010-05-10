From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 May 2010 13:17:17 -0700
Subject: [PATCH 12/18] OMAP3 : clock data: Update name string for EMAC
	clocks
In-Reply-To: <20100505200222.GC29604@atomide.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
	<20100505193308.21568.98880.stgit@baageli.muru.com>
	<20100505194556.GB17678@n2100.arm.linux.org.uk>
	<20100505200222.GC29604@atomide.com>
Message-ID: <20100510201717.GF16460@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100505 12:59]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100505 12:41]:
> > On Wed, May 05, 2010 at 12:33:09PM -0700, Tony Lindgren wrote:
> > > The emac driver uses generic name for the module and phy
> > > clocks. Updated the omap3xxx_clks table to match the names
> > > used by the Davinci emac driver.
> > 
> > Patch doesn't match description.
> 
> Sriramakrishnan, can you please update the patch for better
> description?

Never mind, running out of time waiting. Updated patch below.
 
> > IMHO "ick" and "fck" are generic names, whereas "emac_clk" and
> > "phy_clk" are specific names.
> > 
> > > -	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
> > > -	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
> > > +	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
> > > +	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
> 
> Yeah as Paul pointed out too, there should be a follow-up patch
> to fix there clock names in drivers/net/davinci_emac.c, mach-davinci/dm646x.c,
> mach-davinci/da850.c, and mach-omap2/clock3xxx_data.c.
> 
> That should also be mentioned in the patch description.

Added a note for that too.

Tony
