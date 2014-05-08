From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 08 May 2014 13:07:07 +0900
Subject: [PATCH v4 0/4] Introduce new Kconfig for Samsung common clock
Message-ID: <1399522031-3394-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Introduce a new Kconfig file for Samsung common clock infrastructure
related config options. As current Samsung common clock gets compiled
based on PLAT_SAMSUNG, but moving ahead with ARM64 we can not have any
more such config options, so this patch introduce new COMMON_CLK_SAMSUNG
invisible option. This option also select COMMON_CLK so ARCH Kconfig just
need to select COMMON_CLK_SAMSUNG in case they want to use Samsung common
clock.

This series is based on Kukjin's for-next branch.

I am just respinning this patch after rebasing. I have already addressed
all review comments discussed here [1].

[1]: http://lkml.org/lkml/2014/3/19/216

V4:
 1) Rebased on latest Kukjin's for-next branch.

V3: 
 1) Re-organized patches for preventing bisect issues.
 2) Rebase on top of latest Kukjin's for-next branch.
 3) Compile tested exynos_defconfig, s3c6400_defconfig and s3c2410_defconfig
    after each commit.

V2:
 1) Adding new Kconfig file for Samsung common clock.
 2) Make COMMON_CLK_SAMSUNG option invisible. (as suggested by Tomasz Figa)
 3) Let COMMON_CLK_SAMSUNG select COMMON_CLK. (as suggested by Tomasz Figa)
 4) Move S3C24XX clock config option in new Kconfig file.

Pankaj Dubey (4):
  clk: samsung: add new Kconfig for Samsung common clock option
  ARM: select COMMON_CLK_SAMSUNG for ARCH_EXYNOS and ARCH_S3C64XX
  ARM: S3C24XX: move S3C24XX clock Kconfig options to Samsung clock
    Kconfig file
  drivers: clk: use COMMON_CLK_SAMSUNG for Samsung clock support

 arch/arm/Kconfig              |    4 ++--
 arch/arm/mach-s3c24xx/Kconfig |   14 --------------
 drivers/clk/Kconfig           |    2 ++
 drivers/clk/Makefile          |    2 +-
 drivers/clk/samsung/Kconfig   |   12 ++++++++++++
 5 files changed, 17 insertions(+), 17 deletions(-)
 create mode 100644 drivers/clk/samsung/Kconfig

-- 
1.7.10.4
