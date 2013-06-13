From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jun 2013 09:33:24 +0900
Subject: [GIT PULL 5/6] remove non-DT for exynos
In-Reply-To: <20130612233136.GB9067@quad.lixom.net>
References: <51B791EF.9070904@samsung.com>
 <20130612233136.GB9067@quad.lixom.net>
Message-ID: <143a01ce67cd$9d30a2d0$d791e870$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Wed, Jun 12, 2013 at 06:09:03AM +0900, Kukjin Kim wrote:
> > The following changes since commit
> 317ddd256b9c24b0d78fa8018f80f1e495481a10:
> >
> >   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
> >
> > are available in the git repository at:
> >
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/remove-nondt-exynos
> >
> > for you to fetch changes up to 8661bc149b95b5d4298b4ffd55c298972c4820d1:
> >
> >   ARM: exynos4_defconfig: remove non-DT configuration (2013-06-10
> > 18:37:01 +0900)
> >
> > ----------------------------------------------------------------
> > remove non DT support for exynos
> >
> > ----------------------------------------------------------------
> > Kukjin Kim (2):
> >       ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
> >       ARM: exynos4_defconfig: remove non-DT configuration
> >
> >  arch/arm/configs/exynos4_defconfig |  68 --------
> >  arch/arm/mach-exynos/Kconfig       | 320
> > +-----------------------------------
> >  arch/arm/mach-exynos/Makefile      |  26 ---
> >  arch/arm/mach-exynos/common.c      |  10 --
> >  arch/arm/mach-exynos/dev-ahci.c    | 255 -----------------------------
> >  arch/arm/mach-exynos/dev-ohci.c    |  52 ------
> >  arch/arm/mach-exynos/dma.c         | 322
> > -------------------------------------
> >  arch/arm/mach-exynos/pm_domains.c  |   7 -
> >  8 files changed, 1 insertion(+), 1059 deletions(-)
> >  delete mode 100644 arch/arm/configs/exynos4_defconfig
> >  delete mode 100644 arch/arm/mach-exynos/dev-ahci.c
> >  delete mode 100644 arch/arm/mach-exynos/dev-ohci.c
> >  delete mode 100644 arch/arm/mach-exynos/dma.c
> 
> Kukjin,
> 
Hi Olof,

> What about the legacy board files? I don't see them removed (nor converted
> to
> DT) here, so this is not a full removal.
> 
Oops, why are there still the board files :( Probably, there was a
mistake...

Thanks.

> Also, the argument to keep exynos4_defconfig was that it needed to enable
> non-DT boards. I think we might as well just remove the defconfig and make
> sure
> all the needed options are enabled in exynos_defconfig -- they should
> coexist
> just fine.
> 
OK agreed.

> I'll hold off pulling until the defconfig situation has been resolved, but
> please follow up on the board file piece too.
> 
Sure, thanks.

- Kukjin
