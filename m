From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue,  4 Jun 2013 09:49:09 +0530
Subject: [PATCH v2 0/3] Consolidate uncompress code for Samsung platform
Message-ID: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are based on v3.10-rc4.

They are build tested for s3c2410_defconfig, s3c6400_defconfig,
s5p64x0_defconfig, s5pc100_defconfig, s5pv210_defconfig,
exynos4_defconfig and exynos_defconfig.

Since they affect all the Samsung boards, testing them on different
machines would be essential. Unfortunately I can only test on Exynos here.

Tested on Exynos5250 based Arndale board.

Changes for v2:
* Instead of checking for uart_base, we are now checking whether
DEBUG_LL is enabled. This removes the ifdefs used in mach/uncompress.h
* 3rd patch has been updated by Tomasz Figa's patch that almost does
the same thing.

Tomasz Figa (1):
  ARM: s5p64x0: Use common uncompress.h part for plat-samsung

Tushar Behera (2):
  ARM: EXYNOS: uncompress - print debug messages if DEBUG_LL is defined
  ARM: SAMSUNG: Consolidate uncompress subroutine

 arch/arm/mach-exynos/include/mach/uncompress.h  |    3 -
 arch/arm/mach-s3c24xx/include/mach/uncompress.h |    3 +
 arch/arm/mach-s3c64xx/include/mach/uncompress.h |    3 +
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |  162 +----------------------
 arch/arm/mach-s5pc100/include/mach/uncompress.h |    2 +
 arch/arm/mach-s5pv210/include/mach/uncompress.h |    2 +
 arch/arm/plat-samsung/include/plat/uncompress.h |   16 ++-
 7 files changed, 27 insertions(+), 164 deletions(-)

-- 
1.7.9.5
