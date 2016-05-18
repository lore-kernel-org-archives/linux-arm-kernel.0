From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 18 May 2016 18:27:24 +0200
Subject: [PATCH 15/16] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <20160518140200.GN27618@lukather>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
 <20160513114559.786221e415ce5956e161dd5b@free.fr>
 <20160518140200.GN27618@lukather>
Message-ID: <20160518182724.bf9137a9c04ac670457fc083@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Sorry, my previous mail was sent while not finished!

On Wed, 18 May 2016 16:02:00 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Fri, May 13, 2016 at 11:45:59AM +0200, Jean-Francois Moine wrote:
	[snip]
> > > +static const char * const nand_parents[] = { "osc24M", "pll-periph0",
> > > +					     "pll-periph1" };
> > > +static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", nand_parents, 0x080,
> > > +				  0, 4,		/* M */
> > > +				  16, 2,	/* P */
> > > +				  24, 2,	/* mux */
> > > +				  BIT(31),	/* gate */
> > > +				  0);
> > 
> > The mux width is 2, meaning there may be 4 parents. Then, there may be
> > an access out of the parent array (and same for mmcx and spix).
> 
> The mux relies on the number of parents registered in the clock
> framework, which is 3 in this case, so that won't happen.
> 
> Or am I missing what you're saying?

Sorry, at this time, I did not look yet at the macros.
There is no problem here.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
