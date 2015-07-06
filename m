From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 06 Jul 2015 18:39:59 +0200
Subject: [PATCH] arm64: dts: mt8173-evb: Add PMIC support
In-Reply-To: <1436168637.6986.6.camel@mtksdaap41>
References: <1434979177-7575-1-git-send-email-henryc.chen@mediatek.com>
 <1436168637.6986.6.camel@mtksdaap41>
Message-ID: <1727643.5AqCaKisXT@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 06, 2015 03:43:57 PM Eddie Huang wrote:
> Hi Matthias,
> 
> On Mon, 2015-06-22 at 21:19 +0800, Henry Chen wrote:
> > From: Eddie Huang <eddie.huang@mediatek.com>
> > 
> > The MT8173 eval board contains a MT6397 PMIC. This adds the
> > corresponding device node to the dts file.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> > Base on 4.1-rc1 and commit as following,
> > ARM64: dts: Mediatek: MT8173 updates [1] and
> > clk: Add common clock support for Mediatek MT8135 and MT8173 [2] patch
> > 
> > [1]
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/344751.htm
> > l [2]
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338763.h
> > tml ---
> > 
> >  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 174
> >  ++++++++++++++++++++++++++++ 1 file changed, 174 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts index 43d5401..b967914
> > 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > @@ -33,6 +33,180 @@
> > 
> >  	chosen { };
> >  
> >  };
> > 
> > +&pwrap {
> > +	pmic: mt6397 {
> > +		compatible = "mediatek,mt6397";
> > +		interrupt-parent = <&pio>;
> > +		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +
> > +		mt6397regulator: mt6397regulator {
> > +			compatible = "mediatek,mt6397-regulator";
> > +			mt6397_vpca15_reg: buck_vpca15 {
> > +				regulator-compatible = "buck_vpca15";
> > +				regulator-name = "vpca15";
> > +				regulator-min-microvolt = < 700000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-ramp-delay = <12500>;
> > +				regulator-always-on;
> 
> I see you pull da9211 regulator dts patch, but not this one. How about
> this patch ?

I inserted some new-lines and added it to v4.2-next/arm64

Thanks,
Matthias
