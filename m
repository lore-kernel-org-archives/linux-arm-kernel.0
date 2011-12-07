From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Dec 2011 17:47:06 +0900
Subject: [GIT PULL] Samsung fixes for v3.2
In-Reply-To: <CAH9JG2XcUHUpU5OQyv4+Q9bzbqxsekF8yvUuK4Gb6EDBpQMucw@mail.gmail.com>
References: <03e501cca837$d893e320$89bba960$%kim@samsung.com>
 <CAH9JG2XcUHUpU5OQyv4+Q9bzbqxsekF8yvUuK4Gb6EDBpQMucw@mail.gmail.com>
Message-ID: <03f301ccb4bc$cc8b8a10$65a29e30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 
> Don't you fix the mct compiler error if LOCAL_TIMERS are not defined?
> 
> arch/arm/mach-exynos/mct.c: In function 'exynos4_timer_resources':
> arch/arm/mach-exynos/mct.c:451: error: 'exynos4_mct_tick_isr'
> undeclared (first use in this function)
> arch/arm/mach-exynos/mct.c:451: error: (Each undeclared identifier is
> reported only once
> arch/arm/mach-exynos/mct.c:451: error: for each function it appears in.)
> make[1]: *** [arch/arm/mach-exynos/mct.o] Error 1
> 
Sorry for late response.

I fixed this and that will be sent to upstream next time.
Thanks for pointing out.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> On 11/21/11, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Hi Arnd,
> >
> > Please pull samsung-fixes for v3.2 from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > samsung-fixes
> >
> > This includes fix of inclusion header.
> > If any problems, please let me know.
> >
> > Thanks.
> >
> > Best regards,
> > Kgene.
> > --
> > Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> > SW Solution Development Team, Samsung Electronics Co., Ltd.
> >
> > The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:
> >
> >   Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)
> >
> > are available in the git repository at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > samsung-fixes
> >
> > Axel Lin (1):
> >       ARM: SAMSUNG: include linux/types.h at gpio-cfg.h
> >
> > Kukjin Kim (2):
> >       ARM: S5P: Fix export.h inclusion
> >       ARM: SAMSUNG: inclusion export.h instead of module.h
> >
> > Kyungmin Park (1):
> >       ARM: EXYNOS: Fix compiler error with THIS_MODULE
> >
> >  arch/arm/mach-exynos/cpuidle.c                |    2 ++
> >  arch/arm/mach-s3c64xx/mach-crag6410-module.c  |    2 +-
> >  arch/arm/plat-s3c24xx/cpu-freq-debugfs.c      |    2 +-
> >  arch/arm/plat-s5p/sysmmu.c                    |    1 +
> >  arch/arm/plat-samsung/include/plat/gpio-cfg.h |    2 ++
> >  arch/arm/plat-samsung/pd.c                    |    2 +-
> >  arch/arm/plat-samsung/pwm.c                   |    2 +-
> >  7 files changed, 9 insertions(+), 4 deletions(-)
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> > in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
