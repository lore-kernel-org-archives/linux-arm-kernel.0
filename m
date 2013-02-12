From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Feb 2013 11:13:29 -0800
Subject: [PATCH v2 00/10] ARM: S3C24XX: irq rework for S3C2412,
 S3C2440 and S3C2442
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <1d8801ce0955$0bef8600$23ce9200$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> This series finishes the irq rework by moving the irqs for s3c2412, s3c2440
> and s3c2442 into the new structure.
> 
> Now the only open point is the different handling of the eint0 to eint3
> interrupts on the s3c2412. On this SoC these interrupts are represented
> in both the main register and the eint register and also need to be handled
> in both.
> 
> As this should be handlable via the new structure, I'm still investigating
> the right way to do it. Therefore the override of the eint0 to eint3
> interrupts will still remain for a bit.
> 
> As I lack the relevant hardware, this series is compile tested only, but as
> the used mechanisms are the same as with the s3c2416, there shouldn't be
> any complications.
> 
> This series applies on top of the moved s3c24XX.h headers into the
> common.h
> file in mach-s3c24xx.
> 
> changes since v1:
> - included the changes for the s3c2412
> 
> Heiko Stuebner (10):
>   ARM: S3C24XX: move s3c244x irq init to common irq code
>   ARM: S3C24XX: create dedicated irq init functions for s3c2440 and s3c2442
>   ARM: S3C24XX: move s3c2440 irqs to common irq code
>   ARM: S3C24XX: integrate s3c2440 irqs into common init
>   ARM: S3C24XX: transform s3c2442 irqs into new structure
>   ARM: S3C24XX: transform s3c2440 irqs into new structure
>   ARM: S3C24XX: use samsung_sync_wakemask in s3c2412 pm
>   ARM: S3C24XX: move s3c2412 irq init to common code
>   ARM: S3C24XX: modify s3c2412 irq init to initialize all irqs
>   ARM: S3C24XX: transform s3c2412 irqs into new structure
> 
>  arch/arm/mach-s3c24xx/Kconfig          |    1 +
>  arch/arm/mach-s3c24xx/Makefile         |    6 +-
>  arch/arm/mach-s3c24xx/common.h         |    3 +
>  arch/arm/mach-s3c24xx/irq-s3c2412.c    |  215 -----------------------
>  arch/arm/mach-s3c24xx/irq-s3c2440.c    |  128 --------------
>  arch/arm/mach-s3c24xx/irq-s3c244x.c    |  142 ---------------
>  arch/arm/mach-s3c24xx/irq.c            |  299
> ++++++++++++++++++++++++++++++++
>  arch/arm/mach-s3c24xx/mach-anubis.c    |    2 +-
>  arch/arm/mach-s3c24xx/mach-at2440evb.c |    2 +-
>  arch/arm/mach-s3c24xx/mach-gta02.c     |    2 +-
>  arch/arm/mach-s3c24xx/mach-jive.c      |    2 +-
>  arch/arm/mach-s3c24xx/mach-mini2440.c  |    2 +-
>  arch/arm/mach-s3c24xx/mach-nexcoder.c  |    2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c    |    2 +-
>  arch/arm/mach-s3c24xx/mach-rx1950.c    |    2 +-
>  arch/arm/mach-s3c24xx/mach-rx3715.c    |    7 +-
>  arch/arm/mach-s3c24xx/mach-smdk2413.c  |    6 +-
>  arch/arm/mach-s3c24xx/mach-smdk2440.c  |    2 +-
>  arch/arm/mach-s3c24xx/mach-vstms.c     |    2 +-
>  arch/arm/mach-s3c24xx/pm-s3c2412.c     |    8 +
>  20 files changed, 328 insertions(+), 507 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2412.c
>  delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2440.c
>  delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c244x.c
> 
> --
> 1.7.2.3

Applied, this whole series and integration 2412 eint handling.

Thanks for your time and support.

- Kukjin
