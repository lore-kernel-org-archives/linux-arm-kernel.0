From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Apr 2013 14:20:35 +0200
Subject: [PATCH 3/7] ARM: exynos: add missing properties for combiner IRQs
In-Reply-To: <CAK9yfHwXYRqo2yG1moWvMnEmNWXCVL7a9eKzi2we=QmdpVsz-w@mail.gmail.com>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
 <201304151041.44805.arnd@arndb.de>
 <CAK9yfHwXYRqo2yG1moWvMnEmNWXCVL7a9eKzi2we=QmdpVsz-w@mail.gmail.com>
Message-ID: <201304151420.35843.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 April 2013, Sachin Kamat wrote:
> >> > diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
> >> > index 36d4299..f83c3c1 100644
> >> > --- a/arch/arm/boot/dts/exynos4212.dtsi
> >> > +++ b/arch/arm/boot/dts/exynos4212.dtsi
> >> > @@ -26,6 +26,15 @@
> >> >                 cpu-offset = <0x8000>;
> >> >         };
> >> >
> >> > +       interrupt-controller at 10440000 {
> >>
> >> Don't we need a node name here (combiner:interrupt-controller at 10440000)?
> >
> > Why?
> 
> Since it is being referenced as "&combiner" by other bindings, i
> thought that was required.

The original definition actually comes from exynos4.dtsi. It's enough
to have the label in one place.

> >> We have a combiner node defined in exynos4x12.dtsi. With the bindings
> >> now defined separately in 4212 and 4412 dtsi files, probably the one
> >> in 4x12 could be dropped?
> >
> > I did not see that one, but it seems to have the wrong numbers in the last
> > four interrupt specifiers. I think it would be better to just fix that one
> > and keep using it.
> 
> OK. Do you want me to fix it and send as a patch or would you like to do it?

If you have a patch that works, you could just send it out, oetherwise I'd
do it.

	ARnd
