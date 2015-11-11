From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 11 Nov 2015 09:44:35 +0300
Subject: [PATCH v7 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <CAL_JsqLsD9gA2-AWYGaHvOuZhhDmE2BHmPMU2nJjPYEvQJdNHQ@mail.gmail.com>
References: <cover.1446799912.git.p.fedin@samsung.com>
 <0bc58ce0fd39767834f486c4c0cfbbd70044caed.1446799912.git.p.fedin@samsung.com>
 <CAL_JsqLsD9gA2-AWYGaHvOuZhhDmE2BHmPMU2nJjPYEvQJdNHQ@mail.gmail.com>
Message-ID: <009301d11c4c$6eaa1eb0$4bfe5c10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +- samsung,srom-timing : array of 6 integers, specifying bank timings in the
> > +                        following order: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> > +                        Each value is specified in cycles and has the following
> > +                        meaning and valid range:
> > +                        Tacp : Page mode access cycle at Page mode (0 - 15)
> > +                        Tcah : Address holding time after CSn (0 - 15)
> > +                        Tcoh : Chip selection hold on OEn (0 - 15)
> > +                        Tacc : Access cycle (0 - 31, the actual time is N + 1)
> > +                        Tcos : Chip selection set-up before OEn (0 - 15)
> > +                        Tacs : Address set-up before CSn (0 - 15)
> 
> This is not easily extended. Perhaps a property per value instead.

 We had a discussion with Krzysztof about it, he agreed with this form of the property.
My concern was that it's just too much typing, and makes little sense because these
settings always go together. If register layout changes, or parameter set changes in
incompatible way, then it's another device, not exynos-srom anymore.
 So would you agree with that, or is your position strong?

> >                 compatible = "samsung,exynos-srom";
> > -               reg = <0x12570000 0x10>;
> > +               reg = <0x12570000 0x14>;
> > +
> > +               ethernet at 3 {
> > +                       compatible = "smsc,lan9115";
> > +                       reg = <3 0 0x10000>;       // Bank 3, offset = 0
> > +                       phy-mode = "mii";
> > +                       interrupt-parent = <&gpx0>;
> > +                       interrupts = <5 8>;
> > +                       reg-io-width = <2>;
> > +                       smsc,irq-push-pull;
> > +                       smsc,force-internal-phy;
> > +
> > +                       samsung,srom-config = <1 9 12 1 9 1 1>;
> 
> This doesn't match the doc.

 Damn, overlooked. :(

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
