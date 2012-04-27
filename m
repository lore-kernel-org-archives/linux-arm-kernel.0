From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Apr 2012 07:27:30 -0700
Subject: [GIT PULL] 3rd Samsung fixes for v3.4
Message-ID: <4F9AACD2.80308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here this pull request includes fix for some remained build error and 
warning for samsung stuff and change the device name for exynos4 sdhci 
according to change of regarding driver and fix gic initializer for 
exynos5 dt.

Please pull from:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.4-samsung-fixes-3

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

   Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.4-samsung-fixes-3

Arnd Bergmann (1):
       ARM: mini2440_defconfig: Fix build error

Kukjin Kim (2):
       ARM: S3C24XX: Fix build warning for S3C2410_PM
       ARM: EXYNOS: Fix resource on dev-dwmci.c

Marek Szyprowski (1):
       ARM: SAMSUNG: add missing MMC_CAP2_BROKEN_VOLTAGE capability

Thomas Abraham (2):
       ARM: EXYNOS: use 'exynos4-sdhci' as device name for sdhci controllers
       ARM: EXYNOS: Fix incorrect initialization of GIC

Tushar Behera (1):
       ARM: EXYNOS: Fix compilation error when CONFIG_OF is not defined

  arch/arm/configs/mini2440_defconfig        |    2 ++
  arch/arm/mach-exynos/clock-exynos4.c       |   24 ++++++++++++------------
  arch/arm/mach-exynos/clock-exynos5.c       |   24 ++++++++++++------------
  arch/arm/mach-exynos/common.c              |   14 +++++++++++++-
  arch/arm/mach-exynos/dev-dwmci.c           |   13 +++----------
  arch/arm/mach-exynos/mach-nuri.c           |    1 +
  arch/arm/mach-exynos/mach-universal_c210.c |    1 +
  arch/arm/mach-s3c24xx/Kconfig              |    8 ++++----
  arch/arm/mach-s5pv210/mach-goni.c          |    2 ++
  arch/arm/plat-samsung/include/plat/sdhci.h |   28 
++++++++++++++++++++++++++++
  10 files changed, 78 insertions(+), 39 deletions(-)
