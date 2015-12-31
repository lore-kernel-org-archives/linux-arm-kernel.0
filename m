From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 16:11:54 +0100
Subject: [PATCH] ARM: default to multi_v7_defconfig
In-Reply-To: <20151222101834.GE32623@arm.com>
References: <2084866.x9T7k7V9eW@wuerfel> <20151222101834.GE32623@arm.com>
Message-ID: <5177946.MPbmr7k9Kd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015 10:18:35 Will Deacon wrote:
> On Fri, Dec 18, 2015 at 11:44:23PM +0100, Arnd Bergmann wrote:
> > versatile_defconfig has not been a reasonable default for a very long
> > time, there is very little work happening on this platform and it's
> > based on an old ARM926 CPU core.
> > 
> > This changes the default to multi_v7_defconfig, which is much more
> > relevant to anyone doing a build test on ARM, as it covers a wide
> > range of platforms.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 2c2b28ee4811..e9fb67913e6e 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -30,9 +30,8 @@ GZFLAGS             :=-9
> >  # Never generate .eh_frame
> >  KBUILD_CFLAGS        += $(call cc-option,-fno-dwarf2-cfi-asm)
> >  
> > -# Do not use arch/arm/defconfig - it's always outdated.
> > -# Select a platform tht is kept up-to-date
> > -KBUILD_DEFCONFIG := versatile_defconfig
> > +# This should work on most of the modern platforms
> > +KBUILD_DEFCONFIG := multi_v7_defconfig
> >  
> >  # defines filename extension depending memory management type.
> >  ifeq ($(CONFIG_MMU),)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
... 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I've applied this patch to the next/defconfig branch of arm-soc now,
as it seems to fit in with the defconfig changes better than in Russell's
tree.

Thanks,

	Arnd
