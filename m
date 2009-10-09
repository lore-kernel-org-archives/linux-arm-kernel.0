From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Fri, 9 Oct 2009 14:06:01 -0700
Subject: [PATCH 0/8] bcmring: add gpio support
Message-ID: <20091009210601.GA24641@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set is to add gpio/gpiomux support for bcmring machine.
Your comments are welcome.

The summary of this patch set.

[PATCH 1/8] add reg32_clear_bits and reg32_set_bits accessor functions
[PATCH 2/8] add gpio support in Kconfig and Makefile for bcmring
[PATCH 3/8] add gpio_to_irq and irq_to_gpio definitions
[PATCH 4/8] add gpio.c and gpio_irq.c
[PATCH 5/8] add gpio headers in include/mach
[PATCH 6/8] add gpio headers in include/mach/csp directory.
[PATCH 7/8] add gpio csp code and header
[PATCH 8/8] modify bcmring_defconfig with gpio support


 arch/arm/Kconfig                                   |    3 +-
 arch/arm/configs/bcmring_defconfig                 |   29 +-
 arch/arm/mach-bcmring/Makefile                     |    3 +-
 arch/arm/mach-bcmring/csp/Makefile                 |    2 +
 arch/arm/mach-bcmring/csp/gpio/Makefile            |    1 +
 arch/arm/mach-bcmring/csp/gpio/gpioHw_pl061.c      |  192 ++++++
 arch/arm/mach-bcmring/csp/gpiomux/Makefile         |    1 +
 arch/arm/mach-bcmring/csp/gpiomux/gpiomux.c        |  669 ++++++++++++++++++++
 arch/arm/mach-bcmring/gpio.c                       |  291 +++++++++
 arch/arm/mach-bcmring/gpio_irq.c                   |  381 +++++++++++
 arch/arm/mach-bcmring/include/csp/gpioHw.h         |  383 +++++++++++
 arch/arm/mach-bcmring/include/csp/reg.h            |   14 +
 .../mach-bcmring/include/mach/csp/gpioHw_inline.h  |  345 ++++++++++
 .../arm/mach-bcmring/include/mach/csp/gpioHw_reg.h |  381 +++++++++++
 arch/arm/mach-bcmring/include/mach/csp/gpiomux.h   |  221 +++++++
 arch/arm/mach-bcmring/include/mach/gpio.h          |   22 +
 arch/arm/mach-bcmring/include/mach/gpio_defs.h     |  102 +++
 arch/arm/mach-bcmring/include/mach/gpio_irq.h      |   61 ++
 arch/arm/mach-bcmring/include/mach/gpio_types.h    |   52 ++
 arch/arm/mach-bcmring/include/mach/irqs.h          |    3 +
 arch/arm/mach-bcmring/include/mach/reg_gpio.h      |  131 ++++
 21 files changed, 3283 insertions(+), 4 deletions(-)


-- 

Leo Hao Chen

------------------------
Life is short, run long.
