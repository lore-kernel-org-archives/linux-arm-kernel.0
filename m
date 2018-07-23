From: tony.xie@rock-chips.com (Tony Xie)
Date: Mon, 23 Jul 2018 11:19:00 +0800
Subject: [PATCH 0/5] support a new type of PMIC，including two chips(rk817 and rk809)
Message-ID: <1532315945-1094-1-git-send-email-tony.xie@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of functions and registers of the rk817 and rk808 are the same,
so they can share allmost all codes.

Their specifications are as follows?
  1) The RK809 and RK809 consist of 5 DCDCs, 9 LDOs and have the same registers
     for these components except dcdc5.
  2) The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
  3) The RK817 has one switch but The Rk809 has two.

Tony Xie (5):
  mfd: rk808: Add RK817 and RK809 support
  regulator: rk808: Add regulator driver for RK809 and RK817.
  mfd: dt-bindings: Add RK809 and RK817 device tree bindings document
  RTC: RK808: add RTC driver for RK809 and RK817.
  clk: RK808: add clkout driver for RK809 and RK817.

 Documentation/devicetree/bindings/mfd/rk808.txt |  55 ++
 drivers/clk/Kconfig                             |   6 +-
 drivers/clk/clk-rk808.c                         |  62 ++-
 drivers/mfd/Kconfig                             |   6 +-
 drivers/mfd/rk808.c                             | 216 +++++++-
 drivers/regulator/Kconfig                       |   4 +-
 drivers/regulator/rk808-regulator.c             | 633 +++++++++++++++++++++++-
 drivers/rtc/Kconfig                             |   4 +-
 drivers/rtc/rtc-rk808.c                         |  68 ++-
 include/linux/mfd/rk808.h                       | 175 +++++++
 10 files changed, 1201 insertions(+), 28 deletions(-)

-- 
1.9.1
