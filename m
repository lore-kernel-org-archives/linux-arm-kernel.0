From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 May 2014 17:11:48 +0800
Subject: [PATCH] ARM: clk: imx: remove the CLK_SET_RATE_NO_REPARENT for
 imx_clk_mux_flags
In-Reply-To: <1401095002.3400.5.camel@paszta.hi.pengutronix.de>
References: <1401089474-14346-1-git-send-email-b32955@freescale.com>
 <1401095002.3400.5.camel@paszta.hi.pengutronix.de>
Message-ID: <20140526091147.GG2650@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 11:03:22AM +0200, Philipp Zabel wrote:
> > @@ -108,8 +108,7 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
> >  		int num_parents, unsigned long flags)
> >  {
> >  	return clk_register_mux(NULL, name, parents, num_parents,
> > -			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
> > -			&imx_ccm_lock);
> > +			flags, reg, shift, width, 0, &imx_ccm_lock);
> >  }
> >  
> >  static inline struct clk *imx_clk_fixed_factor(const char *name,
> 
> We need CLK_SET_RATE_NO_REPARENT on the audio/video multiplexers.
> I think this change is the right thing for imx_clk_mux_flags, but at the
> same you should make sure not to drop this flag where we want to control
> a video PLL through the mux.

Philipp,

Are you saying that you see a different clock tree topology after this
change?

Shawn
