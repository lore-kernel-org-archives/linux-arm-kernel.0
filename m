From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:24:51 +0900
Subject: [GIT PULL 000/130] Renesas ARM based SoC pinmux and GPIO update for
Message-ID: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please note that this pull-request is based on renesas-fixes-for-v3.10
in order to avoid a messy conflict.

The following changes since commit 5600a8485603b240790005b9b58de4c4f6ada69d:

  ARM: shmobile: sh73a0: Update CMT clockevent rating to 80 (2013-06-04 14:37:53 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux-for-v3.11

for you to fetch changes up to 5fcf4a3c3a5bc08bf72a50ef1332501a3c1b96bb:

  ARM: shmobile: marzen: Use RCAR_GP_PIN macro (2013-06-05 17:18:24 +0900)

----------------------------------------------------------------
Renesas ARM based SoC pinmux and GPIO update for v3.11

SH-PFC:
* Entries for INTC external IRQs
* Remove dependency on GPIOLIB
* PFC support for r8a7790 SoC
* Pinmux support for r8a7778 SoC
* Increase pin group and function coverage for sh7372, r8a7740,
  r8a7778, r8a7779 and r8a7790 SoCs
* Use pinctrl mapping on mackerel, ap4evb, armadillo800eva,
  bonito, bockw, lager boards
* Use RCAR_GP_PIN macro in marzen board
* Remove unused GPIOs for sh7372, sh73a0, r8a7740 and r8a7790 SoCs
* Add bias (pull-up/down) pinconf support for r8a7740 SoC
* Add VCCQ support for sh73a0

GPIO car:
* Add RCAR_GP_PIN macro
* Add support for IRQ_TYPE_EDGE_BOTH
* Make the platform data gpio_base field signed

The GPIO changes have been included as the RCAR_GP_PIN and
IRQ_TYPE_EDGE_BOTH changes are depended on by SH-PFC changes.

----------------------------------------------------------------
Bastian Hecht (3):
      sh-pfc: Add entries for INTC external IRQs
      sh-pfc: r8a7740: Add SCIFA1 data group
      ARM: shmobile: armadillo800eva: Convert SCIFA1 to pinctrl

Guennadi Liakhovetski (3):
      pinctrl: sh-pfc: fix r8a7790 Function Select register tables
      pinctrl: sh-pfc: fix a typo in pfc-r8a7790
      pinctrl: r8a7790: add pinmux data for MMCIF and SDHI interfaces

Koji Matsuoka (1):
      sh-pfc: Initial r8a7790 PFC support

Kuninori Morimoto (15):
      gpio-rcar: R-Car GPIO IRQ share interrupt
      ARM: shmobile: add GPIO IRQ macro
      ARM: shmobile: r8a7778: Register PFC device
      sh-pfc: Add r8a7778 pinmux support
      sh-pfc: r8a7779: use RCAR_GP_PIN() on _GP_GPIO() macro
      sh-pfc: r8a7778: add common PFC macro helper
      sh-pfc: r8a7778: add SDHI support
      sh-pfc: r8a7778: tidyup SDHI naming suffixes and sort it alphabetically
      ARM: shmobile: r8a7778: add GPIO support
      sh-pfc: r8a7778: fixup IRQ1A settings
      sh-pfc: r8a7778: add I2C pin groups
      sh-pfc: r8a7778: add HSPI pin groups
      sh-pfc: r8a7778: add MMCIF pin groups
      ARM: shmobile: kzm9g: tidyup FSI pinctrl
      ARM: shmobile: bockw: add pinctrl support

Laurent Pinchart (98):
      gpio-rcar: Make the platform data gpio_base field signed
      gpio-rcar: Add RCAR_GP_PIN macro
      sh-pfc: Remove dependency on GPIOLIB
      sh-pfc: r8a7790: Add ETH pin groups and functions
      sh-pfc: r8a7790: Add INTC pin groups and functions
      sh-pfc: r8a7790: Add SCIF, SCIFA and SCIFB pin groups and functions
      sh-pfc: r8a7790: Remove GPIO data
      sh-pfc: r8a7790: Remove function GPIOs
      sh-pfc: r8a7790: Don't use GPIO enum entries
      sh-pfc: r8a7779: Replace hardcoded pin numbers with RCAR_GP_PIN macro
      sh-pfc: sh7372: Add BSC pin groups and functions
      sh-pfc: sh7372: Add CEU pin groups and functions
      sh-pfc: sh7372: Add FLCTL pin groups and functions
      sh-pfc: sh7372: Add FSI pin groups and functions
      sh-pfc: sh7372: Add HDMI pin groups and functions
      sh-pfc: sh7372: Add INTC pin groups and functions
      sh-pfc: sh7372: Add KEYSC pin groups and functions
      sh-pfc: sh7372: Add LCDC pin groups and functions
      sh-pfc: sh7372: Add SCIF pin groups and functions
      sh-pfc: sh7372: Add USB pin groups and functions
      ARM: shmobile: mackerel: Register pinctrl mapping for the ADXL34X
      ARM: shmobile: mackerel: Register pinctrl mapping for CEU
      ARM: shmobile: mackerel: Register pinctrl mapping for FLCTL
      ARM: shmobile: mackerel: Register pinctrl mapping for FSI
      ARM: shmobile: mackerel: Register pinctrl mapping for HDMI
      ARM: shmobile: mackerel: Register pinctrl mapping for LCD
      ARM: shmobile: mackerel: Register pinctrl mapping for SCIF
      ARM: shmobile: mackerel: Register IRQ pinctrl mapping for SDHI0
      ARM: shmobile: mackerel: Register pinctrl mapping for SMSC911x
      ARM: shmobile: mackerel: Register pinctrl mapping for ST1232
      ARM: shmobile: mackerel: Register pinctrl mapping for TCA6416
      ARM: shmobile: mackerel: Register pinctrl mapping for USBHS
      ARM: shmobile: ap4evb: Register pinctrl mapping for CEU
      ARM: shmobile: ap4evb: Register pinctrl mapping for FSI
      ARM: shmobile: ap4evb: Register pinctrl mapping for HDMI
      ARM: shmobile: ap4evb: Register pinctrl mapping for KEYSC
      ARM: shmobile: ap4evb: Register pinctrl mapping for LCD
      ARM: shmobile: ap4evb: Register pinctrl mapping for SCIF
      ARM: shmobile: ap4evb: Register pinctrl mapping for SMSC911x
      ARM: shmobile: ap4evb: Simplify tsc2007 pen state read function
      ARM: shmobile: ap4evb: Register pinctrl mapping for TSC2007
      ARM: shmobile: ap4evb: Register pinctrl mapping for USBHS
      sh-pfc: sh7372: Replace GPIO_PORTx enum with GPIO port numbers
      sh-pfc: sh7372: Remove function GPIOs
      ARM: shmobile: sh7372: Remove all GPIOs
      sh-pfc: sh7372: Add bias (pull-up/down) pinconf support
      sh-pfc: r8a7740: Add SCIF pin groups and functions
      sh-pfc: r8a7740: Declare missing INTC function
      sh-pfc: r8a7740: Add BSC pin groups and functions
      sh-pfc: r8a7740: Add GETHER pin groups and functions
      sh-pfc: r8a7740: Add CEU pin groups and functions
      sh-pfc: r8a7740: Add FSI pin groups and functions
      sh-pfc: r8a7740: Add HDMI pin groups and functions
      sh-pfc: r8a7740: Hardcode the LCDC0 output
      ARM: shmobile: armadillo800eva: Register pinctrl mapping for INTC
      ARM: shmobile: armadillo800eva: Register pinctrl mapping for GETHER
      ARM: shmobile: armadillo800eva: Register pinctrl mapping for CEU0
      ARM: shmobile: armadillo800eva: Register pinctrl mapping for FSI
      ARM: shmobile: armadillo800eva: Register pinctrl mapping for HDMI
      ARM: shmobile: armadillo800eva: Don't configure LCDC routing manually
      ARM: shmobile: armadillo800eva: Replace GPIO_PORTx with GPIO port numbers
      ARM: shmobile: bonito: Remove empty core devices array
      ARM: shmobile: bonito: Register pinctrl mapping for SCIF
      ARM: shmobile: bonito: Register pinctrl mapping for INTC
      ARM: shmobile: bonito: Register pinctrl mapping for BSC
      ARM: shmobile: bonito: Don't configure LCDC routing manually
      sh-pfc: r8a7740: Remove SCIF function GPIOS
      sh-pfc: r8a7740: Remove INTC function GPIOS
      sh-pfc: r8a7740: Remove BSC function GPIOS
      sh-pfc: r8a7740: Remove GETHER function GPIOS
      sh-pfc: r8a7740: Remove CEU function GPIOS
      sh-pfc: r8a7740: Remove FSI function GPIOS
      sh-pfc: r8a7740: Remove HDMI function GPIOS
      ARM: shmobile: r8a7740: Remove SCIF function GPIOs
      ARM: shmobile: r8a7740: Remove INTC function GPIOs
      ARM: shmobile: r8a7740: Remove BSC function GPIOs
      ARM: shmobile: r8a7740: Remove GETHER function GPIOs
      ARM: shmobile: r8a7740: Remove CEU function GPIOs
      ARM: shmobile: r8a7740: Remove FSI function GPIOs
      ARM: shmobile: r8a7740: Remove HDMI function GPIOs
      sh-pfc: r8a7740: Remove function GPIOs
      sh-pfc: r8a7740: Replace GPIO_PORTx enum with GPIO port numbers
      ARM: shmobile: r8a7740: Remove all GPIOs
      sh-pfc: r8a7740: Add bias (pull-up/down) pinconf support
      sh-pfc: r8a7778: Fix outdated GPIO_FN comments
      ARM: shmobile: r8a7790: Register GPIO devices
      ARM: shmobile: r8a7790: Remove all GPIOs
      sh-pfc: Add support for SoC-specific initialization
      sh-pfc: sh73a0: Add VCCQ MC0 regulator
      ARM: shmobile: kzm9g: Remove the VCCQ MC0 function GPIO
      ARM: shmobile: kzm9g-reference: Remove the VCCQ MC0 function GPIO
      sh-pfc: sh73a0: Add TPU pin groups and functions
      sh-pfc: r8a7740: Add TPU pin groups and functions
      sh-pfc: r8a7790: Add TPU pin groups and functions
      sh-pfc: sh73a0: Remove function GPIOs
      Revert "ARM: shmobile: Disallow PINCTRL without GPIOLIB"
      ARM: shmobile: lager: Initialize pinmux
      ARM: shmobile: marzen: Use RCAR_GP_PIN macro

Magnus Damm (2):
      ARM: shmobile: r8a7779 pinmux platform device cleanup
      ARM: shmobile: r8a7740 pinmux platform device cleanup

Phil Edworthy (1):
      pinctrl: sh-pfc: r8a7779: Fix missing MOD_SEL2 entry

Sergei Shtylyov (3):
      sh-pfc: r8a7778: add USB pin groups
      sh-pfc: r8a7778: add Ether pin groups
      sh-pfc: r8a7779: add Ether pin groups

Simon Horman (2):
      gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH
      ARM: shmobile: r8a7790: Configure R-Car GPIO for IRQ_TYPE_EDGE_BOTH

Vladimir Barinov (2):
      sh-pfc: r8a7779: add VIN pin groups
      sh-pfc: r8a7778: add VIN pin groups

 arch/arm/Kconfig                               |    2 +-
 arch/arm/mach-shmobile/Kconfig                 |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c          |  132 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |  116 +-
 arch/arm/mach-shmobile/board-bockw.c           |   13 +
 arch/arm/mach-shmobile/board-bonito.c          |   47 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 -
 arch/arm/mach-shmobile/board-kzm9g.c           |   11 +-
 arch/arm/mach-shmobile/board-lager.c           |   15 +
 arch/arm/mach-shmobile/board-mackerel.c        |  171 +-
 arch/arm/mach-shmobile/board-marzen.c          |    7 +-
 arch/arm/mach-shmobile/include/mach/irqs.h     |    5 +
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |  488 ---
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |    1 +
 arch/arm/mach-shmobile/include/mach/sh7372.h   |  391 ---
 arch/arm/mach-shmobile/setup-r8a7740.c         |   24 +-
 arch/arm/mach-shmobile/setup-r8a7778.c         |   47 +
 arch/arm/mach-shmobile/setup-r8a7779.c         |   17 +-
 arch/arm/mach-shmobile/setup-r8a7790.c         |   36 +-
 drivers/gpio/gpio-rcar.c                       |   28 +-
 drivers/pinctrl/sh-pfc/Kconfig                 |   13 +-
 drivers/pinctrl/sh-pfc/Makefile                |    2 +
 drivers/pinctrl/sh-pfc/core.c                  |   22 +-
 drivers/pinctrl/sh-pfc/core.h                  |    4 +
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           | 1923 ++++++++----
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c           | 2783 +++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c           |  493 ++-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c           | 3835 ++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7372.c            | 1652 +++++++---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            |  742 +++--
 drivers/pinctrl/sh-pfc/sh_pfc.h                |    4 +-
 include/linux/platform_data/gpio-rcar.h        |    5 +-
 32 files changed, 10304 insertions(+), 2727 deletions(-)
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7778.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7790.c

-- 
1.8.2.1
