From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 2 Apr 2015 23:40:52 -0500
Subject: [PATCH 0/3] clk: socfpga: Add clock driver for Arria10
Message-ID: <1428036055-27607-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Hi,

This patch series add the clock driver for the Arria10 platform. Although the
Arria10 SoC's clock framework has some similarities the Cyclone/Arria 5, the
differences are enough to warrant it's own driver, rather than polluting the
existing driver with platform lookups.

Dinh Nguyen (3):
  clk: socfpga: update clk.h so for Arria10 platform to use
  clk: socfpga: add a clock driver for the Arria 10 platform
  ARM: socfpga: dts: add clocks to the Arria10 platform

 arch/arm/boot/dts/socfpga_arria10.dtsi | 298 ++++++++++++++++++++++++++++++++-
 drivers/clk/socfpga/Makefile           |   1 +
 drivers/clk/socfpga/clk-gate-a10.c     | 187 +++++++++++++++++++++
 drivers/clk/socfpga/clk-gate.c         |   4 -
 drivers/clk/socfpga/clk-periph-a10.c   | 131 +++++++++++++++
 drivers/clk/socfpga/clk-pll-a10.c      | 132 +++++++++++++++
 drivers/clk/socfpga/clk.c              |   7 +-
 drivers/clk/socfpga/clk.h              |  10 +-
 8 files changed, 760 insertions(+), 10 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate-a10.c
 create mode 100644 drivers/clk/socfpga/clk-periph-a10.c
 create mode 100644 drivers/clk/socfpga/clk-pll-a10.c

-- 
2.2.1
