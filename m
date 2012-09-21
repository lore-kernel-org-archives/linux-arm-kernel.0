From: csd@broadcom.com (Christian Daudt)
Date: Fri, 21 Sep 2012 14:40:24 -0700
Subject: [PATCH v3 0/2] ARM: Removal of bcmring
Message-ID: <1348263626-3087-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Remove mach-bcmring as this is no longer maintained or used.

Updated the removal with:
 - drop the edit to mach-types requested by Russell King
 - eliminate defconfig mod from patch 1 requested Olof Johansson

Also switched to using git send-email to avoid word-wrapping 
problems


Christian Daudt (2):
  ARM: Remove bcmring NAND driver
  ARM: Remove mach-bcmring

 MAINTAINERS                                        |   16 -
 arch/arm/Kconfig                                   |   14 -
 arch/arm/Makefile                                  |    1 -
 arch/arm/configs/bcmring_defconfig                 |   79 -
 arch/arm/mach-bcmring/Kconfig                      |   19 -
 arch/arm/mach-bcmring/Makefile                     |    8 -
 arch/arm/mach-bcmring/Makefile.boot                |    6 -
 arch/arm/mach-bcmring/arch.c                       |  199 ---
 arch/arm/mach-bcmring/clock.c                      |  223 ---
 arch/arm/mach-bcmring/clock.h                      |   33 -
 arch/arm/mach-bcmring/core.c                       |  228 ---
 arch/arm/mach-bcmring/core.h                       |   31 -
 arch/arm/mach-bcmring/csp/Makefile                 |    3 -
 arch/arm/mach-bcmring/csp/chipc/Makefile           |    1 -
 arch/arm/mach-bcmring/csp/chipc/chipcHw.c          |  776 ---------
 arch/arm/mach-bcmring/csp/chipc/chipcHw_init.c     |  293 ----
 arch/arm/mach-bcmring/csp/chipc/chipcHw_reset.c    |  124 --
 arch/arm/mach-bcmring/csp/chipc/chipcHw_str.c      |   64 -
 arch/arm/mach-bcmring/csp/dmac/Makefile            |    1 -
 arch/arm/mach-bcmring/csp/dmac/dmacHw.c            |  917 -----------
 arch/arm/mach-bcmring/csp/dmac/dmacHw_extra.c      | 1017 ------------
 arch/arm/mach-bcmring/csp/tmr/Makefile             |    1 -
 arch/arm/mach-bcmring/csp/tmr/tmrHw.c              |  576 -------
 arch/arm/mach-bcmring/dma.c                        | 1518 ------------------
 arch/arm/mach-bcmring/dma_device.c                 |  593 -------
 arch/arm/mach-bcmring/include/cfg_global.h         |   13 -
 arch/arm/mach-bcmring/include/cfg_global_defines.h |   40 -
 arch/arm/mach-bcmring/include/csp/cache.h          |   35 -
 arch/arm/mach-bcmring/include/csp/delay.h          |   36 -
 arch/arm/mach-bcmring/include/csp/dmacHw.h         |  596 -------
 arch/arm/mach-bcmring/include/csp/errno.h          |   32 -
 arch/arm/mach-bcmring/include/csp/intcHw.h         |   40 -
 arch/arm/mach-bcmring/include/csp/module.h         |   32 -
 arch/arm/mach-bcmring/include/csp/reg.h            |  114 --
 arch/arm/mach-bcmring/include/csp/secHw.h          |   65 -
 arch/arm/mach-bcmring/include/csp/stdint.h         |   30 -
 arch/arm/mach-bcmring/include/csp/string.h         |   34 -
 arch/arm/mach-bcmring/include/csp/tmrHw.h          |  263 ---
 arch/arm/mach-bcmring/include/mach/csp/cap.h       |   63 -
 .../arm/mach-bcmring/include/mach/csp/cap_inline.h |  409 -----
 .../mach-bcmring/include/mach/csp/chipcHw_def.h    | 1123 -------------
 .../mach-bcmring/include/mach/csp/chipcHw_inline.h | 1673 --------------------
 .../mach-bcmring/include/mach/csp/chipcHw_reg.h    |  530 -------
 arch/arm/mach-bcmring/include/mach/csp/ddrcReg.h   |  872 ----------
 .../mach-bcmring/include/mach/csp/dmacHw_priv.h    |  145 --
 .../arm/mach-bcmring/include/mach/csp/dmacHw_reg.h |  406 -----
 arch/arm/mach-bcmring/include/mach/csp/hw_cfg.h    |   73 -
 .../arm/mach-bcmring/include/mach/csp/intcHw_reg.h |  246 ---
 arch/arm/mach-bcmring/include/mach/csp/mm_addr.h   |  101 --
 arch/arm/mach-bcmring/include/mach/csp/mm_io.h     |  147 --
 arch/arm/mach-bcmring/include/mach/csp/secHw_def.h |  100 --
 .../mach-bcmring/include/mach/csp/secHw_inline.h   |   79 -
 arch/arm/mach-bcmring/include/mach/csp/tmrHw_reg.h |   82 -
 arch/arm/mach-bcmring/include/mach/dma.h           |  630 --------
 arch/arm/mach-bcmring/include/mach/entry-macro.S   |   76 -
 arch/arm/mach-bcmring/include/mach/hardware.h      |   57 -
 arch/arm/mach-bcmring/include/mach/irqs.h          |  132 --
 .../mach-bcmring/include/mach/memory_settings.h    |   67 -
 arch/arm/mach-bcmring/include/mach/reg_nand.h      |   66 -
 arch/arm/mach-bcmring/include/mach/reg_umi.h       |  237 ---
 arch/arm/mach-bcmring/include/mach/timer.h         |   77 -
 arch/arm/mach-bcmring/include/mach/timex.h         |   25 -
 arch/arm/mach-bcmring/include/mach/uncompress.h    |   43 -
 arch/arm/mach-bcmring/irq.c                        |  126 --
 arch/arm/mach-bcmring/mm.c                         |   60 -
 arch/arm/mach-bcmring/timer.c                      |   61 -
 drivers/mtd/nand/Kconfig                           |   16 -
 drivers/mtd/nand/Makefile                          |    1 -
 drivers/mtd/nand/bcm_umi_bch.c                     |  217 ---
 drivers/mtd/nand/bcm_umi_nand.c                    |  555 -------
 drivers/mtd/nand/nand_bcm_umi.c                    |  149 --
 drivers/mtd/nand/nand_bcm_umi.h                    |  337 ----
 72 files changed, 17052 deletions(-)
 delete mode 100644 arch/arm/configs/bcmring_defconfig
 delete mode 100644 arch/arm/mach-bcmring/Kconfig
 delete mode 100644 arch/arm/mach-bcmring/Makefile
 delete mode 100644 arch/arm/mach-bcmring/Makefile.boot
 delete mode 100644 arch/arm/mach-bcmring/arch.c
 delete mode 100644 arch/arm/mach-bcmring/clock.c
 delete mode 100644 arch/arm/mach-bcmring/clock.h
 delete mode 100644 arch/arm/mach-bcmring/core.c
 delete mode 100644 arch/arm/mach-bcmring/core.h
 delete mode 100644 arch/arm/mach-bcmring/csp/Makefile
 delete mode 100644 arch/arm/mach-bcmring/csp/chipc/Makefile
 delete mode 100644 arch/arm/mach-bcmring/csp/chipc/chipcHw.c
 delete mode 100644 arch/arm/mach-bcmring/csp/chipc/chipcHw_init.c
 delete mode 100644 arch/arm/mach-bcmring/csp/chipc/chipcHw_reset.c
 delete mode 100644 arch/arm/mach-bcmring/csp/chipc/chipcHw_str.c
 delete mode 100644 arch/arm/mach-bcmring/csp/dmac/Makefile
 delete mode 100644 arch/arm/mach-bcmring/csp/dmac/dmacHw.c
 delete mode 100644 arch/arm/mach-bcmring/csp/dmac/dmacHw_extra.c
 delete mode 100644 arch/arm/mach-bcmring/csp/tmr/Makefile
 delete mode 100644 arch/arm/mach-bcmring/csp/tmr/tmrHw.c
 delete mode 100644 arch/arm/mach-bcmring/dma.c
 delete mode 100644 arch/arm/mach-bcmring/dma_device.c
 delete mode 100644 arch/arm/mach-bcmring/include/cfg_global.h
 delete mode 100644 arch/arm/mach-bcmring/include/cfg_global_defines.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/cache.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/delay.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/dmacHw.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/errno.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/intcHw.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/module.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/reg.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/secHw.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/stdint.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/string.h
 delete mode 100644 arch/arm/mach-bcmring/include/csp/tmrHw.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/cap.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/cap_inline.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/chipcHw_def.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/chipcHw_inline.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/chipcHw_reg.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/ddrcReg.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/dmacHw_priv.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/dmacHw_reg.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/hw_cfg.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/intcHw_reg.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/mm_addr.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/mm_io.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/secHw_def.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/secHw_inline.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/csp/tmrHw_reg.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/dma.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-bcmring/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/memory_settings.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/reg_nand.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/reg_umi.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/timer.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/timex.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-bcmring/irq.c
 delete mode 100644 arch/arm/mach-bcmring/mm.c
 delete mode 100644 arch/arm/mach-bcmring/timer.c
 delete mode 100644 drivers/mtd/nand/bcm_umi_bch.c
 delete mode 100644 drivers/mtd/nand/bcm_umi_nand.c
 delete mode 100644 drivers/mtd/nand/nand_bcm_umi.c
 delete mode 100644 drivers/mtd/nand/nand_bcm_umi.h

-- 
1.7.9.5
