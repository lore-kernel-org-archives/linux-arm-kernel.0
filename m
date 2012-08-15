From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Aug 2012 10:10:54 +0200
Subject: [GIT PULL] U300 cleanups and sparseirq
Message-ID: <CACRpkdb6wB1QVNqn8_sHB8LH0To=aP_8+iocE8JZ2jKC5f_bYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

could you please pull the following patch set sent out for review the other day
doing a number of cleanups and a minor improvement to U300, paving the
way for single zImage and device tree:

- Deprecate ancient platforms to make the following patches easier to
  make...
- Move out one header to platform data and one to the mach-u300 proper
  to depopulate <mach/*>
- Consolidate core machine files
- Convert to sparse IRQs

Please pull! Thanks.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
u300-cleanup

for you to fetch changes up to a4fe292fa75baaa9cfb1a7224614f31fcd0d9a7b:

  ARM: u300: convert to sparse IRQs (2012-08-13 13:53:07 +0200)

----------------------------------------------------------------
Linus Walleij (7):
      ARM: u300: retire ancient platforms
      pinctrl/coh901: retire ancient GPIO block versions
      pinctrl/coh901: move header to platform data dir
      ARM: u300: merge u300.c into core.c and rid headers
      ARM: u300: delete remnant clkdev.h file
      ARM: u300: move DMA channel header into mach-u300
      ARM: u300: convert to sparse IRQs

 arch/arm/Kconfig                                   |   1 +
 arch/arm/mach-u300/Kconfig                         |  43 +---
 arch/arm/mach-u300/Makefile                        |   1 -
 arch/arm/mach-u300/core.c                          | 100 +++-------
 .../mach-u300/{include/mach => }/dma_channels.h    |  11 +-
 arch/arm/mach-u300/i2c.c                           |   6 +-
 arch/arm/mach-u300/include/mach/clkdev.h           |   7 -
 arch/arm/mach-u300/include/mach/irqs.h             |  36 +---
 arch/arm/mach-u300/include/mach/platform.h         |  20 --
 arch/arm/mach-u300/include/mach/syscon.h           |  32 +--
 arch/arm/mach-u300/include/mach/u300-regs.h        |  19 +-
 arch/arm/mach-u300/spi.c                           |   2 +-
 arch/arm/mach-u300/timer.c                         |   5 +-
 arch/arm/mach-u300/timer.h                         |   1 +
 arch/arm/mach-u300/u300-gpio.h                     |  46 +----
 arch/arm/mach-u300/u300.c                          |  57 ------
 drivers/pinctrl/pinctrl-coh901.c                   | 220 ++++-----------------
 .../linux/platform_data/pinctrl-coh901.h           |  13 +-
 18 files changed, 87 insertions(+), 533 deletions(-)
 rename arch/arm/mach-u300/{include/mach => }/dma_channels.h (88%)
 delete mode 100644 arch/arm/mach-u300/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-u300/include/mach/platform.h
 create mode 100644 arch/arm/mach-u300/timer.h
 delete mode 100644 arch/arm/mach-u300/u300.c
 rename arch/arm/mach-u300/include/mach/gpio-u300.h =>
include/linux/platform_data/pinctrl-coh901.h (72%)

Yours,
Linus Walleij
