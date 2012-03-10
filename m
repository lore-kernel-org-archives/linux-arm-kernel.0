From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 10 Mar 2012 08:08:45 -0800
Subject: [GIT PULL 3/4] Samsung devel-mmc for v3.4
Message-ID: <4F5B7C8D.5000805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is regarding Samsung mmc for v3.4.

As a note, v3.4-for-cjb branch is merged into mmc/mmc-next like following:
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=fcd9bdae386753531a9cb6b2577359a83f4e121c

And others are accordingly changes on regarding mmc.

Please pull and if any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

   Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung-mmc

Jaehoon Chung (3):
       ARM: SAMSUNG: support the second capability for samsung-soc
       mmc: sdhci-s3c: add platform data for the second capability
       ARM: SAMSUNG: change the name from s3c-sdhci to exynos4-sdhci

Kukjin Kim (1):
       Merge branch 'v3.4-for-cjb' into next/devel-samsung-mmc

Thomas Abraham (6):
       mmc: sdhci-s3c: Remove usage of clk_type member in platform data
       ARM: EXYNOS: use 'exynos4-sdhci' as device name for sdhci controllers
       ARM: SAMSUNG: remove all uses of clk_type member in sdhci 
platform data
       mmc: sdhci-s3c: derive transfer width host capability from 
max_width in platform data
       mmc: sdhci-s3c: Keep a copy of platform data and use it
       mmc: sdhci-s3c: Add device tree support

  .../devicetree/bindings/mmc/samsung-sdhci.txt      |   70 ++++++
  arch/arm/mach-exynos/clock.c                       |   24 +-
  arch/arm/mach-exynos/common.c                      |    5 +
  arch/arm/mach-exynos/mach-armlex4210.c             |    3 -
  arch/arm/mach-exynos/mach-nuri.c                   |    7 +-
  arch/arm/mach-exynos/mach-origen.c                 |    2 -
  arch/arm/mach-exynos/mach-smdk4x12.c               |    2 -
  arch/arm/mach-exynos/mach-smdkv310.c               |    4 -
  arch/arm/mach-exynos/mach-universal_c210.c         |    4 +-
  arch/arm/plat-samsung/devs.c                       |    4 -
  arch/arm/plat-samsung/include/plat/sdhci.h         |   37 +++-
  arch/arm/plat-samsung/platformdata.c               |    4 +-
  drivers/mmc/host/sdhci-s3c.c                       |  238 
+++++++++++++++++++-
  13 files changed, 351 insertions(+), 53 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
