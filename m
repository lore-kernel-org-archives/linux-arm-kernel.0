From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Aug 2013 01:41:11 +0100
Subject: Build breakage due to latest ARM fixes
In-Reply-To: <CAOesGMi3FBz7-tQSxgQMgHiHmPTnO4k57MkhQTQTvtB0Q6WyNw@mail.gmail.com>
References: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
 <20130803000731.GS23006@n2100.arm.linux.org.uk>
 <CAOesGMi3FBz7-tQSxgQMgHiHmPTnO4k57MkhQTQTvtB0Q6WyNw@mail.gmail.com>
Message-ID: <20130803004111.GT23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 05:24:21PM -0700, Olof Johansson wrote:
> On Fri, Aug 2, 2013 at 5:07 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Aug 02, 2013 at 04:41:11PM -0700, Olof Johansson wrote:
> >> Russell,
> >>
> >> Looks like you sent up some fixes to Linus that broke one of the atmel
> >> configs (CONFIG_MMU=n):
> >>
> >> commit 48be69a026b2c1 ARM: move signal handlers into a vdso-like page
> >>
> >> seems to have caused it:
> >>
> >> arch/arm/kernel/signal.c: In function 'setup_return':
> >> arch/arm/kernel/signal.c:413:25: error: 'mm_context_t' has no member
> >> named 'sigpage'
> >>
> >> I see it with at91x40_defconfig.
> >
> > I'll look into that.  Obviously, I never build nommu because it isn't
> > part of the build system and the nommu platform I do have - OKI67001 -
> > doesn't have mainline kernel support.  (And if it did, it would not be
> > DT, so I doubt it's submittable.)
> 
> I just noticed a whole bunch of boot/runtime failures too across the board too.
> 
> tegra2 seaboard, exynos arndale, ux500 snowball all panicked. Panda,
> cubox and sama5 were the only systems that stayed up. Note that I
> don't do much with them per boot though, so with more runtime they
> might have hit something too.
> 
> Some of the oopses below, they're probably not very useful though. Let
> me know if I can help collect data in any way.

Gah, it looks like I didn't commit an update to these patches.

> Maybe it's better to move this feature work to -next and iron out the
> kinks there? :(

Tell me how I can put this stuff into -next _and_ keep it secret because
it's security related.  The two things are totally incompatible with each
other.  Sorry.
