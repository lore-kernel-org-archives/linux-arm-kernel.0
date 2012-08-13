From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:57:31 +0200
Subject: [PATCH 0/7] U300 cleanup patch series
Message-ID: <1344859051-29259-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This patch series clean up the U300 platform by:
- Deleting ancient platforms, including portions of
  the pinctrl driver
- Consolidating the platform and get rid of excess
  headers in <mach/*>
- Convert to sparse IRQs like everyone else (so we can
  do stuff like Device Tree and single zImage, if we want).

Linus Walleij (7):
  ARM: u300: retire ancient platforms
  pinctrl/coh901: retire ancient GPIO block versions
  pinctrl/coh901: move header to platform data dir
  ARM: u300: merge u300.c into core.c and rid headers
  ARM: u300: delete remnant clkdev.h file
  ARM: u300: move DMA channel header into mach-u300
  ARM: u300: convert to sparse IRQs

 arch/arm/Kconfig                               |   1 +
 arch/arm/mach-u300/Kconfig                     |  43 +----
 arch/arm/mach-u300/Makefile                    |   1 -
 arch/arm/mach-u300/core.c                      | 100 +++--------
 arch/arm/mach-u300/dma_channels.h              |  60 +++++++
 arch/arm/mach-u300/i2c.c                       |   6 +-
 arch/arm/mach-u300/include/mach/clkdev.h       |   7 -
 arch/arm/mach-u300/include/mach/dma_channels.h |  69 --------
 arch/arm/mach-u300/include/mach/gpio-u300.h    |  37 -----
 arch/arm/mach-u300/include/mach/irqs.h         |  36 +---
 arch/arm/mach-u300/include/mach/platform.h     |  20 ---
 arch/arm/mach-u300/include/mach/syscon.h       |  32 +---
 arch/arm/mach-u300/include/mach/u300-regs.h    |  19 +--
 arch/arm/mach-u300/spi.c                       |   2 +-
 arch/arm/mach-u300/timer.c                     |   5 +-
 arch/arm/mach-u300/timer.h                     |   1 +
 arch/arm/mach-u300/u300-gpio.h                 |  46 +-----
 arch/arm/mach-u300/u300.c                      |  57 -------
 drivers/pinctrl/pinctrl-coh901.c               | 220 +++++--------------------
 include/linux/platform_data/pinctrl-coh901.h   |  26 +++
 20 files changed, 171 insertions(+), 617 deletions(-)
 create mode 100644 arch/arm/mach-u300/dma_channels.h
 delete mode 100644 arch/arm/mach-u300/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-u300/include/mach/dma_channels.h
 delete mode 100644 arch/arm/mach-u300/include/mach/gpio-u300.h
 delete mode 100644 arch/arm/mach-u300/include/mach/platform.h
 create mode 100644 arch/arm/mach-u300/timer.h
 delete mode 100644 arch/arm/mach-u300/u300.c
 create mode 100644 include/linux/platform_data/pinctrl-coh901.h

-- 
1.7.11.3
