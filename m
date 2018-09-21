From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 21 Sep 2018 19:45:20 +0200
Subject: [GIT PULL 1/2] ARM: exynos: mach/soc for v4.20 (or 5.0)
In-Reply-To: <20180921174520.9126-1-krzk@kernel.org>
References: <20180921174520.9126-1-krzk@kernel.org>
Message-ID: <20180921174520.9126-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nothing special, description in tag.


Best regards,
Krzysztof


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.20

for you to fetch changes up to f30858439e7db9ce9847eaedf440635fc6349c6e:

  ARM: s3c24xx: Restore proper usage of pr_info/pr_cont (2018-09-19 19:11:17 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.20

1. Fix imprecise abort during Odroid XU3-family suspend to RAM (but it
   is not end of work needed for suspend).
2. Cleanup and fix of SD card write protect on MINI2440.

----------------------------------------------------------------
Cedric Roux (3):
      ARM: s3c24xx: formatting cleanup in mach-mini2440.c
      ARM: s3c24xx: Correct SD card write protect detection on Mini2440
      ARM: s3c24xx: Restore proper usage of pr_info/pr_cont

Krzysztof Kozlowski (4):
      ARM: exynos: Store Exynos5420 register state in one variable
      ARM: exynos: Fix imprecise abort during Exynos5422 suspend to RAM
      ARM: s3c24xx: Remove empty gta02_pmu children probe
      ARM: s3c24xx: Consistently use tab for indenting member assignments

 Documentation/arm/Samsung/Bootloader-interface.txt |   1 +
 arch/arm/mach-exynos/common.h                      |   1 +
 arch/arm/mach-exynos/firmware.c                    |  14 ++-
 arch/arm/mach-exynos/suspend.c                     |  34 +++++--
 arch/arm/mach-s3c24xx/mach-gta02.c                 |  42 --------
 arch/arm/mach-s3c24xx/mach-mini2440.c              | 113 +++++++++++----------
 6 files changed, 97 insertions(+), 108 deletions(-)
