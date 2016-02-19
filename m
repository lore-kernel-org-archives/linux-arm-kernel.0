From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 19 Feb 2016 10:39:47 +0100
Subject: [GIT PULL] Reset controller changes for v4.6
Message-ID: <1455874787.13163.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

this tag adds reset support for Pistachio, makes
struct reset_control_ops const, and moves the DT
cell size check into the core.

best regards
Philipp

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.6

for you to fetch changes up to f673ed4d5fdc123b1552525de30741cd8dfde53f:

  reset: sti: Make reset_control_ops const (2016-02-10 10:53:38 +0100)

----------------------------------------------------------------
Reset controller changes for v4.6

- add support for the imgtec Pistachio SoC reset controller
- make struct reset_control_ops const
- move DT cell size check into the core to avoid code duplication
  in the drivers

----------------------------------------------------------------
Damien Horsley (2):
      reset: img: Add pistachio reset controller binding document
      reset: img: Add Pistachio reset controller driver

Masahiro Yamada (1):
      reset: hisilicon: check return value of reset_controller_register()

Maxime Ripard (2):
      reset: Make reset_control_ops const
      reset: Move DT cell size check to the core

Philipp Zabel (11):
      reset: remove unnecessary local variable initialization from of_reset_control_get_by_index
      reset: berlin: drop DT cell size check
      reset: berlin: Make reset_control_ops const
      reset: img: Make reset_control_ops const
      reset: sunxi: Make reset_control_ops const
      reset: lpc18xx: Make reset_control_ops const
      reset: ath79: Make reset_control_ops const
      reset: hi6220: Make reset_control_ops const
      reset: socfpga: Make reset_control_ops const
      reset: zynq: Make reset_control_ops const
      reset: sti: Make reset_control_ops const

 .../bindings/reset/img,pistachio-reset.txt         |  55 ++++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  10 +-
 drivers/reset/hisilicon/hi6220_reset.c             |   6 +-
 drivers/reset/reset-ath79.c                        |   2 +-
 drivers/reset/reset-berlin.c                       |   5 +-
 drivers/reset/reset-lpc18xx.c                      |   2 +-
 drivers/reset/reset-pistachio.c                    | 154 +++++++++++++++++++++
 drivers/reset/reset-socfpga.c                      |   2 +-
 drivers/reset/reset-sunxi.c                        |   2 +-
 drivers/reset/reset-zynq.c                         |   2 +-
 drivers/reset/sti/reset-syscfg.c                   |   2 +-
 include/dt-bindings/reset/pistachio-resets.h       |  36 +++++
 include/linux/reset-controller.h                   |   2 +-
 14 files changed, 262 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/img,pistachio-reset.txt
 create mode 100644 drivers/reset/reset-pistachio.c
 create mode 100644 include/dt-bindings/reset/pistachio-resets.h
