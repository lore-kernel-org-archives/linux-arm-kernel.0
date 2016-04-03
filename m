From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:18 +0900
Subject: [RFC PATCH 0/9] ARM: start to move arch/arm/mach-* to
 arch/arm/platforms/*
Message-ID: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have growing number of mach-* directories in arch/arm, and I guess
it might be a good time to discuss moving them into a sub-directory.

I moved 8 mach directories of modern SoCs (uniphier, zynq, sunxi,
socfpga, rockchip, mediatek, highbank, bcm) as examples.

Of course, I do not mean we can take this series soon (that's why it
is an RFC), but I just want to know experts' insight about the idea
and possible problems (at least a bunch of conflicts if applied).



Masahiro Yamada (9):
  ARM: prepare arch/arm/platforms for immigration
  ARM: uniphier: move mach-uniphier/ to platforms/uniphier/
  ARM: zynq: move mach-zynq/ to platforms/zynq/
  ARM: sunxi: move mach-sunxi/ to platforms/sunxi/
  ARM: socfpga: move mach-socfpga/ to platforms/socfpga/
  ARM: rockchip: move mach-rockchip/ to platforms/rockchip/
  ARM: mediatek: move mach-mediatek/ to platforms/mediatek/
  ARM: highbank: move mach-highbank/ to platforms/highbank/
  ARM: bcm: move mach-bcm/ to platforms/bcm/

 arch/arm/Kconfig                                       | 18 ++----------------
 arch/arm/Makefile                                      |  9 +--------
 arch/arm/platforms/Kconfig                             | 10 ++++++++++
 arch/arm/platforms/Makefile                            | 10 ++++++++++
 arch/arm/{mach-bcm => platforms/bcm}/Kconfig           |  0
 arch/arm/{mach-bcm => platforms/bcm}/Makefile          |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx.c         |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_pmb.c     |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.c     |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.h     |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_5301x.c       |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_cygnus.c      |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.c    |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.h    |  0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_nsp.c         |  0
 arch/arm/{mach-bcm => platforms/bcm}/board_bcm21664.c  |  0
 arch/arm/{mach-bcm => platforms/bcm}/board_bcm281xx.c  |  0
 arch/arm/{mach-bcm => platforms/bcm}/board_bcm2835.c   |  0
 arch/arm/{mach-bcm => platforms/bcm}/brcmstb.c         |  0
 arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.c   |  0
 arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.h   |  0
 arch/arm/{mach-bcm => platforms/bcm}/platsmp-brcmstb.c |  0
 arch/arm/{mach-bcm => platforms/bcm}/platsmp.c         |  0
 arch/arm/{mach-highbank => platforms/highbank}/Kconfig |  0
 .../arm/{mach-highbank => platforms/highbank}/Makefile |  0
 arch/arm/{mach-highbank => platforms/highbank}/core.h  |  0
 .../{mach-highbank => platforms/highbank}/highbank.c   |  0
 arch/arm/{mach-highbank => platforms/highbank}/pm.c    |  0
 arch/arm/{mach-highbank => platforms/highbank}/smc.S   |  0
 .../{mach-highbank => platforms/highbank}/sysregs.h    |  0
 .../arm/{mach-highbank => platforms/highbank}/system.c |  0
 arch/arm/{mach-mediatek => platforms/mediatek}/Kconfig |  0
 .../arm/{mach-mediatek => platforms/mediatek}/Makefile |  0
 .../{mach-mediatek => platforms/mediatek}/mediatek.c   |  0
 .../{mach-mediatek => platforms/mediatek}/platsmp.c    |  0
 arch/arm/{mach-rockchip => platforms/rockchip}/Kconfig |  0
 .../arm/{mach-rockchip => platforms/rockchip}/Makefile |  0
 arch/arm/{mach-rockchip => platforms/rockchip}/core.h  |  0
 .../{mach-rockchip => platforms/rockchip}/headsmp.S    |  0
 .../{mach-rockchip => platforms/rockchip}/platsmp.c    |  0
 arch/arm/{mach-rockchip => platforms/rockchip}/pm.c    |  0
 arch/arm/{mach-rockchip => platforms/rockchip}/pm.h    |  0
 .../{mach-rockchip => platforms/rockchip}/rockchip.c   |  0
 arch/arm/{mach-rockchip => platforms/rockchip}/sleep.S |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/Kconfig   |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/Makefile  |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/core.h    |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/headsmp.S |  0
 .../arm/{mach-socfpga => platforms/socfpga}/l2_cache.c |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/ocram.c   |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/platsmp.c |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/pm.c      |  0
 .../{mach-socfpga => platforms/socfpga}/self-refresh.S |  0
 arch/arm/{mach-socfpga => platforms/socfpga}/socfpga.c |  0
 arch/arm/{mach-sunxi => platforms/sunxi}/Kconfig       |  0
 arch/arm/{mach-sunxi => platforms/sunxi}/Makefile      |  0
 arch/arm/{mach-sunxi => platforms/sunxi}/platsmp.c     |  0
 arch/arm/{mach-sunxi => platforms/sunxi}/sunxi.c       |  0
 arch/arm/{mach-uniphier => platforms/uniphier}/Kconfig |  0
 .../arm/{mach-uniphier => platforms/uniphier}/Makefile |  0
 .../{mach-uniphier => platforms/uniphier}/headsmp.S    |  0
 .../{mach-uniphier => platforms/uniphier}/platsmp.c    |  0
 .../{mach-uniphier => platforms/uniphier}/uniphier.c   |  0
 arch/arm/{mach-zynq => platforms/zynq}/Kconfig         |  0
 arch/arm/{mach-zynq => platforms/zynq}/Makefile        |  0
 arch/arm/{mach-zynq => platforms/zynq}/common.c        |  0
 arch/arm/{mach-zynq => platforms/zynq}/common.h        |  0
 arch/arm/{mach-zynq => platforms/zynq}/headsmp.S       |  0
 arch/arm/{mach-zynq => platforms/zynq}/platsmp.c       |  0
 arch/arm/{mach-zynq => platforms/zynq}/pm.c            |  0
 arch/arm/{mach-zynq => platforms/zynq}/slcr.c          |  0
 71 files changed, 23 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/platforms/Kconfig
 create mode 100644 arch/arm/platforms/Makefile
 rename arch/arm/{mach-bcm => platforms/bcm}/Kconfig (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/Makefile (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_pmb.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.h (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_5301x.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_cygnus.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.h (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_nsp.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/board_bcm21664.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/board_bcm281xx.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/board_bcm2835.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/brcmstb.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.h (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/platsmp-brcmstb.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/platsmp.c (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/Kconfig (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/Makefile (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/core.h (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/highbank.c (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/pm.c (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/smc.S (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/sysregs.h (100%)
 rename arch/arm/{mach-highbank => platforms/highbank}/system.c (100%)
 rename arch/arm/{mach-mediatek => platforms/mediatek}/Kconfig (100%)
 rename arch/arm/{mach-mediatek => platforms/mediatek}/Makefile (100%)
 rename arch/arm/{mach-mediatek => platforms/mediatek}/mediatek.c (100%)
 rename arch/arm/{mach-mediatek => platforms/mediatek}/platsmp.c (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/Kconfig (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/Makefile (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/core.h (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/headsmp.S (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/platsmp.c (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/pm.c (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/pm.h (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/rockchip.c (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/sleep.S (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/Kconfig (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/Makefile (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/core.h (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/headsmp.S (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/l2_cache.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/ocram.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/platsmp.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/pm.c (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/self-refresh.S (100%)
 rename arch/arm/{mach-socfpga => platforms/socfpga}/socfpga.c (100%)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/Kconfig (100%)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/Makefile (100%)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/platsmp.c (100%)
 rename arch/arm/{mach-sunxi => platforms/sunxi}/sunxi.c (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/Kconfig (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/Makefile (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/headsmp.S (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/platsmp.c (100%)
 rename arch/arm/{mach-uniphier => platforms/uniphier}/uniphier.c (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/Kconfig (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/Makefile (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/common.c (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/common.h (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/headsmp.S (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/platsmp.c (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/pm.c (100%)
 rename arch/arm/{mach-zynq => platforms/zynq}/slcr.c (100%)

-- 
1.9.1
