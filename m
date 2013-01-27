From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 27 Jan 2013 12:41:21 +0100
Subject: [PATCH v3 0/9] ARM: S3C24XX: rework irq handling for a later dt
 usage
In-Reply-To: <016101cdfb2e$15cbd640$416382c0$@samsung.com>
References: <201301190403.50317.heiko@sntech.de>
 <016101cdfb2e$15cbd640$416382c0$@samsung.com>
Message-ID: <201301271241.21651.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 25. Januar 2013, 19:59:18 schrieb Kukjin Kim:
> Heiko St?bner wrote:
> > Third version of redoing the s3c24xx irqs in a generic way by using a
> > declarative approach.
> > 
> > Main change is the different approach to the init. Moved the
> > s3c24xx_init_intc function from the dt patchset here, so that both init
> > types (dt and non-dt) can use a similar init scheme.
> > 
> > As in the second version, the 1st patch might be hard to read due to the
> > rewrite character, but I didn't see a way to do these changes in
> > individual steps. So it might be helpful to look at the result after
> > applying this patch.
> > 
> > Runtime-tested on a s3c2416 based board and compile tested for the
> > others.
> > 
> > As also written before, inclusion of the other S3C24XX SoCs to follow
> > once the general approach is acceptable.
> > 
> > Applies to the most current for-next (from two hours ago) from linux-
> > samsung
> > 
> > Heiko Stuebner (9):
> >   ARM: S3C24XX: transform irq handling into a declarative form
> >   ARM: S3C24XX: Move irq syscore-ops to irq-pm
> >   ARM: S3C24XX: Modify s3c_irq_wake to use the hwirq property
> >   ARM: S3C24XX: move s3c2416 irq init to common irq code
> >   ARM: S3C24XX: modify s3c2416 irq init to initialize all irqs
> >   ARM: S3C24XX: transform s3c2416 irqs into new structure
> >   ARM: S3C24XX: move s3c2443 irq code to irq.c
> >   ARM: S3C24XX: modify s3c2443 irq init to initialize all irqs
> >   ARM: S3C24XX: transform s3c2443 subirqs into new structure
> >  
> >  arch/arm/mach-s3c24xx/Makefile               |    4 +-
> >  arch/arm/mach-s3c24xx/common.h               |    2 +
> >  arch/arm/mach-s3c24xx/irq-pm.c               |   41 +-
> >  arch/arm/mach-s3c24xx/irq-s3c2416.c          |  348 --------
> >  arch/arm/mach-s3c24xx/irq-s3c2443.c          |  281 -------
> >  arch/arm/mach-s3c24xx/mach-smdk2416.c        |    2 +-
> >  arch/arm/mach-s3c24xx/mach-smdk2443.c        |    2 +-
> >  arch/arm/mach-s3c24xx/s3c2410.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2412.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2416.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2440.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2442.c              |    4 +-
> >  arch/arm/plat-s3c24xx/Kconfig                |    1 +
> >  arch/arm/plat-s3c24xx/irq.c                  | 1110
> >  +++++++++++++++----------- arch/arm/plat-samsung/include/plat/pm.h     
> >  |    6 -
> >  arch/arm/plat-samsung/include/plat/s3c2416.h |    1 +
> >  arch/arm/plat-samsung/include/plat/s3c2443.h |    2 +
> >  17 files changed, 688 insertions(+), 1132 deletions(-)
> >  delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2416.c
> >  delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2443.c
> > 
> > --
> > 1.7.2.3
> 
> Heiko, looks good to me :-)
very cool :-)

> BTW, can you rebase this against on next/cleanup-s3c24xx branch in my tree?
will try to do this today


Heiko
