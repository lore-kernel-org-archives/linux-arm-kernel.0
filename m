From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Oct 2016 18:26:33 +0200
Subject: [PATCH v5 2/4] arm64: dts: add Allwinner A64 SoC .dtsi
In-Reply-To: <a0b71433-8302-8ac2-a695-60ac813b380f@arm.com>
References: <cover.f18c0f482ef4459b5c8f6eb5828fcb6762440974.1476986335.git-series.maxime.ripard@free-electrons.com>
 <eb11a71c58cd85551d9d793437db1792abd5077c.1476986335.git-series.maxime.ripard@free-electrons.com>
 <a0b71433-8302-8ac2-a695-60ac813b380f@arm.com>
Message-ID: <20161024162633.olqhftj5tdsp6qwb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andr?,

On Mon, Oct 24, 2016 at 12:57:04AM +0100, Andr? Przywara wrote:
> > +		pio: pinctrl at 1c20800 {
> > +			compatible = "allwinner,sun50i-a64-pinctrl";
> > +			reg = <0x01c20800 0x400>;
> > +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_PIO>;
> > +			gpio-controller;
> > +			#gpio-cells = <3>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +
> > +			i2c1_pins: i2c1_pins {
> > +				allwinner,pins = "PH2", "PH3";
> > +				allwinner,function = "i2c1";
> 
> So as Icenowy pointed out, we are missing the drive and pull properties
> here, at least as long as we don't have your patch (series) in place to
> cope with that.

Yeah sorry, we noticed first with Chen-Yu that the binding should not
need it, and then we realised that the driver was making the
assumption that they were... Sorry :/

> But if we rely on this series (which seems OK to me), shouldn't we then
> use the generic properties for pins and function here as well?

Definitely. I'll update this.

Thanks!
Maxime 

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/2b6d6f3f/attachment.sig>
