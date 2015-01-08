From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 8 Jan 2015 10:34:46 +0800
Subject: [PATCH v3 4/4] dts: mediatek: Enable clock support for
 Mediatek MT8135.
In-Reply-To: <CABuKBeL34hV63t+zDy3Nbz_V4qAvCF87+=hV=eUUCTrKybBFjA@mail.gmail.com>
References: <1420601123-25859-1-git-send-email-jamesjj.liao@mediatek.com>
 <1420601123-25859-5-git-send-email-jamesjj.liao@mediatek.com>
 <CABuKBeL34hV63t+zDy3Nbz_V4qAvCF87+=hV=eUUCTrKybBFjA@mail.gmail.com>
Message-ID: <1420684486.27952.23.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Wed, 2015-01-07 at 17:25 +0100, Matthias Brugger wrote:
> > +
> > +               clk_null: clk_null {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <0>;
> > +               };
> > +
> > +               clk26m: clk26m {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <26000000>;
> > +               };
> > +
> > +               rtc32k: rtc32k {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <32000>;
> > +               };
> 
> Why do you add this clocks here?
> This clocks are not represented by the clock tree? If so, what are the
> consumers of this clocks?

These clocks are currently used in clk-mt8135.c to be root clocks, which
represent clocks outside SoC and can't be controlled by MT8135.


Best regards,

James
