From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jan 2013 10:46:36 -0800
Subject: [PATCH] arm/dts: Add basic support for gta04 (Openmoko next
 generation) board.
In-Reply-To: <CAAfyv34ihnwL9JheLzY61zthTkBexTOe3cgkbU4Z+sFG2w1g6g@mail.gmail.com>
References: <1351633367-19082-1-git-send-email-marek.belisko@open-nandra.com>
 <CAAfyv34D4bTO=k8niM42CDQFb0tP4uOnvX_KPT3+F6z59jPg3Q@mail.gmail.com>
 <20121115115925.2FE453E09BB@localhost>
 <CAAfyv34ihnwL9JheLzY61zthTkBexTOe3cgkbU4Z+sFG2w1g6g@mail.gmail.com>
Message-ID: <20130121184635.GK22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Belisko Marek <marek.belisko@gmail.com> [121115 05:31]:
> CC'ing Tony
> 
> On Thu, Nov 15, 2012 at 12:59 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
> > On Wed, 14 Nov 2012 21:26:58 +0100, Belisko Marek <marek.belisko@gmail.com> wrote:
> >> CC' Grant & Rob
> >
> > Hi Marek
> >
> > Since this is an OMAP board, you should send the changes to Tony and
> > they should be merged through the arm-soc tree.

Looks like this one fell through the cracks for v3.8 merge
window. Can you please update it and send it to Benoit with
linux-omap and LAKML lists cc:d?

Now scripts/get_maintainer.pl should do the right trick for
this patch.

Regards,

Tony


> > g.
> >
> >>
> >> On Tue, Oct 30, 2012 at 10:42 PM, Marek Belisko
> >> <marek.belisko@open-nandra.com> wrote:
> >> > Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
> >> > ---
> >> >  arch/arm/boot/dts/omap3-gta04.dts |   65 +++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 65 insertions(+)
> >> >  create mode 100644 arch/arm/boot/dts/omap3-gta04.dts
> >> >
> >> > diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
> >> > new file mode 100644
> >> > index 0000000..76efd13
> >> > --- /dev/null
> >> > +++ b/arch/arm/boot/dts/omap3-gta04.dts
> >> > @@ -0,0 +1,65 @@
> >> > +/*
> >> > + * Copyright (C) 2012 Marek Belisko <marek.belisko@open-nandra.com>
> >> > + *
> >> > + * Based on omap3-beagle-xm.dts
> >> > + *
> >> > + * This program is free software; you can redistribute it and/or modify
> >> > + * it under the terms of the GNU General Public License version 2 as
> >> > + * published by the Free Software Foundation.
> >> > + */
> >> > +/dts-v1/;
> >> > +
> >> > +/include/ "omap3.dtsi"
> >> > +
> >> > +/ {
> >> > +       model = "OMAP3 GTA04";
> >> > +       compatible = "ti,omap3-gta04", "ti,omap3";
> >> > +
> >> > +       memory {
> >> > +               device_type = "memory";
> >> > +               reg = <0x80000000 0x20000000>; /* 512 MB */
> >> > +       };
> >> > +
> >> > +       gpio-keys {
> >> > +               compatible = "gpio-keys";
> >> > +               #address-cells = <1>;
> >> > +               #size-cells = <0>;
> >> > +               aux-button {
> >> > +                       label = "AUX";
> >> > +                       linux,code = <169>;
> >> > +                       gpios = <&gpio1 7 1>;
> >> > +                       gpio-key,wakeup;
> >> > +               };
> >> > +       };
> >> > +};
> >> > +
> >> > +&i2c1 {
> >> > +       clock-frequency = <2600000>;
> >> > +
> >> > +       twl: twl at 48 {
> >> > +               reg = <0x48>;
> >> > +               interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> >> > +               interrupt-parent = <&intc>;
> >> > +       };
> >> > +};
> >> > +
> >> > +/include/ "twl4030.dtsi"
> >> > +
> >> > +&i2c2 {
> >> > +       clock-frequency = <400000>;
> >> > +       /* Pressure Sensor */
> >> > +       bmp085 at 77 {
> >> > +               compatible = "bosch,bmp085";
> >> > +               reg = <0x77>;
> >> > +       };
> >> > +};
> >> > +
> >> > +&i2c3 {
> >> > +       clock-frequency = <100000>;
> >> > +};
> >> > +
> >> > +&mmc1 {
> >> > +       vmmc-supply = <&vmmc1>;
> >> > +       bus-width = <4>;
> >> > +};
> >> > +
> >> > --
> >> > 1.7.9.5
> >> >
> >>
> >>
> >>
> >> --
> >> as simple and primitive as possible
> >> -------------------------------------------------
> >> Marek Belisko - OPEN-NANDRA
> >> Freelance Developer
> >>
> >> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
> >> Tel: +421 915 052 184
> >> skype: marekwhite
> >> twitter: #opennandra
> >> web: http://open-nandra.com
> >
> > --
> > Grant Likely, B.Sc, P.Eng.
> > Secret Lab Technologies, Ltd.
> 
> Marek
> 
> -- 
> as simple and primitive as possible
> -------------------------------------------------
> Marek Belisko - OPEN-NANDRA
> Freelance Developer
> 
> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
> Tel: +421 915 052 184
> skype: marekwhite
> twitter: #opennandra
> web: http://open-nandra.com
