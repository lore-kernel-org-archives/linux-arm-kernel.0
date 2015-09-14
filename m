From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 14 Sep 2015 09:30:49 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2
 Square board
In-Reply-To: <CABxcv=nRjge1qMeoXt6U6McKbv30oYUhh9C417mX0B=bt9Jg-g@mail.gmail.com>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <CABxcv=nRjge1qMeoXt6U6McKbv30oYUhh9C417mX0B=bt9Jg-g@mail.gmail.com>
Message-ID: <1442215849.8778.101.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-14 at 01:00 +0200, Javier Martinez Canillas wrote:
> Hello Sjoerd,
> 
> On Sat, Sep 12, 2015 at 12:36 AM, Sjoerd Simons
> <sjoerd.simons@collabora.co.uk> wrote:
> 
> [snip]
> 
> > +
> > +               regulators {
> > +                       vcc_ddr: REG1 {
> > +                               regulator-name = "VCC_DDR";
> > +                               regulator-min-microvolt =
> > <1200000>;
> > +                               regulator-max-microvolt =
> > <1200000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vcc_io: REG2 {
> > +                               regulator-name = "VCC_IO";
> > +                               regulator-min-microvolt =
> > <3300000>;
> > +                               regulator-max-microvolt =
> > <3300000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vdd_log: REG3 {
> > +                               regulator-name = "VDD_LOG";
> > +                               regulator-min-microvolt =
> > <1000000>;
> > +                               regulator-max-microvolt =
> > <1000000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vcc_20: REG4 {
> > +                               regulator-name = "VCC_20";
> > +                               regulator-min-microvolt =
> > <2000000>;
> > +                               regulator-max-microvolt =
> > <2000000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vccio_sd: REG5 {
> > +                               regulator-name = "VCCIO_SD";
> > +                               regulator-min-microvolt =
> > <3300000>;
> > +                               regulator-max-microvolt =
> > <3300000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vdd10_lcd: REG6 {
> > +                               regulator-name = "VDD10_LCD";
> > +                               regulator-min-microvolt =
> > <1000000>;
> > +                               regulator-max-microvolt =
> > <1000000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vcca_codec: REG7 {
> > +                               regulator-name = "VCCA_CODEC";
> > +                               regulator-min-microvolt =
> > <3300000>;
> > +                               regulator-max-microvolt =
> > <3300000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vcca_tp: REG8 {
> > +                               regulator-name = "VCCA_TP";
> > +                               regulator-min-microvolt =
> > <3300000>;
> > +                               regulator-max-microvolt =
> > <3300000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vccio_pmu: REG9 {
> > +                               regulator-name = "VCCIO_PMU";
> > +                               regulator-min-microvolt =
> > <3300000>;
> > +                               regulator-max-microvolt =
> > <3300000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vdd_10: REG10 {
> > +                               regulator-name = "VDD_10";
> > +                               regulator-min-microvolt =
> > <1000000>;
> > +                               regulator-max-microvolt =
> > <1000000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vcc_18: REG11 {
> > +                               regulator-name = "VCC_18";
> > +                               regulator-min-microvolt =
> > <1800000>;
> > +                               regulator-max-microvolt =
> > <1800000>;
> > +                               regulator-always-on;
> > +                       };
> > +
> > +                       vcc18_lcd: REG12 {
> > +                               regulator-name = "VCC18_LCD";
> > +                               regulator-min-microvolt =
> > <1800000>;
> > +                               regulator-max-microvolt =
> > <1800000>;
> > +                               regulator-always-on;
> > +                       };
> 
> Should all these regulators really need to be always-on?

Ideally not all of them, turning the ones that aren't needed off is
definately on my list of things to do (together with the other
pheripherals, leds, hw. keys etc). 

For the first patch i do prefer to keep them on so we can have get some
more testing  with this board before fine-tuning those things (fwiw,
the rockchip evb board and others with essentially the same pmic setup
all also have them always-on)



-- 
Sjoerd Simons
Collabora Ltd.
