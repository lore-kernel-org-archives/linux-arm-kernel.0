From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 May 2012 16:38:54 +0900
Subject: [GIT PULL] cleanup samsung plat-s3c24xx and s5p for v3.5
In-Reply-To: <CAOesGMgk+-cqmDmhsjM9fhRpwxV4jNf4y+z1AKWpu8a=6wqkCw@mail.gmail.com>
References: <4FAEEFD3.9040907@samsung.com>
 <CAOesGMgk+-cqmDmhsjM9fhRpwxV4jNf4y+z1AKWpu8a=6wqkCw@mail.gmail.com>
Message-ID: <064c01cd31a4$9ddd5c60$d9981520$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> Hi,
> 
Hi,

> On Sat, May 12, 2012 at 4:18 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Hi Arnd, Olof
> >
> > Please pull cleanup plat-s3c24xx-s5p for v3.5 Samsung stuff.
> >
> > ?git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > next/cleanup-plat-s3c24xx-s5p
> >
> > We can remove plat-s5p directory with this series and I think, the
> > plat-s3c24xx can be removed next time for one plat-samsung of Samsung
> stuff.
> 
> Nice!
> 
> > Note, this is including cleanup-samsung-iommu which is removing s5p
> iommu
> > stuff in plat-s5p.
> 
> What branch is that? I've not seen a pull request for it.
> 
It is next/cleanup-samsung-iommu branch and already included in
next/cleanup-plat-s3c24xx branch as a base because as I said, that is needed
to remove plat-s5p directory.
So in this case, would be better if you could pull following branch before
pulling next/cleanup-plat-s3c24xx-s5p and sorry for missing pull request it.

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-samsung-iommu

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-samsung-iommu

KyongHo Cho (2):
      S5P: SYSMMU: Remove System MMU device driver
      ARM: EXYNOS: Change System MMU platform device definitions

 arch/arm/mach-exynos/Kconfig                    |   10 +-
 arch/arm/mach-exynos/Makefile                   |    2 +-
 arch/arm/mach-exynos/clock-exynos4.c            |   79 ++--
 arch/arm/mach-exynos/clock-exynos4.h            |    2 +
 arch/arm/mach-exynos/clock-exynos4210.c         |   11 +
 arch/arm/mach-exynos/clock-exynos4212.c         |   28 ++-
 arch/arm/mach-exynos/clock-exynos5.c            |   90 +++++
 arch/arm/mach-exynos/dev-sysmmu.c               |  457
++++++++++++----------
 arch/arm/mach-exynos/include/mach/irqs.h        |   25 +-
 arch/arm/mach-exynos/include/mach/map.h         |   38 ++
 arch/arm/mach-exynos/include/mach/regs-clock.h  |    5 +
 arch/arm/mach-exynos/include/mach/regs-sysmmu.h |   28 --
 arch/arm/mach-exynos/include/mach/sysmmu.h      |   88 +++--
 arch/arm/mach-exynos/mach-armlex4210.c          |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c            |    1 -
 arch/arm/plat-s5p/Kconfig                       |    8 -
 arch/arm/plat-s5p/Makefile                      |    1 -
 arch/arm/plat-s5p/sysmmu.c                      |  313 ----------------
 arch/arm/plat-samsung/include/plat/devs.h       |    1 -
 arch/arm/plat-samsung/include/plat/sysmmu.h     |   95 -----
 20 files changed, 529 insertions(+), 754 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-sysmmu.h
 delete mode 100644 arch/arm/plat-s5p/sysmmu.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/sysmmu.h
