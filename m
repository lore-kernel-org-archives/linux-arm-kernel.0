From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 11 Jan 2016 12:23:56 +0100
Subject: [PATCH v2 0/3] i.MX6 LDB mux/divider glitch workaround
Message-ID: <1452511439-10472-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

just so these don't get forgotten, these patches try to implement the
passed down workaround for a glitch caused by switching the ldb_di_sel
muxes which can lock up the ldb_di_ipu_div dividers.
As far as I am aware, this issue is still not mentioned in the chip
errata.

Changes since v1:
 - Rebased onto v4.4
 - Enabled workaround on i.MX6Q revision 1.0, too, but disabled the
   PLL5_VIDEO_DIV parent in that case.

v1 can be found here:
    https://patchwork.kernel.org/patch/5574731/
    https://patchwork.kernel.org/patch/5574741/
    https://patchwork.kernel.org/patch/5574751/

regards
Philipp

Fabio Estevam (1):
  ARM: imx6: Fix procedure to switch the parent of LDB_DI_CLK

Philipp Zabel (2):
  ARM: imx6: Mask mmdc_ch1 handshake for periph2_sel and
    mmdc_ch1_axi_podf
  ARM: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only.

 drivers/clk/imx/clk-imx6q.c | 227 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/imx/clk.h       |   8 ++
 2 files changed, 227 insertions(+), 8 deletions(-)

-- 
2.6.4
