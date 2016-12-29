From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 29 Dec 2016 16:17:07 +0200
Subject: [PATCH v2] ARM: dts: Add missing CPU frequencies for
 Exynos5422/5800
In-Reply-To: <CAD=FV=Wo273T20fe8D2v5Pn1HYR==7PHtr7WZGwzFPRspAYPzg@mail.gmail.com>
References: <10512254.nyUcL0zgTP@amdc3058>
 <CAD=FV=Wo273T20fe8D2v5Pn1HYR==7PHtr7WZGwzFPRspAYPzg@mail.gmail.com>
Message-ID: <20161229141707.qjrtjz7dik6a7l5s@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 04:54:30PM -0800, Doug Anderson wrote:
> > Index: b/arch/arm/boot/dts/exynos5800.dtsi
> > ===================================================================
> > --- a/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.365955950 +0100
> > +++ b/arch/arm/boot/dts/exynos5800.dtsi 2016-12-15 12:43:54.361955949 +0100
> > @@ -24,6 +24,16 @@
> >  };
> >
> >  &cluster_a15_opp_table {
> > +       opp at 2000000000 {
> > +               opp-hz = /bits/ 64 <2000000000>;
> > +               opp-microvolt = <1250000>;
> > +               clock-latency-ns = <140000>;
> > +       };
> > +       opp at 1900000000 {
> > +               opp-hz = /bits/ 64 <1900000000>;
> > +               opp-microvolt = <1250000>;
> > +               clock-latency-ns = <140000>;
> > +       };
> 
> I don't think the voltages you listed are high enough for all peach pi
> boards for A15 at 1.9 GHz and 2.0 GHz, at least based on the research
> I did.  See my response to v1.

I wanted to apply this but saw this remaining issue. Javier tested it
on Peach Pi so is this concern still valid?

Bartlomiej,
When sending dts patches please stick to the common subsystem prefix
(git log --oneline arch/arm/boot/dts/exynos*).

Best regards,
Krzysztof
