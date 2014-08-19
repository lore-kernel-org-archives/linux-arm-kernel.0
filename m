From: carlo@caione.org (Carlo Caione)
Date: Tue, 19 Aug 2014 18:16:52 +0200
Subject: [PATCH 5/7] ARM: meson: dts: add basic
 Meson/Meson6/Meson6-atv1200 DTSI/DTS
In-Reply-To: <20140818161744.GD3302@leverpostej>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-6-git-send-email-carlo@caione.org>
 <20140818161744.GD3302@leverpostej>
Message-ID: <20140819161652.GB869@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 05:17:44PM +0100, Mark Rutland wrote:
> On Sun, Aug 17, 2014 at 11:49:52AM +0100, Carlo Caione wrote:

<cut>

> > +	soc at c8100000 {
> 
> What's the unit-address for? This node doesn't have a reg or compatible.

I used it to indicate the starting address of the memory mapped region.

> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		uart_AO: serial at c81004c0 {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc81004c0 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart_A: serial at c81084c0 {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc81084c0 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart_B: serial at c81084dc {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc81084dc 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart_C: serial at c8108700 {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc8108700 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> 
> I guess these are disabled because they aren't always wired up?

Yes

<cut>

> > +	clocks {
> > +		#address-cells = <1>;
> > +
> > +		clk81: clk at 0 {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <200000000>;
> > +		};
> > +	};
> 
> There is really no need to put clocks in a container.
> 
> Just put them under the root, and drop the unit-address.

I'll do, thanks.

-- 
Carlo Caione
