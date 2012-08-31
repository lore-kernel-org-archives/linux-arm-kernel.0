From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 31 Aug 2012 15:07:23 +0200
Subject: [PATCH 8/9] ARM i.MX53: Add pwms to dtsi
In-Reply-To: <20120830223219.GF3613@r65073-Latitude-D630>
References: <1346154504-5623-1-git-send-email-s.hauer@pengutronix.de>
 <1346154504-5623-9-git-send-email-s.hauer@pengutronix.de>
 <20120830223219.GF3613@r65073-Latitude-D630>
Message-ID: <20120831130723.GS26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 06:32:20AM +0800, Shawn Guo wrote:
> On Tue, Aug 28, 2012 at 01:48:23PM +0200, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Conflicts:
> > 	arch/arm/mach-imx/clk-imx51-imx53.c
> 
> Yeah, I know you have sorted out conflicts :)

:)

> 
> > ---
> >  arch/arm/boot/dts/imx53.dtsi        |   14 ++++++++++++++
> >  arch/arm/mach-imx/clk-imx51-imx53.c |    4 ++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> > index cd37165..7ec17e4 100644
> > --- a/arch/arm/boot/dts/imx53.dtsi
> > +++ b/arch/arm/boot/dts/imx53.dtsi
> > @@ -189,6 +189,20 @@
> >  				status = "disabled";
> >  			};
> >  
> > +			pwm1: pwm at 53fb4000 {
> > +				#pwm-cells = <3>;
> 
> pwm-cells should be 2?

Yes, right. We have a patch internally that allows us to pass a
'inverted' flag to the pwm, hence I accidently have 3 here.

> >  	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "63fcc000.ssi");
> >  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "50014000.ssi");
> >  	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "63fd0000.ssi");
> > +	clk_register_clkdev(clk[pwm1_ipg_gate], "ipg", "53fb4000.pwm");
> > +	clk_register_clkdev(clk[pwm1_hf_gate], "per", "53fb4000.pwm");
> > +	clk_register_clkdev(clk[pwm2_ipg_gate], "ipg", "53fb8000.pwm");
> > +	clk_register_clkdev(clk[pwm2_hf_gate], "per", "53fb8000.pwm");
> 
> It should be in a separate patch?

Should it? Surely I can do this, I had the feeling though that it
belongs together.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
