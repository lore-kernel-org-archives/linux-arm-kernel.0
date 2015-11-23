From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 23 Nov 2015 10:43:30 +0800
Subject: [PATCH 1/2] arm64: dts: berlin4ct: add I2C nodes for BG4CT
In-Reply-To: <564F8EF3.5010508@gmail.com>
References: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
 <1448012821-7413-2-git-send-email-jszhang@marvell.com>
 <564F8EF3.5010508@gmail.com>
Message-ID: <20151123104330.6b9e649c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015 22:21:55 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 20.11.2015 10:47, Jisheng Zhang wrote:
> > The Marvell Berlin BG4CT SoC has 4 TWSI which are compatible with the
> > Synopsys DesignWare I2C driver. Add the corresponding nodes.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 52 ++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > index cca4c41..39d0676 100644
> > --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > @@ -232,6 +232,32 @@
> >  				};
> >  			};
> >  
> > +			i2c0: i2c at 1400 {
> > +				compatible = "snps,designware-i2c";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				reg = <0x1400 0x100>;
> > +				clocks = <&clk CLK_APBCORE>;  
> 
> This patch looks fine to me, except that clock node naming and
> clock indices may change. We should really postpone this series
> until we worked out clock.

Indeed. This is just to sent out for review early, so that we can merge
the i2c support once clk is ready.

Thanks for review,
Jisheng

> 
> Sebastian
> 
> > +				i2c-sda-hold-time-ns = <35>;
> > +				i2c-sda-falling-time-ns = <425>;
> > +				i2c-scl-falling-time-ns = <205>;
> > +				interrupts = <4>;
> > +				status = "disabled";
> > +			};
> > +
> > +			i2c1: i2c at 1800 {
> > +				compatible = "snps,designware-i2c";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				reg = <0x1800 0x100>;
> > +				clocks = <&clk CLK_APBCORE>;
> > +				i2c-sda-hold-time-ns = <35>;
> > +				i2c-sda-falling-time-ns = <425>;
> > +				i2c-scl-falling-time-ns = <205>;
> > +				interrupts = <5>;
> > +				status = "disabled";
> > +			};
> > +
> >  			aic: interrupt-controller at 3800 {
> >  				compatible = "snps,dw-apb-ictl";
> >  				reg = <0x3800 0x30>;
> > @@ -319,6 +345,32 @@
> >  				};
> >  			};
> >  
> > +			i2c2: i2c at b000 {
> > +				compatible = "snps,designware-i2c";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				reg = <0xb000 0x100>;
> > +				clocks = <&osc>;
> > +				i2c-sda-hold-time-ns = <140>;
> > +				i2c-sda-falling-time-ns = <500>;
> > +				i2c-scl-falling-time-ns = <220>;
> > +				interrupts = <6>;
> > +				status = "disabled";
> > +			};
> > +
> > +			i2c3: i2c at c000 {
> > +				compatible = "snps,designware-i2c";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				reg = <0xc000 0x100>;
> > +				clocks = <&osc>;
> > +				i2c-sda-hold-time-ns = <140>;
> > +				i2c-sda-falling-time-ns = <500>;
> > +				i2c-scl-falling-time-ns = <220>;
> > +				interrupts = <7>;
> > +				status = "disabled";
> > +			};
> > +
> >  			uart0: uart at d000 {
> >  				compatible = "snps,dw-apb-uart";
> >  				reg = <0xd000 0x100>;
> >   
> 
