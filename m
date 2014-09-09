From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Sep 2014 08:45:10 +0900
Subject: [PATCH 1/3] kbuild: remove unnecessary "obj- := dummy.o" trick
In-Reply-To: <20140909174337.19023.97772@quantum>
References: <1410258381-7088-1-git-send-email-yamada.m@jp.panasonic.com>
 <1410258381-7088-2-git-send-email-yamada.m@jp.panasonic.com>
 <20140909174337.19023.97772@quantum>
Message-ID: <20140909234510.GB16682@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 10:43:37AM -0700, Mike Turquette wrote:
> Quoting Masahiro Yamada (2014-09-09 03:26:19)
> > In these Makefiles, at least one of "obj-y" and "obj-" is non-empty,
> > hence built-in.o is always created without such a trick.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>

shmobile portion:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> > ---
> > 
> >  arch/arm/plat-samsung/Makefile | 1 -
> >  drivers/clk/shmobile/Makefile  | 2 --
> >  drivers/net/wimax/Makefile     | 4 ----
> >  3 files changed, 7 deletions(-)
> > 
> > diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> > index 5fe1750..a402262 100644
> > --- a/arch/arm/plat-samsung/Makefile
> > +++ b/arch/arm/plat-samsung/Makefile
> > @@ -8,7 +8,6 @@ ccflags-$(CONFIG_ARCH_MULTI_V7) += -I$(srctree)/$(src)/include
> >  
> >  obj-y                          :=
> >  obj-m                          :=
> > -obj-n                          := dummy.o
> >  obj-                           :=
> >  
> >  # Objects we always build independent of SoC choice
> > diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> > index e002923..9aab51c8 100644
> > --- a/drivers/clk/shmobile/Makefile
> > +++ b/drivers/clk/shmobile/Makefile
> > @@ -6,5 +6,3 @@ obj-$(CONFIG_ARCH_R8A7790)              += clk-rcar-gen2.o
> >  obj-$(CONFIG_ARCH_R8A7791)             += clk-rcar-gen2.o
> >  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-div6.o
> >  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-mstp.o
> > -# for emply built-in.o
> > -obj-n  := dummy
> > diff --git a/drivers/net/wimax/Makefile b/drivers/net/wimax/Makefile
> > index 992bc02..692184d 100644
> > --- a/drivers/net/wimax/Makefile
> > +++ b/drivers/net/wimax/Makefile
> > @@ -1,5 +1 @@
> > -
> >  obj-$(CONFIG_WIMAX_I2400M)     += i2400m/
> > -
> > -# (from Sam Ravnborg) force kbuild to create built-in.o
> > -obj- := dummy.o
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
