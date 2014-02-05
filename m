From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 5 Feb 2014 11:12:24 -0600
Subject: [GIT PULL] clk: socfpga: Clock updates for v3.15
Message-ID: <1391620344-16882-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Please consider pull these patch for v3.15.

Thanks,
Dinh

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.15

for you to fetch changes up to 5d81b6fc5ee1d904f9e3faab3a80cee36d267136:

  clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk" (2014-02-05 11:05:09 -0600)

----------------------------------------------------------------
SOCFPGA clk updates for v3.15

----------------------------------------------------------------
Dinh Nguyen (4):
      clk: socfpga: Map the clk manager base address in the clock driver
      clk: socfpga: Look for the GPIO_DB_CLK by its offset
      clk: socfpga: Remove socfpga_init_clocks
      clk: socfpga: Add a clk-phase property to the "altr,socfpga-gate-clk"

Steffen Trumtrar (3):
      clk: socfpga: remove unused field
      clk: socfpga: fix define typo
      clk: socfpga: split clk code

 .../devicetree/bindings/clock/altr_socfpga.txt     |    5 +
 arch/arm/boot/dts/socfpga.dtsi                     |    1 +
 arch/arm/mach-socfpga/socfpga.c                    |    5 -
 drivers/clk/socfpga/Makefile                       |    3 +
 drivers/clk/socfpga/clk-gate.c                     |  263 ++++++++++++++++
 drivers/clk/socfpga/clk-periph.c                   |   94 ++++++
 drivers/clk/socfpga/clk-pll.c                      |  111 +++++++
 drivers/clk/socfpga/clk.c                          |  326 +-------------------
 drivers/clk/socfpga/clk.h                          |   57 ++++
 9 files changed, 546 insertions(+), 319 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate.c
 create mode 100644 drivers/clk/socfpga/clk-periph.c
 create mode 100644 drivers/clk/socfpga/clk-pll.c
 create mode 100644 drivers/clk/socfpga/clk.h
