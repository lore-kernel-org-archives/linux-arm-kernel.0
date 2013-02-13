From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Feb 2013 20:56:36 -0800
Subject: [PATCH] ARM: S3C24XX: remove plat-samsung/irq.h
References: <201302122042.32471.heiko@sntech.de>
Message-ID: <1df801ce09a6$81ce38c0$856aaa40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Heiko St?bner wrote:
> >
> > plat-samsung/irq.h did only contain functions for handling the spread
> > out subirqs on s3c24xx arches, which are not needed anymore.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > Sorry for bringing this separate submission, but I just remembered it
> > this evening.
> >
> > This applies on top of all the other s3c24xx irq changes and I think
> > this patch will mark the end of the irq-cleanup for now.
> >
> >  arch/arm/mach-s3c24xx/irq-pm.c           |    7 ++-
> >  arch/arm/mach-s3c24xx/irq.c              |    8 +--
> >  arch/arm/plat-samsung/include/plat/irq.h |  116
> > ------------------------------
> >  3 files changed, 9 insertions(+), 122 deletions(-)  delete mode
> > 100644 arch/arm/plat-samsung/include/plat/irq.h
> >
> Applied, thanks :-)
> 
Just note, happens following error:

arch/arm/mach-s3c24xx/bast-irq.c:37:22: fatal error: plat/irq.h: No such file or directory
compilation terminated.
...
make[2]: *** [arch/arm/mach-s3c24xx/bast-irq.o] Error 1
make[2]: *** Waiting for unfinished jobs....
  CC      crypto/testmgr.o
  CC      lib/bsearch.o
  AS      arch/arm/lib/memcpy.o
  AS      arch/arm/lib/memmove.o
make[1]: *** [arch/arm/mach-s3c24xx] Error 2
make[1]: *** Waiting for unfinished jobs....

I fixed when I applied.

Thanks.

- Kukjin
