From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 15 Oct 2017 09:48:24 +0200
Subject: [GIT PULL 1/4] ARM: exynos: mach/soc for v4.15
In-Reply-To: <20171015074825.11338-1-krzk@kernel.org>
References: <20171015074825.11338-1-krzk@kernel.org>
Message-ID: <20171015074825.11338-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.15

for you to fetch changes up to 9e43eca3c87476f75680f472ff3ebcd85f357b86:

  ARM: EXYNOS: Remove Exynos4212 related dead code (2017-10-08 13:52:09 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.15

1. Cleanups for s3c24xx and s3c64xx (memory allocation printks, code
   style).
2. Remove of Exynos4212 related dead code (no more support for this
   SoC).

----------------------------------------------------------------
Marek Szyprowski (1):
      ARM: EXYNOS: Remove Exynos4212 related dead code

Markus Elfring (7):
      ARM: s3c24xx: Remove printk for failed memory allocation in iotiming get
      ARM: s3c24xx: Simplify size used for kzalloc in iotiming get
      ARM: s3c2410: Fix typos in a comments
      ARM: s3c64xx: Remove printk for failed memory allocation in samsung_bl_set
      ARM: s3c64xx: Delete an unnecessary return statement in samsung_bl_set
      ARM: SAMSUNG: Remove printk for failed memory allocation
      ARM: SAMSUNG: Simplify size used for kzalloc

 arch/arm/mach-exynos/Kconfig             |  5 -----
 arch/arm/mach-exynos/common.h            | 11 +----------
 arch/arm/mach-exynos/exynos.c            |  2 --
 arch/arm/mach-exynos/firmware.c          |  5 -----
 arch/arm/mach-exynos/pm.c                |  3 +--
 arch/arm/mach-exynos/suspend.c           |  4 ----
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c |  8 +++-----
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c |  8 +++-----
 arch/arm/mach-s3c64xx/dev-backlight.c    | 10 +++-------
 arch/arm/plat-samsung/adc.c              | 12 ++++--------
 arch/arm/plat-samsung/devs.c             | 33 +++++++++++---------------------
 arch/arm/plat-samsung/platformdata.c     |  4 +---
 12 files changed, 27 insertions(+), 78 deletions(-)
