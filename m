From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 16:20:29 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <CACRpkdbDNoQSmFAyOMJRHSrnnuqpEfb0U9a7ZeaEztn1dAr_xA@mail.gmail.com>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1500795.gEuGziRZET@wuerfel>
 <CACRpkdbDNoQSmFAyOMJRHSrnnuqpEfb0U9a7ZeaEztn1dAr_xA@mail.gmail.com>
Message-ID: <2812721.61fsxKBgRj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 16:06:57 Linus Walleij wrote:
> On Fri, May 3, 2013 at 3:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 03 May 2013 15:33:17 Linus Walleij wrote:
> 
> >> I lean toward selecting AB3100 and REGULATOR_AB3100
> >> for the U300 actually.
> >
> > Should we still allow building them on other platforms then?
> > Right now, these depend on the platforms that actually use
> > the hardware, but in other places, we just allow everything to
> > be built that compiles without errors.
> 
> Not in my opinion but IIRC in 2008 or so some other
> subsystem maintainer beat us up for not allowing it
> to build on every other platform, and the rationale given
> was that allowin this to build on e.g. x86_64 gives some
> nice compile coverage.
> 
> I don't know which argument wins 

I know that a certain other Linus frequently complains when ARM specific
options show up on his x86 machine during "make oldconfig" ;-)

One idea I had is to create a global CONFIG_SOC option that would
hide all on-chip peripherals when building for a PC-like system.
On ARM, we would always select CONFIG_SOC, except for a few special
cases like ARCH_RPC, ARCH_FOOTBRIDGE and ARCH_SHARK.

> > Is it theoretically possible to use the AB in combination with
> > another (non-ST-Ericsson) digital baseband?
> 
> Theoretically (it's just a bunch of regulators etc when all comes
> around), but it won't happen since these components
> are not sold separately.

Right, I was specifically asking about the technical possibilities,
not what people are likely to do. 

	Arnd
