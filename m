From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 00:04:40 +0900
Subject: [GIT PULL 1/7] Samsung cleanup for v3.8
Message-ID: <50AB9C08.2080604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull Samsung cleanup for v3.8 from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-samsung-2

Most of them are just removing patches, if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

   Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-samsung-2

Alexander Varnin (1):
       ARM: S3C24XX: SPI clock channel setup is fixed for S3C2443

Andrey Gusakov (2):
       ARM: S3C64XX: Remove duplicated camera clock
       ARM: S3C64XX: Statically define parent clock of "camera" clock

Daniel Kurtz (1):
       ARM: EXYNOS: no duplicate mask/unmask in eint0_15

Eunki Kim (1):
       ARM: SAMSUNG: use devm_ functions for ADC driver

Jaehoon Chung (1):
       ARM: EXYNOS: remove the MMC_CAP2_BROKEN_VOLTAGE

Jingoo Han (1):
       ARM: EXYNOS: reorder inclusions of <linux/platform_data/xxx.h>

Kukjin Kim (1):
       Merge branch 'next/cleanup-samsung' into next/cleanup-samsung-2

Sachin Kamat (2):
       ARM: EXYNOS: Make combiner_of_init function static
       ARM: EXYNOS: Add missing static storage class specifiers in 
clock-exynos5.c

Sangsu Park (1):
       ARM: EXYNOS: Remove wrong I2S0 clock from peril clock

Thomas Abraham (3):
       ARM: EXYNOS: Remove static io-remapping for gic and combiner
       ARM: EXYNOS: Remove unused static uart resource information
       ARM: EXYNOS: Remove i2c0 resource information and setting of 
device names

Tomasz Figa (1):
       ARM: EXYNOS: Make s3c_device_i2c0 always use id 0

Vivek Gautam (1):
       ARM: EXYNOS: Remove wrongly placed usb2.0 PHY_CFG definition from 
PMU_REG

  arch/arm/mach-exynos/clock-exynos4.c         |    5 --
  arch/arm/mach-exynos/clock-exynos5.c         |   18 ++++----
  arch/arm/mach-exynos/common.c                |   58 
++++----------------------
  arch/arm/mach-exynos/dev-audio.c             |    2 +-
  arch/arm/mach-exynos/dev-ohci.c              |    2 +-
  arch/arm/mach-exynos/dev-uart.c              |   24 -----------
  arch/arm/mach-exynos/include/mach/irqs.h     |    5 --
  arch/arm/mach-exynos/include/mach/map.h      |    1 -
  arch/arm/mach-exynos/include/mach/regs-pmu.h |    2 -
  arch/arm/mach-exynos/mach-nuri.c             |    7 +--
  arch/arm/mach-exynos/mach-origen.c           |    6 +-
  arch/arm/mach-exynos/mach-smdk4x12.c         |    2 +-
  arch/arm/mach-exynos/mach-smdkv310.c         |    6 +-
  arch/arm/mach-exynos/mach-universal_c210.c   |    5 +-
  arch/arm/mach-s3c24xx/clock-s3c2443.c        |    6 ---
  arch/arm/mach-s3c64xx/clock.c                |   20 +--------
  arch/arm/mach-s5pv210/mach-goni.c            |    1 -
  arch/arm/plat-samsung/adc.c                  |   48 ++++++---------------
  arch/arm/plat-samsung/devs.c                 |    4 --
  19 files changed, 45 insertions(+), 177 deletions(-)
