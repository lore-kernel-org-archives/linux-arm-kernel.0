From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 19 Oct 2018 13:57:13 +0530
Subject: [PATCH 2/5] arm64: dts: mediatek: mt6797: Add pinctrl support
In-Reply-To: <CAGp9LzoSA=06CF_yNMOHnfmRnFzpBA4R2YGhbWmxdSKci2uF0w@mail.gmail.com>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-3-manivannan.sadhasivam@linaro.org>
 <CAGp9LzoSA=06CF_yNMOHnfmRnFzpBA4R2YGhbWmxdSKci2uF0w@mail.gmail.com>
Message-ID: <20181019082713.GA2641@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 10:07:52PM +0800, Sean Wang wrote:
> On Tue, Oct 9, 2018 at 3:16 AM Manivannan Sadhasivam <
> manivannan.sadhasivam at linaro.org> wrote:
> 
> > Add pinctrl support for Mediatek MT6797 SoC.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > index 4beaa71107d7..231230d32d09 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> > @@ -14,6 +14,7 @@
> >  #include <dt-bindings/clock/mt6797-clk.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/pinctrl/mt6797-pinfunc.h>
> >
> >  / {
> >         compatible = "mediatek,mt6797";
> > @@ -129,6 +130,19 @@
> >                 #clock-cells = <1>;
> >         };
> >
> > +       pio: pinctrl at 10005000 {
> > +               compatible = "mediatek,mt6797-pinctrl";
> > +               reg = <0 0x10005000 0 0x1000>,
> > +                     <0 0x10002000 0 0x400>,
> > +                     <0 0x10002400 0 0x400>,
> > +                     <0 0x10002800 0 0x400>,
> > +                     <0 0x10002C00 0 0x400>;
> > +               reg-names = "gpio", "iocfgl", "iocfgb",
> > +                           "iocfgr", "iocfgt";
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> > +
> >
> 
> The content looks good to me, but the dt-binding document is still being
> added the support for MT6797 SoC before the dts instance is being applied.
> 
>

Okay, will add a binding doc in next revision.

Thanks,
Mani

> >         scpsys: scpsys at 10006000 {
> >                 compatible = "mediatek,mt6797-scpsys";
> >                 #power-domain-cells = <1>;
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >
