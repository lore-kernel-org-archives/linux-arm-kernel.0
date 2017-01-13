From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 13 Jan 2017 17:20:27 +0200
Subject: [GIT PULL 1/4] ARM: exynos: Mach/soc for v4.11
Message-ID: <20170113152030.13586-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Mostly cleanups for v4.11.

Best regards,
Krzysztof


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.11

for you to fetch changes up to cda1a52dab50340728e46601e6c9da9fc4beaf1f:

  ARM: s3c64xx: Constify wake_irqs (2016-12-29 15:41:44 +0200)

----------------------------------------------------------------
Samsung mach/soc update for v4.11. Mostly cleanups:
1. Removal of unused platform data in S3C24XX and S3C64xx as follow up of
   conversion to new DMA channel request API.
2. Adding const and __ro_after_init to various data in Samsung platforms.

----------------------------------------------------------------
Krzysztof Kozlowski (7):
      ARM: EXYNOS: Constify list of retention registers
      ARM: EXYNOS: Annotate iomem and pm_data pointers __ro_after_init
      ARM: s3c24xx: Constify few integer tables
      ARM: s3c64xx: Annotate external clock frequencies __ro_after_init
      ARM: SAMSUNG: Constify array of wake irqs passed to samsung_sync_wakemask
      ARM: s3c24xx: Constify wake_irqs
      ARM: s3c64xx: Constify wake_irqs

Sylwester Nawrocki (2):
      ARM: s3c64xx: Drop initialization of unused struct s3c_audio_pdata fields
      ARM: s3c24xx: Drop unused struct s3c_audio_pdata entries

 arch/arm/mach-exynos/exynos.c                    |  4 ++--
 arch/arm/mach-exynos/mcpm-exynos.c               |  2 +-
 arch/arm/mach-exynos/suspend.c                   | 10 +++++-----
 arch/arm/mach-s3c24xx/bast-irq.c                 |  4 ++--
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c         |  2 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c               |  2 +-
 arch/arm/mach-s3c64xx/common.c                   |  3 ++-
 arch/arm/mach-s3c64xx/dev-audio.c                | 19 -------------------
 arch/arm/mach-s3c64xx/pm.c                       |  2 +-
 arch/arm/plat-samsung/devs.c                     | 19 -------------------
 arch/arm/plat-samsung/include/plat/wakeup-mask.h |  2 +-
 arch/arm/plat-samsung/wakeup-mask.c              |  2 +-
 12 files changed, 17 insertions(+), 54 deletions(-)
