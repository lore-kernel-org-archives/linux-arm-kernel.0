From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Jul 2012 07:33:14 +0900
Subject: [GIT PULL] Samsung devel-2 for v3.6
Message-ID: <194f01cd65fe$7c865790$759306b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is second of development for samsung stuff v3.6.

Please pull it from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next/devel-samsung-2

The updating cpufreq for 1.7GHz of exynos5250 has been included in samsung tree because Rafael
thought it was more related in samsung platform and I agreed. And it is including new
exynos_defconfig for DT configuration of exynos4 and exynos5 together. The old exynos4_defconfig
will be used for non-DT for a while and we will try to move on using exynos_defconfig for only DT.
And others are adding G2D clock for exynos4x12 Socs.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git next/devel-samsung-2

Jaecheol Lee (1):
      [CPUFREQ] EXYNOS5250: Add support max 1.7GHz for EXYNOS5250

Olof Johansson (1):
      ARM: exynos_defconfig: enable more platforms in defconfig

Sachin Kamat (3):
      ARM: EXYNOS: Move G2D clock entries to clock-exynos4210.c file
      ARM: EXYNOS: Add G2D related clock entries for SMDK4X12
      ARM: S3C64XX: Add header file protection macros in pm-core.h

 arch/arm/configs/exynos_defconfig            |   92 ++++++++++++++++++++++++++
 arch/arm/mach-exynos/clock-exynos4.c         |   41 +-----------
 arch/arm/mach-exynos/clock-exynos4.h         |    3 +
 arch/arm/mach-exynos/clock-exynos4210.c      |   37 ++++++++++
 arch/arm/mach-exynos/clock-exynos4212.c      |   41 +++++++++++-
 arch/arm/mach-s3c64xx/include/mach/pm-core.h |    4 +
 drivers/cpufreq/exynos5250-cpufreq.c         |   55 +++++++---------
 7 files changed, 201 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm/configs/exynos_defconfig
