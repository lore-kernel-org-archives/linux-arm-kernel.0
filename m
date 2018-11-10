From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 10 Nov 2018 15:17:56 +0100
Subject: [PATCH 00/17] bcm2835: Treewide switch to SPDX identifier
Message-ID: <1541859476-6210-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After fixing the module license of some bcm2835 drivers in "Fix MODULE_LICENSE
of bcm2835 drivers", we can finally switch all outstanding bcm2835 /
Raspberry Pi drivers to SPDX identifier and drop the unnecessary license text.
I omit the staging area, because there are proposed a lot of changes for
vc04_services. 

I hope it is okay to have the binding header integrated in the tree-wise
patches instead of a separate one. This should avoid conflicts while merging.

Stefan Wahren (17):
  ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier
  ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier
  hw_random: bcm2835-rng: Switch to SPDX identifier
  clk: bcm2835: Switch to SPDX identifier
  clocksource: bcm2835: Switch to SPDX identifier
  dma: bcm2835: Switch to SPDX identifier
  firmware: raspberrypi: Switch to SPDX identifier
  i2c: bcm2835: Switch to SPDX identifier
  irqchip: bcm283x: Switch to SPDX identifier
  mailbox: bcm2835: Switch to SPDX identifier
  mmc: bcm2835: Switch to SPDX identifier
  pinctrl: bcm2835: Switch to SPDX identifier
  pwm: bcm2835: Switch to SPDX identifier
  soc: bcm: Switch raspberrypi-power to SPDX identifier
  spi: bcm2835: Switch to SPDX identifier
  thermal: bcm2835: Switch to SPDX identifier
  ASoc: bcm2835-i2s: Switch to SPDX identifier

 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts      |  8 +-------
 arch/arm/boot/dts/bcm2835-rpi-zero.dts        |  8 +-------
 arch/arm/mach-bcm/board_bcm2835.c             | 11 +----------
 arch/arm/mach-bcm/platsmp.c                   | 10 +---------
 arch/arm/mach-bcm/platsmp.h                   |  6 +-----
 drivers/char/hw_random/bcm2835-rng.c          |  7 ++-----
 drivers/clk/bcm/clk-bcm2835-aux.c             | 11 +----------
 drivers/clk/bcm/clk-bcm2835.c                 | 12 +-----------
 drivers/clocksource/bcm2835_timer.c           | 15 +--------------
 drivers/dma/bcm2835-dma.c                     | 11 +----------
 drivers/firmware/raspberrypi.c                |  5 +----
 drivers/i2c/busses/i2c-bcm2835.c              | 10 +---------
 drivers/irqchip/irq-bcm2835.c                 | 11 +----------
 drivers/irqchip/irq-bcm2836.c                 | 11 +----------
 drivers/mailbox/bcm2835-mailbox.c             |  8 +-------
 drivers/mmc/host/bcm2835.c                    | 13 +------------
 drivers/pinctrl/bcm/pinctrl-bcm2835.c         | 11 +----------
 drivers/pwm/pwm-bcm2835.c                     |  5 +----
 drivers/soc/bcm/raspberrypi-power.c           |  5 +----
 drivers/spi/spi-bcm2835.c                     | 11 +----------
 drivers/spi/spi-bcm2835aux.c                  | 11 +----------
 drivers/thermal/broadcom/bcm2835_thermal.c    | 11 +----------
 include/dt-bindings/clock/bcm2835-aux.h       | 10 +---------
 include/dt-bindings/clock/bcm2835.h           | 10 +---------
 include/dt-bindings/pinctrl/bcm2835.h         |  8 +-------
 include/dt-bindings/power/raspberrypi-power.h |  5 +----
 include/soc/bcm2835/raspberrypi-firmware.h    |  5 +----
 sound/soc/bcm/bcm2835-i2s.c                   | 10 +---------
 28 files changed, 29 insertions(+), 230 deletions(-)

-- 
2.7.4
