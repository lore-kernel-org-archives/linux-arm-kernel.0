From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 22:12:42 +0800
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
Message-ID: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the arch_decomp_wdog related codes are there without any users,
since ARCH_HAS_DECOMP_WDOG is only used by lib/inflate.c which however
is not used by arch/arm/boot/compressed/decompress.c.

Shawn Guo (3):
  ARM: decompress: remove unused ARCH_HAS_DECOMP_WDOG
  ARM: remove unused arch_decomp_wdog()
  ARM: samsung: remove unused arch_decomp_wdog() code

 arch/arm/boot/compressed/decompress.c              |    2 --
 arch/arm/mach-at91/include/mach/uncompress.h       |    2 --
 arch/arm/mach-bcm2835/include/mach/uncompress.h    |    1 -
 arch/arm/mach-clps711x/include/mach/uncompress.h   |    2 --
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-davinci/include/mach/uncompress.h    |    1 -
 arch/arm/mach-dove/include/mach/uncompress.h       |    1 -
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |    1 -
 arch/arm/mach-ep93xx/include/mach/uncompress.h     |    2 --
 arch/arm/mach-footbridge/include/mach/uncompress.h |    1 -
 arch/arm/mach-gemini/include/mach/uncompress.h     |    2 --
 arch/arm/mach-h720x/include/mach/uncompress.h      |    1 -
 arch/arm/mach-integrator/include/mach/uncompress.h |    2 --
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-iop32x/include/mach/uncompress.h     |    1 -
 arch/arm/mach-iop33x/include/mach/uncompress.h     |    1 -
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |    2 --
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |    1 -
 arch/arm/mach-ks8695/include/mach/uncompress.h     |    1 -
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-mmp/include/mach/uncompress.h        |    6 -----
 arch/arm/mach-msm/include/mach/uncompress.h        |    4 ---
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    1 -
 arch/arm/mach-mxs/include/mach/uncompress.h        |    1 -
 arch/arm/mach-netx/include/mach/uncompress.h       |    1 -
 arch/arm/mach-nomadik/include/mach/uncompress.h    |    2 --
 arch/arm/mach-omap1/include/mach/uncompress.h      |    5 ----
 arch/arm/mach-omap2/include/mach/uncompress.h      |    5 ----
 arch/arm/mach-orion5x/include/mach/uncompress.h    |    1 -
 arch/arm/mach-prima2/include/mach/uncompress.h     |    2 --
 arch/arm/mach-pxa/include/mach/uncompress.h        |    5 ----
 arch/arm/mach-realview/include/mach/uncompress.h   |    1 -
 arch/arm/mach-rpc/include/mach/uncompress.h        |    5 ----
 arch/arm/mach-s5p64x0/include/mach/uncompress.h    |   28 --------------------
 arch/arm/mach-sa1100/include/mach/uncompress.h     |    1 -
 arch/arm/mach-shark/include/mach/uncompress.h      |    1 -
 arch/arm/mach-shmobile/include/mach/uncompress.h   |    2 --
 arch/arm/mach-tegra/include/mach/uncompress.h      |    4 ---
 arch/arm/mach-u300/include/mach/uncompress.h       |    1 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |    2 --
 arch/arm/mach-versatile/include/mach/uncompress.h  |    1 -
 arch/arm/mach-vt8500/include/mach/uncompress.h     |    1 -
 arch/arm/mach-w90x900/include/mach/uncompress.h    |    2 --
 arch/arm/plat-samsung/include/plat/uncompress.h    |   28 --------------------
 arch/arm/plat-spear/include/plat/uncompress.h      |    1 -
 45 files changed, 138 deletions(-)

-- 
1.7.9.5
