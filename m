From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 13 May 2010 08:28:29 +0100
Subject: [PATCH] ARM: S5PC100: Modified the clock code to conform to
	Samsung clock API.
In-Reply-To: <005101caf268$1f852320$5e8f6960$%szyprowski@samsung.com>
References: <1273713001-15028-1-git-send-email-kgene.kim@samsung.com>
	<005101caf268$1f852320$5e8f6960$%szyprowski@samsung.com>
Message-ID: <20100513072829.GA27571@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 08:47:10AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On Thursday, May 13, 2010 3:10 AM Kukjin Kim wrote:
> 
> > From: Thomas Abraham <thomas.ab@samsung.com>
> > 
> > Re-worked the existing clock code for Samsung's S5PC100 SoC to be in
> > sync with new clock API.
> > 
> > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  arch/arm/mach-s5pc100/Makefile                  |    2 +-
> >  arch/arm/mach-s5pc100/clock.c                   | 1368
> > +++++++++++++++++++++++
> >  arch/arm/mach-s5pc100/include/mach/regs-clock.h |   71 ++
> >  arch/arm/plat-s5p/clock.c                       |    2 +-
> >  arch/arm/plat-s5p/include/plat/pll.h            |   22 +
> >  arch/arm/plat-s5p/include/plat/s5p-clock.h      |    2 +
> >  6 files changed, 1465 insertions(+), 2 deletions(-)
> >  create mode 100755 arch/arm/mach-s5pc100/clock.c
> >  create mode 100644 arch/arm/mach-s5pc100/include/mach/regs-clock.h
> > 
> > diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-
> > s5pc100/Makefile
> > index 809ff10..8540509 100644
> > --- a/arch/arm/mach-s5pc100/Makefile
> > +++ b/arch/arm/mach-s5pc100/Makefile
> > @@ -11,7 +11,7 @@ obj-				:=
> > 
> >  # Core support for S5PC100 system
> > 
> > -obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
> > +obj-$(CONFIG_CPU_S5PC100)	+= cpu.o clock.o
> 
> This currently causes a build break. 

would be nice to show what the build break is...
 
> Anyway, I will try to use this patch as a base for my s5pc100 patch
> series.
> 
> > ...
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
