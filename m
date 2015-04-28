From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 28 Apr 2015 10:10:12 -0500
Subject: [PATCHv2 0/4] clk: socfpga: Add clock driver for Arria10
Message-ID: <1430233816-32635-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Hi,

This patch series add the clock driver for the Arria10 platform. Although the
Arria10 SoC's clock framework has some similarities the Cyclone/Arria 5, the
differences are enough to warrant it's own driver, rather than polluting the
existing driver with platform lookups.

v2:
- Update the DTS bindings doucment to have the new Arria10 clocks.
- Add an l4_sys_free_clk node. The l4_sys_free_clk is similar to the
  l4_sp_clk, but cannot be gated.

Thanks,

Dinh Nguyen (4):
  clk: socfpga: update clk.h so for Arria10 platform to use
  clk: socfpga: add a clock driver for the Arria 10 platform
  ARM: socfpga: dts: add clocks to the Arria10 platform
  Documentation: DT bindings: document the clocks for Arria10

 .../devicetree/bindings/clock/altr_socfpga.txt     |  17 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 309 ++++++++++++++++++++-
 drivers/clk/socfpga/Makefile                       |   1 +
 drivers/clk/socfpga/clk-gate-a10.c                 | 187 +++++++++++++
 drivers/clk/socfpga/clk-gate.c                     |   4 -
 drivers/clk/socfpga/clk-periph-a10.c               | 131 +++++++++
 drivers/clk/socfpga/clk-pll-a10.c                  | 132 +++++++++
 drivers/clk/socfpga/clk.c                          |   7 +-
 drivers/clk/socfpga/clk.h                          |  10 +-
 9 files changed, 782 insertions(+), 16 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate-a10.c
 create mode 100644 drivers/clk/socfpga/clk-periph-a10.c
 create mode 100644 drivers/clk/socfpga/clk-pll-a10.c

-- 
2.2.1
