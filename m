From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Jun 2014 11:06:08 +0200
Subject: [PATCH 0/5] nommu cleanups
Message-ID: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series does several cleanups:
 - drop support for three processor families that are broken since at
   least v3.13;
 - remove the need to specify the size of RAM at compile time. This is
   an ugly thing to do as it makes compiling a multi-machine kernel
   harder; and
 - two fixes that make XIP on !MMU work. While each of them alone would
   be enough to fix booting it's IMHO still worthwile to have both.

I think the right path into mainline for these patches is via Russell's
tree.

Best regards
Uwe

Uwe Kleine-K?nig (5):
  ARM: nommu: drop support for ARM740T, ARM940T and ARM946E-S processors
  ARM: nommu: don't limit TASK_SIZE
  ARM: nommu: simplify definition of MODULES_END
  ARM: nommu: drop unused Kconfig symbol DRAM_SIZE
  ARM: make user_addr_max more robust

 Documentation/devicetree/bindings/arm/cpus.txt |   3 -
 arch/arm/Kconfig                               |   5 +-
 arch/arm/Kconfig-nommu                         |   4 -
 arch/arm/Makefile                              |   3 -
 arch/arm/configs/at91x40_defconfig             |   1 -
 arch/arm/configs/efm32_defconfig               |   1 -
 arch/arm/include/asm/glue-cache.h              |  16 -
 arch/arm/include/asm/glue-proc.h               |  27 --
 arch/arm/include/asm/memory.h                  |  10 +-
 arch/arm/include/asm/uaccess.h                 |   2 +-
 arch/arm/mm/Kconfig                            |  67 +---
 arch/arm/mm/Makefile                           |   3 -
 arch/arm/mm/proc-arm740.S                      | 151 ---------
 arch/arm/mm/proc-arm940.S                      | 374 ---------------------
 arch/arm/mm/proc-arm946.S                      | 429 -------------------------
 15 files changed, 12 insertions(+), 1084 deletions(-)
 delete mode 100644 arch/arm/mm/proc-arm740.S
 delete mode 100644 arch/arm/mm/proc-arm940.S
 delete mode 100644 arch/arm/mm/proc-arm946.S

-- 
2.0.0.rc2
