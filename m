From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 12 Nov 2015 10:02:06 +0300
Subject: [PATCH v7 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <CAL_JsqLtWwdGHKKfS8b6E0Urh6gYopZcwpdyvJGWCRm7x81YzA@mail.gmail.com>
References: <cover.1446799912.git.p.fedin@samsung.com>
 <0bc58ce0fd39767834f486c4c0cfbbd70044caed.1446799912.git.p.fedin@samsung.com>
 <CAL_JsqLsD9gA2-AWYGaHvOuZhhDmE2BHmPMU2nJjPYEvQJdNHQ@mail.gmail.com>
 <009301d11c4c$6eaa1eb0$4bfe5c10$@samsung.com>
 <CAL_JsqLtWwdGHKKfS8b6E0Urh6gYopZcwpdyvJGWCRm7x81YzA@mail.gmail.com>
Message-ID: <00f901d11d18$0b68e760$223ab620$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >> > +- samsung,srom-timing : array of 6 integers, specifying bank timings in the
> >> > +                        following order: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> >> > +                        Each value is specified in cycles and has the following
> >> > +                        meaning and valid range:
> >> > +                        Tacp : Page mode access cycle at Page mode (0 - 15)
> >> > +                        Tcah : Address holding time after CSn (0 - 15)
> >> > +                        Tcoh : Chip selection hold on OEn (0 - 15)
> >> > +                        Tacc : Access cycle (0 - 31, the actual time is N + 1)
> >> > +                        Tcos : Chip selection set-up before OEn (0 - 15)
> >> > +                        Tacs : Address set-up before CSn (0 - 15)
> >>
> >> This is not easily extended. Perhaps a property per value instead.
> >
> >  We had a discussion with Krzysztof about it, he agreed with this form of the property.
> > My concern was that it's just too much typing, and makes little sense because these
> > settings always go together. If register layout changes, or parameter set changes in
> > incompatible way, then it's another device, not exynos-srom anymore.
> >  So would you agree with that, or is your position strong?
> 
> I'm thinking for a new version of the controller which could add (or
> remove) new timing parameters, but then I guess you can interpret the
> field differently based on the compatible string. Anyway, your problem
> to deal with.

 Of course, my thought is that if compatible string is different,
then it's already a different device. And of course it would have different parameters.
 So, OK, i'll post new version with fixed documentation today.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
