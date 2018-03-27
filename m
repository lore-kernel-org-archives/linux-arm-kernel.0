From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 27 Mar 2018 18:08:17 +0200
Subject: [GIT PULL] Reset controller changes for v4.17, part 2
Message-ID: <1522166897.3345.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 1d7592f84f92c6344978186fdbe547af044274b5:

  reset: simple: Enable for ASPEED systems (2018-02-20 17:42:29 +0100)

are available in the Git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.17-2

for you to fetch changes up to 0089313d8595b76422b189b44c55556cb1004190:

  Merge branch 'reset/lookup' into reset/next (2018-03-27 11:03:43 +0200)

----------------------------------------------------------------
Reset controller changes for v4.17, part 2

This tag contains reset lookup support, similar to pwm lookups, for legacy
non-DT platforms, a few new reset controls and a Kconfig fix for uniphier
SoCs, as well as a new driver for the STM32MP1 peripheral reset controller.

The reset lookups are merged from a separate, immutable branch, that may
also be merged into the davinci tree.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      reset: add support for non-DT systems
      reset: modify the way reset lookup works for board files

Gabriel Fernandez (2):
      dt-bindings: reset: add STM32MP1 resets
      reset: stm32mp1: Enable stm32mp1 reset driver

Katsuhiro Suzuki (1):
      reset: uniphier: add Pro4/Pro5/PXs2 audio systems reset control

Kunihiko Hayashi (1):
      reset: uniphier: add ethernet reset control support for PXs3

Masahiro Yamada (1):
      reset: imx7: add 'depends on HAS_IOMEM' to fix unmet dependency

Philipp Zabel (1):
      Merge branch 'reset/lookup' into reset/next

 .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |   6 ++
 drivers/reset/Kconfig                              |   7 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  96 ++++++++++++++++-
 drivers/reset/reset-stm32mp1.c                     | 115 +++++++++++++++++++++
 drivers/reset/reset-uniphier.c                     |   5 +
 include/dt-bindings/reset/stm32mp1-resets.h        | 108 +++++++++++++++++++
 include/linux/reset-controller.h                   |  30 ++++++
 8 files changed, 367 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32mp1-rcc.txt
 create mode 100644 drivers/reset/reset-stm32mp1.c
 create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h
