From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 05 Jul 2014 12:40:45 +0530
Subject: [PATCH v5 5/5] ARM: EXYNOS: Move PMU specific definitions from
 common.h
In-Reply-To: <53B19B42.1040006@samsung.com>
References: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
 <1403705032-14835-6-git-send-email-pankaj.dubey@samsung.com>
 <53B19B42.1040006@samsung.com>
Message-ID: <001f01cf9820$3f0ee570$bd2cb050$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Monday, June 30, 2014 Tomasz Figa wrote:
> Hi Pankaj,
> 
> On 25.06.2014 16:03, Pankaj Dubey wrote:
> > This patch moves PMU specific definitions into a new file as
> > exynos-pmu.h.
> > This will help in reducing dependency of common.h in pmu.c.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >  arch/arm/mach-exynos/common.h     |   17 -----------------
> >  arch/arm/mach-exynos/exynos-pmu.h |   31
> +++++++++++++++++++++++++++++++
> >  arch/arm/mach-exynos/pm.c         |    1 +
> >  arch/arm/mach-exynos/pmu.c        |    2 +-
> >  4 files changed, 33 insertions(+), 18 deletions(-)  create mode
> > 100644 arch/arm/mach-exynos/exynos-pmu.h
> >
> > diff --git a/arch/arm/mach-exynos/common.h
> > b/arch/arm/mach-exynos/common.h index 296c6e1..0326ca2 100644
> > --- a/arch/arm/mach-exynos/common.h
> > +++ b/arch/arm/mach-exynos/common.h
> > @@ -135,23 +135,6 @@ extern struct smp_operations exynos_smp_ops;
> >
> >  extern void exynos_cpu_die(unsigned int cpu);
> >
> > -/* PMU(Power Management Unit) support */
> > -
> > -#define PMU_TABLE_END	(-1U)
> > -
> > -enum sys_powerdown {
> > -	SYS_AFTR,
> > -	SYS_LPA,
> > -	SYS_SLEEP,
> > -	NUM_SYS_POWERDOWN,
> > -};
> > -
> > -struct exynos_pmu_conf {
> > -	unsigned int offset;
> > -	unsigned int val[NUM_SYS_POWERDOWN];
> > -};
> 
> While at it, I'd say this struct could be moved to pmu.c, along with the
> PMU_TABLE_END macro as they are both private to this file.
> 

OK, I will update this.

> Best regards,
> Tomasz

Thanks,
Pankaj Dubey
