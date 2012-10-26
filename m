From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Oct 2012 18:27:34 +0900
Subject: [GIT PULL] Samsung fixes-2 for v3.7
Message-ID: <051a01cdb35c$21e39ae0$65aad0a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is Samsung fixes, 3 patches for v3.7.

One is spi stuff for fix the device names for the different subtypes of the
spi controller. And the other is adding missing .smp field for exynos4-dt
and fixing memory sections for exynos4210-trats board.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.7-samsung-fixes-2

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.7-samsung-fixes-2

Heiko Stuebner (1):
      ARM: SAMSUNG: Add naming of s3c64xx-spi devices

Tomasz Figa (2):
      ARM: dts: Split memory into 4 sections for exynos4210-trats
      ARM: EXYNOS: Set .smp field of machine descriptor for exynos4-dt

 arch/arm/boot/dts/exynos4210-trats.dts        |    6 +++-
 arch/arm/mach-exynos/common.c                 |    5 ++++
 arch/arm/mach-exynos/mach-exynos4-dt.c        |    1 +
 arch/arm/mach-s3c24xx/s3c2416.c               |    2 +
 arch/arm/mach-s3c24xx/s3c2443.c               |    4 +++
 arch/arm/mach-s5p64x0/common.c                |    3 ++
 arch/arm/mach-s5pc100/common.c                |    3 ++
 arch/arm/mach-s5pv210/common.c                |    3 ++
 arch/arm/plat-samsung/include/plat/spi-core.h |   30
+++++++++++++++++++++++++
 9 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/spi-core.h
