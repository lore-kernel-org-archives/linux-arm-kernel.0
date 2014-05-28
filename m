From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 28 May 2014 00:22:40 -0700
Subject: [PATCH v11 2/3] clk: exynos5410: register clocks using common
 clock framework
In-Reply-To: <01a201cf7a30$41ecca90$c5c65fb0$@samsung.com>
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <1401074613-29227-3-git-send-email-t.dakhran@samsung.com>
 <20140528004116.7816.69646@quantum>
 <01a201cf7a30$41ecca90$c5c65fb0$@samsung.com>
Message-ID: <20140528072240.10062.16890@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kukjin Kim (2014-05-27 21:49:49)
> Mike Turquette wrote:
> > 
> > Quoting Tarek Dakhran (2014-05-25 20:23:32)
> > > The EXYNOS5410 clocks are statically listed and registered
> > > using the Samsung specific common clock helper functions.
> > >
> > > Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> > > Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
> > > ---
> > >  .../devicetree/bindings/clock/exynos5410-clock.txt |   45 +++++
> > >  drivers/clk/samsung/Makefile                       |    1 +
> > >  drivers/clk/samsung/clk-exynos5410.c               |  209
> > ++++++++++++++++++++
> > >  include/dt-bindings/clock/exynos5410.h             |   33 ++++
> > >  4 files changed, 288 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-
> > clock.txt
> > >  create mode 100644 drivers/clk/samsung/clk-exynos5410.c
> > >  create mode 100644 include/dt-bindings/clock/exynos5410.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/exynos5410-
> > clock.txt b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
> > > new file mode 100644
> > > index 0000000..aeab635
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt
> > > @@ -0,0 +1,45 @@
> > > +* Samsung Exynos5410 Clock Controller
> > > +
> > > +The Exynos5410 clock controller generates and supplies clock to various
> > > +controllers within the Exynos5410 SoC.
> > > +
> > > +Required Properties:
> > > +
> > > +- compatible: should be "samsung,exynos5410-clock"
> > > +
> > > +- reg: physical base address of the controller and length of memory
> > mapped
> > > +  region.
> > > +
> > > +- #clock-cells: should be 1.
> > > +
> > > +All available clocks are defined as preprocessor macros in
> > > +dt-bindings/clock/exynos5410.h header and can be used in device
> > > +tree sources.
> > > +
> > > +External clock:
> > > +
> > > +There is clock that is generated outside the SoC. It
> > > +is expected that it is defined using standard clock bindings
> > > +with following clock-output-name:
> > > +
> > > + - "fin_pll" - PLL input clock from XXTI
> > 
> > Does fin_pll feed into the exynos5410-clock controller? If so, should
> > the example clock-controller node below have a clocks and clock-names
> > property?
> > 
> Well, it is fixed clocks and generated outside of the SoC...so maybe the properties are not required?

I guess the fin_pll parts of the binding description are not needed
then. This isn't a big issue, but I think that someone reading that
binding (like myself) might conclude that there is some relationship
between the clock controller and the external clock, which seems not to
be the case.

> 
> BTW, I've applied this series with Tomasz Figa's reviewed tag and sent out to arm-soc today so if any concerns on this, please let me know immediately.

As far as I can tell the fin_pll paragraph can be removed at a later
date. It isn't part of any real DT binding description such as a
property or definition. So no need to cause havoc for your existing pull
request.

Regards,
Mike

> 
> > Otherwise patch looks good.
> > 
> 
> Thanks,
> Kukjin
> 
