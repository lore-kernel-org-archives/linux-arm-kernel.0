From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 23 May 2013 19:31:22 +0200
Subject: [PATCH 0/6] U300 device tree clocks
Message-ID: <1369330288-14856-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The following patch set converts all the U300 clocks to be probed
from the device tree. We first move the syscon memory range to the
device tree, then we group the clocks under it.

This goes on top of the previous device tree and multiplatform
series for the U300.

Linus Walleij (6):
  ARM: u300: add syscon node
  ARM: u300: remove register definition file
  clk: move the U300 fixed and fixed-factor to DT
  i2c: stu300: do not request a specific clock name
  ARM: u300: move the gated system controller clocks to DT
  ARM: u300: convert MMC/SD clock to device tree

 Documentation/devicetree/bindings/arm/ste-u300.txt |  30 +-
 .../bindings/clock/ste-u300-syscon-clock.txt       |  80 +++++
 arch/arm/boot/dts/ste-u300.dts                     | 204 +++++++++++
 arch/arm/mach-u300/core.c                          | 135 +++++++-
 arch/arm/mach-u300/regulator.c                     |  21 +-
 arch/arm/mach-u300/timer.c                         |   2 +-
 arch/arm/mach-u300/u300-regs.h                     | 165 ---------
 drivers/clk/clk-u300.c                             | 375 +++++++++++++--------
 drivers/i2c/busses/i2c-stu300.c                    |   4 +-
 9 files changed, 702 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
 delete mode 100644 arch/arm/mach-u300/u300-regs.h

-- 
1.7.11.3
