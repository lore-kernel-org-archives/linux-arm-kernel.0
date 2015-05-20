From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 19 May 2015 22:22:40 -0500
Subject: [PATCHv4 0/2] clk: socfpga: Add clock driver for Arria10
Message-ID: <1432092162-8889-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Hi,

This patch series add the clock driver for the Arria10 platform. Although the
Arria10 SoC's clock framework has some similarities the Cyclone/Arria 5, the
differences are enough to warrant it's own driver, rather than polluting the
existing driver with platform lookups.

v4:
- Move syscon regmap lookup to gate_clk_init().
- Remove unused includes(linux/clk.h and linux/clkdev.h)
- Check return value of of_clk_add_provider
- Clean ups to address Stephen's comments

v3:
- Fix sparse warning of assigning an integer 0 instead of NULL to a pointer.

v2:
- Update the DTS bindings doucment to have the new Arria10 clocks.
- Add an l4_sys_free_clk node. The l4_sys_free_clk is similar to the
  l4_sp_clk, but cannot be gated.

Thanks,

Dinh Nguyen (2):
  clk: socfpga: update clk.h so for Arria10 platform to use
  clk: socfpga: add a clock driver for the Arria 10 platform

 drivers/clk/socfpga/Makefile         |   1 +
 drivers/clk/socfpga/clk-gate-a10.c   | 188 +++++++++++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-gate.c       |   4 -
 drivers/clk/socfpga/clk-periph-a10.c | 138 +++++++++++++++++++++++++
 drivers/clk/socfpga/clk-pll-a10.c    | 129 ++++++++++++++++++++++++
 drivers/clk/socfpga/clk.c            |   7 +-
 drivers/clk/socfpga/clk.h            |  11 +-
 7 files changed, 472 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate-a10.c
 create mode 100644 drivers/clk/socfpga/clk-periph-a10.c
 create mode 100644 drivers/clk/socfpga/clk-pll-a10.c

-- 
2.2.1
