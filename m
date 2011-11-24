From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 24 Nov 2011 09:17:25 +0100
Subject: [RFC PATCH 1/3] arm/imx6: describe clocks in device tree source
In-Reply-To: <20111124040128.GC17979@S2100-06.ap.freescale.net>
References: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
 <1321926536-671-2-git-send-email-shawn.guo@linaro.org>
 <20111122085649.GC27267@pengutronix.de>
 <20111124040128.GC17979@S2100-06.ap.freescale.net>
Message-ID: <20111124081725.GV27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 12:01:29PM +0800, Shawn Guo wrote:
> On Tue, Nov 22, 2011 at 09:56:49AM +0100, Sascha Hauer wrote:
> > On Tue, Nov 22, 2011 at 09:48:54AM +0800, Shawn Guo wrote:
> > > It adds document for imx clock device tree bindings and then describes
> > > imx6 clocks in dts.
> > > 
> > > +
> > > +		ecspi_root_clk: ecspi-root {
> > > +			compatible = "fsl,imx6q-clock";
> > > +			#clock-cells = <1>;
> > > +			imx,clock-divider = <0x38 0 0 19 6>;
> > > +			clock-input = <&pll3_div_clk 2 0 0>;
> > > +			clock-input-name = "pll3-60m";
> > > +			clock-output-name = "ecspi-root";
> > > +		};
> > 
> > I'm not sure you do yourself a favour if you skip all the muxes and
> > assume reset default for them. The ecspi-root parent is a mux The mux
> > seems to be missing in the can clock, uart and probably others.
> > 
> I'm looking at IMX6DQRM.pdf 'Rev. B, 07/2011'.  I do not see mux for
> ECSPI_CLK_ROOT as well as other clocks you mentioned.  Instead, I can
> only see divider for these clocks.  Can you point out the registers
> and bits of these muxes you are seeing with these clocks?

No, I can't find them either ;) I must have looked into the wrong manual
at that moment. Sorry for the noise.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
