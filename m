From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 03 Sep 2018 16:54:29 +0200
Subject: [PATCH 2/3] ARM: dts: imx6ull: add pxp support
In-Reply-To: <20180827065927.GE3850@dragon>
References: <20180810151822.18650-1-p.zabel@pengutronix.de>
 <20180810151822.18650-3-p.zabel@pengutronix.de>
 <20180827065927.GE3850@dragon>
Message-ID: <1535986469.6568.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-08-27 at 14:59 +0800, Shawn Guo wrote:
> On Fri, Aug 10, 2018 at 05:18:21PM +0200, Philipp Zabel wrote:
> > Add the device node for the i.MX6ULL Pixel Pipeline (PXP).
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6ul.dtsi  | 8 ++++++++
> >  arch/arm/boot/dts/imx6ull.dtsi | 6 ++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> > index 47a3453a4211..e80a660c14f2 100644
> > --- a/arch/arm/boot/dts/imx6ul.dtsi
> > +++ b/arch/arm/boot/dts/imx6ul.dtsi
> > @@ -928,6 +928,14 @@
> >  				};
> >  			};
> >  
> > +			pxp: pxp at 21cc000 {
> > +				compatible = "fsl,imx6ul-pxp";
> > +				reg = <0x021cc000 0x4000>;
> > +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > +				clock-names = "axi";
> > +				clocks = <&clks IMX6UL_CLK_PXP>;
> > +			};
> > +
> >  			lcdif: lcdif at 21c8000 {
> 
> In order of unit-address, pxp at 21cc000 should go after lcdif at 21c8000.

Thank you, I'll fix this in v2.

regards
Philipp
