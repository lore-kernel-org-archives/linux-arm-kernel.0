From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 2 Apr 2014 08:54:44 +0200
Subject: [PATCH 4/6] ARM: socfpga: dts: add can0+1
In-Reply-To: <1396380890.27447.3.camel@linux-builds1>
References: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396280404-2041-4-git-send-email-s.trumtrar@pengutronix.de>
 <1396380890.27447.3.camel@linux-builds1>
Message-ID: <20140402065444.GS5052@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh!

On Tue, Apr 01, 2014 at 02:34:50PM -0500, Dinh Nguyen wrote:
> On Mon, 2014-03-31 at 17:40 +0200, Steffen Trumtrar wrote:
> > Add both can controllers to the dtsi.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index d0594c3..51148b8 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -470,6 +470,22 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		can0: can at 0xffc00000 {
> 
> I've seen a comment from Rob Herring to remove the 0x here.

Yep, you are right. I missed this as it looks weird to me without the 0x,
but common practice is without...

> > +			compatible = "bosch,d_can";
> > +			reg = <0xffc00000 0x1000>;
> > +			interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
> > +			clocks = <&can0_clk>;
> > +			status = "disabled";
> > +		};
> > +
> > +		can1: can at 0xffc01000 {
> 
> Same...
> 
> > +			compatible = "bosch,d_can";
> > +			reg = <0xffc01000 0x1000>;
> > +			interrupts = <0 135 4>, <0 136 4>, <0 137 4>, <0 138 4>;
> > +			clocks = <&can1_clk>;
> > +			status = "disabled";
> > +		};
> > +
> >  		i2c0: i2c at 0xffc04000 {
> 
> Same comment here..but would apply to patch 3/6.
> 

I will fix all those.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
