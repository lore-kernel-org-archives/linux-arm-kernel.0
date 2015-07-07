From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 7 Jul 2015 11:09:50 +0800
Subject: [PATCH] arm64: dts: mt8173-evb: Add PMIC support
In-Reply-To: <1727643.5AqCaKisXT@ubix>
References: <1434979177-7575-1-git-send-email-henryc.chen@mediatek.com>
 <1436168637.6986.6.camel@mtksdaap41> <1727643.5AqCaKisXT@ubix>
Message-ID: <1436238590.19228.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-07-06 at 18:39 +0200, Matthias Brugger wrote:
> On Monday, July 06, 2015 03:43:57 PM Eddie Huang wrote:
> > On Mon, 2015-06-22 at 21:19 +0800, Henry Chen wrote:
> > > From: Eddie Huang <eddie.huang@mediatek.com>
> > > 
[...]
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > > b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts index 43d5401..b967914
> > > 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > > @@ -33,6 +33,180 @@
> > > 
> > >  	chosen { };
> > >  
> > >  };
> > > 
> > > +&pwrap {
> > > +	pmic: mt6397 {
> > > +		compatible = "mediatek,mt6397";
> > > +		interrupt-parent = <&pio>;
> > > +		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> > > +		interrupt-controller;
> > > +		#interrupt-cells = <2>;
> > > +
> > > +		mt6397regulator: mt6397regulator {
> > > +			compatible = "mediatek,mt6397-regulator";
> > > +			mt6397_vpca15_reg: buck_vpca15 {
> > > +				regulator-compatible = "buck_vpca15";
> > > +				regulator-name = "vpca15";
> > > +				regulator-min-microvolt = < 700000>;
> > > +				regulator-max-microvolt = <1350000>;
> > > +				regulator-ramp-delay = <12500>;
> > > +				regulator-always-on;
> > 
> > I see you pull da9211 regulator dts patch, but not this one. How about
> > this patch ?
> 
> I inserted some new-lines and added it to v4.2-next/arm64
> 
Thanks the pull. Normally we put alias node in alphabetical order, make
later merge more easily. I think you can do the modification and squeeze
into the same commit.

Thanks
Eddie
