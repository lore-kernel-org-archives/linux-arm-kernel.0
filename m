From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 31 Aug 2016 10:15:35 +0200
Subject: [GIT PULL] Reset controller changes for v4.9
Message-ID: <1472631335.3085.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag with new UniPhier and STM32 reset
controller drivers and Kconfig options to allow build testing drivers
outside of their architecture.

regards
Philipp

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.9

for you to fetch changes up to cddb4800162e543c202cbb05795a324f1093d168:

  reset: hi6220: allow to compile test driver on other architectures (2016-08-30 17:09:14 +0200)

----------------------------------------------------------------
Reset controller changes for v4.9

- add reset controller driver Kconfig options,
  allow building drivers with COMPILE_TEST
- add reset controller driver for UniPhier SoCs
- add reset controller driver for STM32 MCUs
- simplify SoCFPGA reset controller driver a bit

----------------------------------------------------------------
Gabriel Fernandez (1):
      ARM: dts: stm32f429: add missing #reset-cells of rcc

Masahiro Yamada (1):
      reset: uniphier: add reset controller driver for UniPhier SoCs

Maxime Coquelin (3):
      dt-bindings: mfd: Add STM32F4 RCC numeric constants into DT include file
      dt-bindings: Document the STM32 reset bindings
      drivers: reset: Add STM32 reset driver

Philipp Zabel (13):
      reset: socfpga: no need to store modrst_offset
      reset: warn on invalid input to reset_control_reset/assert/deassert/status
      reset: ath79: add missing include
      reset: ath79: add driver Kconfig option
      reset: berlin: add driver Kconfig option
      reset: lpc18xx: add driver Kconfig option
      reset: meson: add driver Kconfig option
      reset: pistachio: add driver Kconfig option
      reset: socfpga: add driver Kconfig option
      reset: stm32: add driver Kconfig option
      reset: sunxi: add driver Kconfig option
      reset: zynq: add driver Kconfig option
      reset: hi6220: allow to compile test driver on other architectures

 .../devicetree/bindings/clock/st,stm32-rcc.txt     |  42 +-
 .../devicetree/bindings/reset/st,stm32-rcc.txt     |   6 +
 .../devicetree/bindings/reset/uniphier-reset.txt   |  93 +++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   1 +
 drivers/reset/Kconfig                              |  65 +++
 drivers/reset/Makefile                             |  20 +-
 drivers/reset/core.c                               |  12 +-
 drivers/reset/hisilicon/Kconfig                    |   3 +-
 drivers/reset/reset-ath79.c                        |   1 +
 drivers/reset/reset-socfpga.c                      |  19 +-
 drivers/reset/reset-stm32.c                        | 108 +++++
 drivers/reset/reset-uniphier.c                     | 440 +++++++++++++++++++++
 include/dt-bindings/mfd/stm32f4-rcc.h              |  98 +++++
 14 files changed, 881 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
 create mode 100644 Documentation/devicetree/bindings/reset/uniphier-reset.txt
 create mode 100644 drivers/reset/reset-stm32.c
 create mode 100644 drivers/reset/reset-uniphier.c
 create mode 100644 include/dt-bindings/mfd/stm32f4-rcc.h
