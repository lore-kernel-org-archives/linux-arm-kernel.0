From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 2 Apr 2014 08:57:44 +0200
Subject: [PATCH 3/6] ARM: socfpga: dts: add i2c busses
In-Reply-To: <1396380740.27447.1.camel@linux-builds1>
References: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396280404-2041-3-git-send-email-s.trumtrar@pengutronix.de>
 <1396380740.27447.1.camel@linux-builds1>
Message-ID: <20140402065744.GT5052@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Apr 01, 2014 at 02:32:20PM -0500, Dinh Nguyen wrote:
> On Mon, 2014-03-31 at 17:40 +0200, Steffen Trumtrar wrote:
> > Add all 4 i2c busses.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index 7867e7f..d0594c3 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -470,6 +470,50 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		i2c0: i2c at 0xffc04000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "snps,designware-i2c";
> > +			reg = <0xffc04000 0x1000>;
> > +			clock-frequency = <400000000>;
> 
> "clock-frequency" is not needed as the driver can get the clock
> frequency from the clock driver.
> 

You are right of course. I will remove that.
Although, I think I remember seeing patches that add this functionality
to the driver. So you can change the speed setting. But even than you
are right, as something like that wouldn't belong here in the dtsi.


> > +			clocks = <&l4_sp_clk>;
> > +			interrupts = <0 158 0x4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		i2c1: i2c at 0xffc05000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "snps,designware-i2c";
> > +			reg = <0xffc05000 0x1000>;
> > +			clock-frequency = <100000000>;
> 
> Same..
> 
> > +			clocks = <&l4_sp_clk>;
> > +			interrupts = <0 159 0x4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		i2c2: i2c at 0xffc06000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "snps,designware-i2c";
> > +			reg = <0xffc06000 0x1000>;
> > +			clock-frequency = <100000000>;
> 
> Same...
> 
> > +			clocks = <&l4_sp_clk>;
> > +			interrupts = <0 160 0x4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		i2c3: i2c at 0xffc07000 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "snps,designware-i2c";
> > +			reg = <0xffc07000 0x1000>;
> > +			clock-frequency = <100000000>;
> 
> Same..
> 
> thanks,
> Dinh
> > +			clocks = <&l4_sp_clk>;
> > +			interrupts = <0 161 0x4>;
> > +			status = "disabled";
> > +		};
> > +
> >  		L2: l2-cache at fffef000 {
> >  			compatible = "arm,pl310-cache";
> >  			reg = <0xfffef000 0x1000>;
> 
> 
> 

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
