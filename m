From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 06 Oct 2014 11:35:30 +0200
Subject: [PATCH 3/4] [media] Remove optional dependency on PLAT_S5P
In-Reply-To: <4788945.SoI4OqN9Zu@wuerfel>
References: <1412586626.4054.42.camel@x220> <4788945.SoI4OqN9Zu@wuerfel>
Message-ID: <1412588130.4054.49.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-06 at 11:26 +0200, Arnd Bergmann wrote:
> On Monday 06 October 2014 11:10:26 Paul Bolle wrote:
> >  config VIDEO_SAMSUNG_S5P_TV
> >         bool "Samsung TV driver for S5P platform"
> >         depends on PM_RUNTIME
> > -       depends on PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST
> > +       depends on ARCH_EXYNOS || COMPILE_TEST
> >         default n
> >         ---help---
> >           Say Y here to enable selecting the TV output devices for
> > 
> 
> I wonder if it should now allow being built for ARCH_S5PV210.

That was what Tomasz Figa claimed in
http://lkml.kernel.org/r/53C676DB.6070002 at samsung.com

> Maybe it was a mistake to remove the PLAT_S5P symbol without changing
> the use here?

At least it was a bit sloppy to remove the symbol without touching this
(and six other) dependencies. But after nearly three months I lost
patience waiting for a fix to be submitted.

My cleanup doesn't really change a thing. And a proper fix, if needed,
is still possible after this has landed.

> Does S5PV210 have this device?


Paul Bolle
