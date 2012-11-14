From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Nov 2012 14:26:31 +0900
Subject: [PATCH v2 5/5] ARM: Exynos4: Migrate clock support to common clock
 framework
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
 <1349629855-4962-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <03a501cdc228$9ad51a70$d07f4f50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:

> Thomas Abraham wrote:
> >
> > Remove Samsung specific clock support in Exynos4 and migrate to using
> > common clock framework.
> >
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> > ---
> >  arch/arm/mach-exynos/Kconfig               |    1 +
> >  arch/arm/mach-exynos/Makefile              |    3 -
> >  arch/arm/mach-exynos/clock-exynos4.c       | 1603
-----------------------
> --
> > ---
> >  arch/arm/mach-exynos/clock-exynos4.h       |   35 -
> >  arch/arm/mach-exynos/clock-exynos4210.c    |  188 ----
> >  arch/arm/mach-exynos/clock-exynos4212.c    |  192 ----
> >  arch/arm/mach-exynos/common.c              |   22 +-
> >  arch/arm/mach-exynos/common.h              |    3 +
> >  arch/arm/mach-exynos/mach-armlex4210.c     |    1 -
> >  arch/arm/mach-exynos/mach-exynos4-dt.c     |    1 -
> >  arch/arm/mach-exynos/mach-nuri.c           |    1 -
> >  arch/arm/mach-exynos/mach-origen.c         |    1 -
> >  arch/arm/mach-exynos/mach-smdk4x12.c       |    1 -
> >  arch/arm/mach-exynos/mach-smdkv310.c       |    1 -
> >  arch/arm/mach-exynos/mach-universal_c210.c |    1 -
> >  arch/arm/mach-exynos/mct.c                 |   11 +-
> >  arch/arm/plat-samsung/Kconfig              |    4 +-
> >  17 files changed, 18 insertions(+), 2051 deletions(-)  delete mode
> > 100644 arch/arm/mach-exynos/clock-exynos4.c
> >  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.h
> >  delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
> >  delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c
> 
> I think, would be better to us if we could keep this clock stuff with
> common clock for a moment, e.g. 3.8. In addition, the clock stuff is still
> updating at this moment so we need some time to move on common clock
> framework entirely. Of course, I have no objection to support common clock
> on new SoC such as exynos5440 :-)
> 
Oops, I'm resending because of e-mail client problem.

> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer, SW Solution
> Development Team, Samsung Electronics Co., Ltd.
