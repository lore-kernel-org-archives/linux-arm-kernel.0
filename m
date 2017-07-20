From: adriana.reus@nxp.com (Adriana Reus)
Date: Thu, 20 Jul 2017 18:06:40 +0300
Subject: [PATCH V2 0/2] clk: imx: imx7d: Fixes for imx7d-ccm clock driver
Message-ID: <1500563202-375-1-git-send-email-adriana.reus@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch sets the OCRAM_CLK parent to main_axi_root_clk instead of
axi_post_div.

The second patch removes the ARM_M0 clock.
IMX7d does not have an M0 and this clock is not otherwise used.

Adriana Reus (2):
  clk: imx: imx7d: Fix parent clock for OCRAM_CLK
  clk: imx: imx7d: Remove ARM_M0 clock

 drivers/clk/imx/clk-imx7d.c             | 11 +----------
 include/dt-bindings/clock/imx7d-clock.h |  8 ++++----
 2 files changed, 5 insertions(+), 14 deletions(-)

-- 
2.7.4
