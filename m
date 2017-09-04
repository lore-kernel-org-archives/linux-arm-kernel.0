From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 04 Sep 2017 13:43:46 +0900
Subject: [PATCH v3 1/2] ARM: dts: uniphier: add nodes of thermal monitor
 and thermal zone for PXs2
In-Reply-To: <CAK7LNAS2chLuW_PzeghNCTYf038qS_BgxMqJ6FoQbqT6hRJYSQ@mail.gmail.com>
References: <1499255595-31805-2-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK7LNAS2chLuW_PzeghNCTYf038qS_BgxMqJ6FoQbqT6hRJYSQ@mail.gmail.com>
Message-ID: <20170904134345.9FEF.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yamada-san,

On Thu, 10 Aug 2017 19:44:38 +0900 <yamada.masahiro@socionext.com> wrote:

> Hayashi-san
> 
> 
> 2017-07-05 20:53 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> > Add nodes of thermal monitor and thermal zone for UniPhier PXs2 SoC.
> > The thermal monitor is included in sysctrl.
> > Furthermore, add cpuN labels for reference in cooling-device property.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> 
> 
> Please add socionext,tmod-calibration
> in case the efuse is not brown.

I see.
I'll include it to the pvtctl node in uniphier-pxs2.dtsi.

> >
> > +       thermal-zones {
> > +               cpu_thermal {
> > +                       polling-delay-passive = <250>;  /* 250ms */
> > +                       polling-delay = <1000>;         /* 1000ms */
> > +                       thermal-sensors = <&pvtctl>;
> > +
> > +                       trips {
> > +                               cpu_crit: cpu_crit {
> > +                                       temperature = <95000>;  /* 95C */
> > +                                       hysteresis = <2000>;
> > +                                       type = "critical";
> > +                               };
> > +                               cpu_alert: cpu_alert {
> > +                                       temperature = <85000>;  /* 85C */
> > +                                       hysteresis = <2000>;
> > +                                       type = "passive";
> > +                               };
> > +                       };
> > +
> > +                       cooling-maps {
> > +                               map {
> > +                                       trip = <&cpu_alert>;
> > +                                       cooling-device = <&cpu0 (-1) (-1)>;
> > +                               };
> 
> 
> After all, I decided to use dt-bindings headers.
> Could you use THERMAL_NO_LIMIT for clarification?

Okay, I'll replace '(-1)' to THERMAL_NO_LIMIT and add the '#include' directive.

---
Best Regards,
Kunihiko Hayashi
