From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 31 May 2013 17:19:01 +0530
Subject: [PATCH 0/3] Consolidate uncompress code for Samsung platform
Message-ID: <1370000944-19786-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are based on v3.10-rc3.

They are build tested for s3c2410_defconfig, s3c6400_defconfig,
s5p64x0_defconfig, s5pc100_defconfig, s5pv210_defconfig,
exynos4_defconfig and exynos_defconfig.

Since they affect all the Samsung boards, testing them on different
machines would be essential. Unfortunately I can only test on Exynos here.

Tested on Exynos5250 based Arndale board.

Tushar Behera (3):
  ARM: EXYNOS: uncompress - print debug messages if DEBUG_LL is defined
  ARM: SAMSUNG: Consolidate uncompress subroutine
  ARM: S5P64X0: Remove duplicate uncompress code

 arch/arm/mach-exynos/include/mach/uncompress.h  |   14 +-
 arch/arm/mach-s3c24xx/include/mach/uncompress.h |    7 +
 arch/arm/mach-s3c64xx/include/mach/uncompress.h |    7 +
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |  163 ++---------------------
 arch/arm/mach-s5pc100/include/mach/uncompress.h |    6 +
 arch/arm/mach-s5pv210/include/mach/uncompress.h |    6 +
 arch/arm/plat-samsung/include/plat/uncompress.h |   16 ++-
 7 files changed, 53 insertions(+), 166 deletions(-)

-- 
1.7.9.5
