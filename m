From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 27 Sep 2017 11:22:51 +0800
Subject: [PATCH v2 05/10] arm: dts: mt7623: update pio, usb and crypto
 nodes
In-Reply-To: <1506421025.5626.6.camel@mtksdaap41>
References: <cover.1506390597.git.ryder.lee@mediatek.com>
 <93734b87262a8305b67e989777dfa1297d66cee4.1506390597.git.ryder.lee@mediatek.com>
 <1506421025.5626.6.camel@mtksdaap41>
Message-ID: <1506482571.14972.6.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-09-26 at 18:17 +0800, Yingjoe Chen wrote:
> On Tue, 2017-09-26 at 10:02 +0800, Ryder Lee wrote:
> > This patch updates pio, usb and crypto nodes to make them be consistent
> > with the binding documents.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt7623.dtsi | 52 ++++++++++++++++++++++---------------------
> >  1 file changed, 27 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> > index 381843e..9ec3767 100644
> > --- a/arch/arm/boot/dts/mt7623.dtsi
> > +++ b/arch/arm/boot/dts/mt7623.dtsi
> > @@ -226,21 +226,6 @@
> >  		#reset-cells = <1>;
> >  	};
> >  
> > -	pio: pinctrl at 10005000 {
> > -		compatible = "mediatek,mt7623-pinctrl",
> > -			     "mediatek,mt2701-pinctrl";
> > -		reg = <0 0x1000b000 0 0x1000>;
> > -		mediatek,pctl-regmap = <&syscfg_pctl_a>;
> > -		pins-are-numbered;
> > -		gpio-controller;
> > -		#gpio-cells = <2>;
> > -		interrupt-controller;
> > -		interrupt-parent = <&gic>;
> > -		#interrupt-cells = <2>;
> > -		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> > -	};
> > -
> >  	syscfg_pctl_a: syscfg at 10005000 {
> >  		compatible = "mediatek,mt7623-pctl-a-syscfg", "syscon";
> >  		reg = <0 0x10005000 0 0x1000>;
> 
> 
> Hi Ryder,
> 
> pio node is special, it have 2 registers space.
> The address 10005000 is for PIO, it was accesed through syscfg_pctl_a
> regmap. The other one, 0x1000b000, is for EINT.
> 
> So,I think using address @10005000 is correct.
> 
> Joe.C
> 

Thanks for explanation. I'll revert this part to a previous state.

> 
