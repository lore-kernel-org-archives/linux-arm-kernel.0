From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:04:56 +0900
Subject: [GIT PULL] Renesas ARM and SH based SoC pinmux update for v3.10
Message-ID: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 47f4e0c1c87f34bf1fc74b8935a37d229a147946:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl into pinmux-base (2013-03-15 07:16:28 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux-for-v3.10

for you to fetch changes up to a4339a9cb46644e19278e4dd5d89b262a37cb0b0:

  ARM: shmobile: r8a7779: Remove INTC function GPIOs (2013-03-15 13:34:19 +0100)

----------------------------------------------------------------
Renesas ARM and SH based SoC pinmux update for v3.10

As with changes to the Renesas ARM and SH based SoC pinmux code for v3.9
it has been agreed by the relevant parties, Linus Walleij, Laurent Pinchart,
Paul Mundt and myself, that it would be best to take these changes through
the renesas tree and in turn the arm-soc tree.

This pull is based on a merge of the following in order to provide
the required dependencies. This base has been discussed and agreed upon by
Linus Walleij, Laurent Pinchart and myself.

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl devel
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl fixes
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas fixes

----------------------------------------------------------------
Guennadi Liakhovetski (5):
      sh-pfc: Fix a typo and simplify a definition on sh73a0
      ARM: shmobile: sh73a0: Support sparse GPIO numbers
      sh-pfc: sh7372: Add SDHCI and MMCIF pin groups and functions
      sh-pfc: sh73a0: Add SDHI and MMCIF pin groups and functions
      sh-pfc: r8a7740: Add SDHI and MMCIF pin groups and functions

Laurent Pinchart (136):
      sh-pfc: Declare operation structures as const
      sh-pfc: Don't define the per-device pinctrl struct instances as global
      sh-pfc: Drop the sh_pfc_pinctrl spinlock
      sh-pfc: Don't take the sh_pfc spinlock in sh_pfc_map_gpios()
      sh-pfc: Use GPIO_FN instead of PINMUX_GPIO where possible
      sh-pfc: Replace first_gpio and last_gpio with nr_gpios
      sh-pfc: Replace SoC info data and mark ranges with a number of pins
      sh-pfc: Remove unused sh_pfc_soc_info reserved_id field
      sh-pfc: Initialize pinmux_gpio flags statically
      sh-pfc: Make struct pinmux_gpio enum_id field const
      sh-pfc: Shrink the pinctrl GPIO range to include real GPIOs only
      sh-pfc: Don't needlessly check GPIO type in sh_gpio_free()
      sh-pfc: Split pins and functions definition tables
      sh-pfc: Split pins and functions into separate gpio_chip instances
      sh-pfc: Rename struct pinmux_pin to struct sh_pfc_pin
      sh-pfc: Look up IRQ table entries by GPIO number
      sh-pfc: Share the PORT_10_REV, PORT_32 and PORT_32_REV definitions
      sh-pfc: Use pinmux identifiers in the pin muxing API
      sh-pfc: Simplify the sh_pfc_gpio_is_pin() logic
      sh-pfc: Add function to retrieve a pin instance from its pin number
      sh-pfc: Replace pinctrl_add_gpio_range() with gpiochip_add_pin_range()
      sh-pfc: Add support for sparse pin numbers
      ARM: shmobile: ap4-evb: Replace GPIO_PORTx enum with GPIO port numbers
      ARM: shmobile: armadillo: Replace GPIO_PORTx enum with GPIO port numbers
      ARM: shmobile: bonito: Replace GPIO_PORTx enum with GPIO port numbers
      ARM: shmobile: mackerel: Replace GPIO_PORTx enum with GPIO port numbers
      sh-pfc: Expose real groups and functions in pinctrl/pinmux operations
      sh: sh7203: Add pin control resources
      sh: sh7264: Add pin control resources
      sh: sh7269: Add pin control resources
      sh: sh7720: Add pin control resources
      sh: sh7722: Add pin control resources
      sh: sh7723: Add pin control resources
      sh: sh7724: Add pin control resources
      sh: sh7757: Add pin control resources
      sh: sh7785: Add pin control resources
      sh: sh7786: Add pin control resources
      sh: shx3: Add pin control resources
      sh-pfc: Move GPIO registers access functions to gpio.c
      sh-pfc: Don't map data registers individually
      sh-pfc: Drop unused support for 1:1 physical to virtual memory mappings
      sh-pfc: Don't modify pinmux_data_reg SoC data
      sh-pfc: Don't modify sh_pfc_pin SoC data
      sh-pfc: Remove configuration dry-run and free
      sh-pfc: Constify all SoC data
      sh-pfc: Use proper error codes
      sh-pfc: Implement generic pinconf support
      sh-pfc: Merge sh_pfc_reconfig_pin() into sh_pfc_gpio_set_direction()
      sh-pfc: Clean up pin configuration type handling
      sh-pfc: Convert message printing from pr_* to dev_*
      sh-pfc: Return an error if a pin doesn't support the requested direction
      sh-pfc: sh73a0: Add bias (pull-up/down) pinconf support
      sh-pfc: sh73a0: Add LCD and LCD2 pin groups and functions
      sh-pfc: sh73a0: Add SCIFA and SCIFB pin groups and functions
      sh-pfc: sh73a0: Add I2C2 and I2C3 pin groups and functions
      sh-pfc: sh73a0: Add FSI pin groups and functions
      sh-pfc: sh73a0: Add KEYSC pin groups and functions
      sh-pfc: sh73a0: Add BSC pin groups and functions
      sh-pfc: sh73a0: Add USB pin groups and functions
      sh-pfc: sh73a0: Add IrDA pin groups and functions
      sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and functions
      sh-pfc: r8a7779: Add DU pin groups and functions
      sh-pfc: r8a7779: Add SDHI and MMCIF pin groups and functions
      sh-pfc: r8a7779: Add SCIF pin groups and functions
      sh-pfc: r8a7779: Add HSPI pin groups and functions
      sh-pfc: r8a7779: Add USB0 and USB1 PENC pinmux support
      sh-pfc: r8a7779: Add USB pin groups and functions
      sh-pfc: r8a7779: Add LBSC pin groups and functions
      sh-pfc: r8a7779: Add INTC pin groups and functions
      ARM: shmobile: ag5evm: Register pinctrl mappings for SCIF
      ARM: shmobile: ag5evm: Register pinctrl mappings for I2C
      ARM: shmobile: ag5evm: Register pinctrl mappings for FSI
      ARM: shmobile: ag5evm: Register pinctrl mappings for SDHI and MMCIF
      ARM: shmobile: ag5evm: Register pinctrl mappings for KEYSC
      ARM: shmobile: ag5evm: Register pinctrl mappings for IrDA
      ARM: shmobile: ap4evb: Register pinctrl mappings for SDHI and MMCIF
      ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0
      ARM: shmobile: armadillo800eva: Register pinctrl mappings for SDHI and MMCIF
      ARM: shmobile: bonito: Register pinctrl mappings for LCDC0
      ARM: shmobile: kota2: Register pinctrl mappings for SCIF
      ARM: shmobile: kota2: Register pinctrl mappings for SDHI and MMCIF
      ARM: shmobile: kota2: Register pinctrl mappings for KEYSC
      ARM: shmobile: kota2: Register pinctrl mappings for BSC
      ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
      ARM: shmobile: kzm9g: Register pinctrl mappings for SCIF
      ARM: shmobile: kzm9g: Register pinctrl mappings for I2C
      ARM: shmobile: kzm9g: Register pinctrl mappings for FSI
      ARM: shmobile: kzm9g: Register pinctrl mappings for SDHI and MMCIF
      ARM: shmobile: kzm9g: Register pinctrl mappings for BSC
      ARM: shmobile: kzm9g: Register pinctrl mappings for USB
      ARM: shmobile: mackerel: Register pinctrl mappings for SDHI and MMCIF
      ARM: shmobile: marzen: Register pinctrl mappings for SDHI and MMCIF
      ARM: shmobile: marzen: Register pinctrl mappings for SCIF
      ARM: shmobile: marzen: Register pinctrl mappings for HSPI
      ARM: shmobile: marzen: Register pinctrl mappings for USB
      ARM: shmobile: marzen: Register pinctrl mappings for LBSC
      ARM: shmobile: marzen: Register pinctrl mappings for INTC
      sh-pfc: sh7372: Remove SDHI and MMCIF function GPIOS
      sh-pfc: sh73a0: Remove LCD and LCD2 function GPIOS
      sh-pfc: sh73a0: Remove SCIFA and SCIFB function GPIOS
      sh-pfc: sh73a0: Remove I2C function GPIOS
      sh-pfc: sh73a0: Remove FSI function GPIOS
      sh-pfc: sh73a0: Remove pull-up function GPIOS
      sh-pfc: sh73a0: Remove KEYSC function GPIOS
      sh-pfc: sh73a0: Remove BSC function GPIOS
      sh-pfc: sh73a0: Remove USB function GPIOS
      sh-pfc: sh73a0: Remove IrDA function GPIOS
      sh-pfc: r8a7740: Remove LCD0 and LCD1 function GPIOS
      sh-pfc: r8a7740: Remove SDHI and MMCIF function GPIOS
      sh-pfc: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
      sh-pfc: r8a7779: Remove SDHI and MMCIF function GPIOS
      sh-pfc: r8a7779: Remove SCIF function GPIOS
      sh-pfc: r8a7779: Remove HSPI function GPIOS
      sh-pfc: r8a7779: Remove USB function GPIOS
      sh-pfc: r8a7779: Remove LBSC function GPIOS
      sh-pfc: r8a7779: Remove INTC function GPIOS
      ARM: shmobile: sh7372: Remove SDHI and MMCIF function GPIOs
      ARM: shmobile: sh73a0: Remove LCDC and LCDC2 function GPIOs
      ARM: shmobile: sh73a0: Remove SCIFA and SCIFB function GPIOs
      ARM: shmobile: sh73a0: Remove I2C function GPIOs
      ARM: shmobile: sh73a0: Remove FSI function GPIOs
      ARM: shmobile: sh73a0: Remove pull-up function GPIOS
      ARM: shmobile: sh73a0: Remove KEYSC function GPIOs
      ARM: shmobile: sh73a0: Remove BSC function GPIOs
      ARM: shmobile: sh73a0: Remove USB function GPIOs
      ARM: shmobile: sh73a0: Remove IrDA function GPIOs
      ARM: shmobile: r8a7740: Remove LCD0 and LCD1 function GPIOs
      ARM: shmobile: r8a7740: Remove SDHI and MMCIF function GPIOs
      ARM: shmobile: r8a7779: Remove DU1_DOTCLKOUT1 GPIO
      ARM: shmobile: r8a7779: Remove DU function GPIOs
      ARM: shmobile: r8a7779: Remove SDHI and MMCIF function GPIOs
      ARM: shmobile: r8a7779: Remove SCIF function GPIOs
      ARM: shmobile: r8a7779: Remove HSPI function GPIOs
      ARM: shmobile: r8a7779: Remove USB function GPIOs
      ARM: shmobile: r8a7779: Remove LBSC function GPIOs
      ARM: shmobile: r8a7779: Remove INTC function GPIOs

Wei Yongjun (1):
      sh-pfc: Fix return value check in sh_pfc_register_pinctrl()

 arch/arm/mach-shmobile/board-ag5evm.c          |  172 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |   91 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |  160 +-
 arch/arm/mach-shmobile/board-bonito.c          |   52 +-
 arch/arm/mach-shmobile/board-kota2.c           |  208 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |  152 +-
 arch/arm/mach-shmobile/board-mackerel.c        |  102 +-
 arch/arm/mach-shmobile/board-marzen.c          |   75 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |   74 -
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |  324 ++-
 arch/arm/mach-shmobile/include/mach/sh7372.h   |   29 -
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |  363 ++--
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c        |   13 +-
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c        |   13 +-
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c        |   11 +-
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c         |   14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c        |   14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c        |   14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c        |   13 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c        |   13 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c        |   14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c        |   14 +-
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c          |   17 +-
 drivers/pinctrl/sh-pfc/Kconfig                 |    1 +
 drivers/pinctrl/sh-pfc/core.c                  |  261 +--
 drivers/pinctrl/sh-pfc/core.h                  |   54 +-
 drivers/pinctrl/sh-pfc/gpio.c                  |  363 +++-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |  694 +++++--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           | 1648 +++++++++++++--
 drivers/pinctrl/sh-pfc/pfc-sh7203.c            |  488 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7264.c            |  460 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7269.c            |  624 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c            |  323 ++-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            | 2656 +++++++++++++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7720.c            |  333 +--
 drivers/pinctrl/sh-pfc/pfc-sh7722.c            |  480 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7723.c            |  642 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7724.c            |  638 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c            |   55 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c            |  620 +++---
 drivers/pinctrl/sh-pfc/pfc-sh7785.c            |  354 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7786.c            |  296 +--
 drivers/pinctrl/sh-pfc/pfc-shx3.c              |  148 +-
 drivers/pinctrl/sh-pfc/pinctrl.c               |  484 ++---
 drivers/pinctrl/sh-pfc/sh_pfc.h                |  135 +-
 45 files changed, 8368 insertions(+), 5341 deletions(-)
