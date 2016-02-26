From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 26 Feb 2016 09:51:51 +0100
Subject: [PATCH v4 0/3] i.MX6 LDB mux/divider glitch workaround
Message-ID: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the last version contained a bug when setting the muxes, which caused it
to OR the desired mux values for ldb_di0_sel and ldb_di1_sel and write the
result to the ldb_di0_sel bitfield. This is fixed now.
I think the mmdc_ch1 patch should be uncontroversial. The remaining two
could use some test feedback and somebody who can take a look at ERR009219
and EB821 and can confirm that this patch is in line with the suggested
workaround.

regards
Philipp

Changes since v3:
 - Fix LDB_DI1_SEL shift when setting divider and fix a debug printk,
   issues reported by Akshay Bhat.

Fabio Estevam (1):
  ARM: imx6: Fix procedure to switch the parent of LDB_DI_CLK

Philipp Zabel (2):
  ARM: imx6: Mask mmdc_ch1 handshake for periph2_sel and
    mmdc_ch1_axi_podf
  ARM: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only.

 drivers/clk/imx/clk-imx6q.c | 294 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/clk/imx/clk.h       |   8 ++
 2 files changed, 292 insertions(+), 10 deletions(-)

-- 
2.7.0
