From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Nov 2016 10:57:12 +0800
Subject: [GIT PULL] i.MX clock updates for 4.10
Message-ID: <20161115025711.GU3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.10

for you to fetch changes up to 73cd5e53caba2425f5b73ad0950544d1168ad27b:

  clk: imx: clk-imx6ul: add clk support for imx6ull (2016-11-15 08:55:36 +0800)

----------------------------------------------------------------
i.MX clock updates for 4.10:
 - A patch series to fix the long standing issue with glitchy parent
   mux of ldb_di_clk, which can hang up LVDS display when ipu_di_clk
   is sourced from ldb_di_clk.
 - A patch to add imx6ull clock support on top of imx6ul clock driver.

----------------------------------------------------------------
Bai Ping (1):
      clk: imx: clk-imx6ul: add clk support for imx6ull

Fabio Estevam (1):
      clk: imx6: Fix procedure to switch the parent of LDB_DI_CLK

Philipp Zabel (2):
      clk: imx6: Mask mmdc_ch1 handshake for periph2_sel and mmdc_ch1_axi_podf
      clk: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only

 drivers/clk/imx/clk-imx6q.c              | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 drivers/clk/imx/clk-imx6ul.c             |  72 ++++++++++++++++++++++++++++++++++-------
 drivers/clk/imx/clk.h                    |   8 +++++
 include/dt-bindings/clock/imx6ul-clock.h |  15 ++++++++-
 4 files changed, 356 insertions(+), 22 deletions(-)
