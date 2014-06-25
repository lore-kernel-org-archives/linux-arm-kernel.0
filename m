From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Jun 2014 21:12:35 +0800
Subject: [PATCH 1/1] clk-imx35: Add clko clock support
In-Reply-To: <1857714.L0sRRUOXiN@ws-stein>
References: <1402990063-26908-1-git-send-email-alexander.stein@systec-electronic.com>
 <2789534.qY6c0ymzGl@ws-stein> <20140625065302.GB2224@dragon>
 <1857714.L0sRRUOXiN@ws-stein>
Message-ID: <20140625131234.GF2224@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 10:58:12AM +0200, Alexander Stein wrote:
> > > > > @@ -260,6 +273,7 @@ int __init mx35_clocks_init(void)
> > > > >  	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
> > > > >  	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
> > > > >  	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
> > > > > +	clk_register_clkdev(clk[clko_gate], NULL, "clko.0");
> > > > 
> > > > Will this lookup be used somewhere?
> > > 
> > > Well, as this is a pretty customizable output clock signal, I think this will only be used in custom board implementation. Or is there any generic driver to configure an arbitrary programmable clock?
> > > 
> > 
> > I prefer to add this lookup only when there is an in-tree user for it.
> 
> Well, the cko (cko1 and cko2) clocks on i.MX6 are also added. Though I can't find any user of that. So why addind it despite that?
> 

To be clear, I'm not talking about the cko clock itself but the lookup
to cko, i.e. clk_register_clkdev() of "clko.0".

Shawn
