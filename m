From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Jun 2014 14:53:03 +0800
Subject: [PATCH 1/1] clk-imx35: Add clko clock support
In-Reply-To: <2789534.qY6c0ymzGl@ws-stein>
References: <1402990063-26908-1-git-send-email-alexander.stein@systec-electronic.com>
 <20140620081546.GG28225@dragon> <2789534.qY6c0ymzGl@ws-stein>
Message-ID: <20140625065302.GB2224@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 08:21:49AM +0200, Alexander Stein wrote:
> > > @@ -49,6 +49,13 @@ static struct clk_onecell_data clk_data;
> > >  
> > >  static const char *std_sel[] = {"ppll", "arm"};
> > >  static const char *ipg_per_sel[] = {"ahb_per_div", "arm_per_div"};
> > > +static const char *clko_select[] = {"ckil", "osc", "osc_audio", "dummy",
> > > +				 "mpll_075", "mpll", "ppll", "arm",
> > > +				 "ahb", "ipg", "ipg_per", "usbdiv",
> > > +				 "esdhc1_div", "ssi1_div_post", "mlb_gate",
> > > +				 "mshc_gate", "mpll_lock", "csi_div",
> > > +				 "spdif_div_post", "uart1_gate", "asrc",
> > > +				 "dptc", "arm_ungated", "nfc_div", "hsp"};
> > 
> > Any new string you add here should have a corresponding clk in clock
> > framework.
> 
> Ew, ok... As lots of those clocks are not (yet?) supported in the clock framework this list will contains many "dummy" entries, but well I get your point.
> 

Right.  Either you do not create the string or you create the clock
behind the string together.

...

> > > @@ -260,6 +273,7 @@ int __init mx35_clocks_init(void)
> > >  	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
> > >  	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
> > >  	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
> > > +	clk_register_clkdev(clk[clko_gate], NULL, "clko.0");
> > 
> > Will this lookup be used somewhere?
> 
> Well, as this is a pretty customizable output clock signal, I think this will only be used in custom board implementation. Or is there any generic driver to configure an arbitrary programmable clock?
> 

I prefer to add this lookup only when there is an in-tree user for it.

Shawn
