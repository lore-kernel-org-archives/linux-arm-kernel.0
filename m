From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 2 May 2013 18:16:48 +0200
Subject: [PATCH 0/7] ARM: u300 multiplatform support
Message-ID: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This series builds on top of the recently iterated U300
device tree support to convert the platform to multiplatform
(a.k.a. single zImage).

This is intended to be pulled on top of the DT support.

Linus Walleij (7):
  ARM: u300: push down syscon registers
  ARM: u300: remove deps from debug macro
  ARM: u300: delete <mach/hardware.h>
  ARM: u300: delete <mach/irqs.h>
  ARM: u300: localize <mach/u300-regs.h>
  ARM: u300: convert to multiplatform
  ARM: u300: delete remnant machine headers

 arch/arm/Kconfig                                  |  21 +-
 arch/arm/configs/u300_defconfig                   |  11 +-
 arch/arm/include/debug/u300.S                     |   9 +-
 arch/arm/mach-u300/Kconfig                        |  31 +-
 arch/arm/mach-u300/core.c                         |  29 +-
 arch/arm/mach-u300/include/mach/hardware.h        |   5 -
 arch/arm/mach-u300/include/mach/irqs.h            |  80 ---
 arch/arm/mach-u300/include/mach/syscon.h          | 592 ----------------------
 arch/arm/mach-u300/include/mach/timex.h           |  17 -
 arch/arm/mach-u300/include/mach/uncompress.h      |  45 --
 arch/arm/mach-u300/regulator.c                    |   9 +-
 arch/arm/mach-u300/timer.c                        |   3 -
 arch/arm/mach-u300/{include/mach => }/u300-regs.h |   0
 drivers/clk/clk-u300.c                            | 343 ++++++++++++-
 14 files changed, 407 insertions(+), 788 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-u300/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-u300/include/mach/syscon.h
 delete mode 100644 arch/arm/mach-u300/include/mach/timex.h
 delete mode 100644 arch/arm/mach-u300/include/mach/uncompress.h
 rename arch/arm/mach-u300/{include/mach => }/u300-regs.h (100%)

-- 
1.7.11.3
