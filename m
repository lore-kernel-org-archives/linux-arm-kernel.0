From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 6 Jan 2014 11:27:26 -0600
Subject: [GIT PULL] clk: socfpga: Clean-ups for 3.14
Message-ID: <1389029246-27434-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Please pull in these patches that cleans up the SOCFPGA clock driver. This is
V2 of the pull request that includes 4 patches from Steffen Trumtrar.

Thanks,

Dinh

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.14_v2

for you to fetch changes up to d5387681665e58bafc1a9c745182f03aab0579c3:

  clk: socfpga: split clk code (2014-01-06 11:22:22 -0600)

----------------------------------------------------------------
v2: SOCFPGA clk cleanups for 3.14

----------------------------------------------------------------
Dinh Nguyen (3):
      clk: socfpga: Map the clk manager base address in the clock driver
      clk: socfpga: Look for the GPIO_DB_CLK by its offset
      clk: socfpga: Remove socfpga_init_clocks

Steffen Trumtrar (4):
      clk: socfpga: remove unused field
      clk: socfpga: fix define typo
      clk: socfpga: fix compile error
      clk: socfpga: split clk code

 arch/arm/mach-socfpga/socfpga.c  |    5 -
 drivers/clk/socfpga/Makefile     |    3 +
 drivers/clk/socfpga/clk-gate.c   |  223 ++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-periph.c |   94 +++++++++++
 drivers/clk/socfpga/clk-pll.c    |  111 +++++++++++++
 drivers/clk/socfpga/clk.c        |  328 ++------------------------------------
 drivers/clk/socfpga/clk.h        |   57 +++++++
 7 files changed, 500 insertions(+), 321 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate.c
 create mode 100644 drivers/clk/socfpga/clk-periph.c
 create mode 100644 drivers/clk/socfpga/clk-pll.c
 create mode 100644 drivers/clk/socfpga/clk.h
