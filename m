From: horms@verge.net.au (Simon Horman)
Date: Fri, 28 Nov 2014 09:44:27 +0900
Subject: [PATCH 1/2] ARM: shmobile: sh73a0 legacy/reference: Add missing
 INTCA0 clock for irqpin module
In-Reply-To: <20141126013156.GE17620@verge.net.au>
References: <1416410820-30020-1-git-send-email-geert+renesas@glider.be>
 <1416410820-30020-2-git-send-email-geert+renesas@glider.be>
 <20141125024405.GA21881@verge.net.au>
 <CAMuHMdW_-Dj8x2+4RG8yGurPsc8oVZVME2UaoU+EOhrxaCQ-4Q@mail.gmail.com>
 <CAMuHMdV3D8odk0+A5KPgv0yWhFB2KsyKFac8rHm3B=SRUUQ__w@mail.gmail.com>
 <20141126013156.GE17620@verge.net.au>
Message-ID: <20141128004426.GH30850@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, Nov 26, 2014 at 10:31:56AM +0900, Simon Horman wrote:
> On Tue, Nov 25, 2014 at 11:16:40AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Nov 25, 2014 at 10:31 AM, Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Tue, Nov 25, 2014 at 3:44 AM, Simon Horman <horms@verge.net.au> wrote:
> > >> On Wed, Nov 19, 2014 at 04:26:59PM +0100, Geert Uytterhoeven wrote:
> > >>> This clock drives the irqpin controller modules.
> > >>> Before, it was assumed enabled by the bootloader or reset state.
> > >>> By making it available to the driver, we make sure it gets enabled when
> > >>> needed, and allow it to be managed by system or runtime PM.
> > >>>
> > >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >>
> > >> Hi Geert,
> > >>
> > >> should this be considered a fix?
> > >
> > > In some sense this is a fix. But I don't think anyone is suffering from it.
> > > Just poor guys like me who disable all MSTP clocks in early boot code,
> > > to find more missing clock declarations and more drivers that don't manage
> > > their clocks ;-)
> > >
> > >> If so could you cook up some text describing which patch introduced
> > >> this problem in which kernel version.
> > >
> > > I guess that would be:
> > >
> > > commit 341eb5465f67437ad37ef2f6302b581beda4614a
> > > Author: Magnus Damm <damm@opensource.se>
> > > Date:   Tue Feb 26 12:01:09 2013 +0900
> > >
> > >     ARM: shmobile: INTC External IRQ pin driver on sh73a0
> > >
> > > But I don't think it's worth adding that, or do you plan to backport
> > > this to LTSI?
> 
> Thanks. My main motivation for asking is that Olof asked about some
> recent patches that looked like fixes. So I am trying to be a bit
> better at breaking out fixes and documenting them appropriately.
> 
> > Seeing the similar fix for r8a7740 has landed in backports, I now assume
> > you will ;-)
> 
> Yes, I plan to backport this at some point.

Thanks for all your effort with this change.
After all our discussion of fixes I have decided
just to classify it as a regular change and have queued it up for v3.20.

I expect the discussion earlier in this thread will be useful when
explaining things to the arm-soc maintainers, so thanks for that material.
