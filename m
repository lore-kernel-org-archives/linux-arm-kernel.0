From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 28 Aug 2017 10:58:51 +0530
Subject: [PATCH 0/2] constify clk clk_div_table
Message-ID: <1503898133-10862-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_div_table are not supposed to change at runtime. All functions
working with clk_div_table provided by <linux/clk-provider.h> work
with const clk_div_table. So mark the non-const structs as const.

Arvind Yadav (2):
  [PATCH 1/2] clk: imx: constify clk_div_table
  [PATCH 2/2] clk: zte: constify clk_div_table

 drivers/clk/imx/clk-imx6sl.c   | 6 +++---
 drivers/clk/imx/clk-imx6sx.c   | 6 +++---
 drivers/clk/imx/clk-imx6ul.c   | 6 +++---
 drivers/clk/imx/clk-imx7d.c    | 4 ++--
 drivers/clk/imx/clk-vf610.c    | 2 +-
 drivers/clk/zte/clk-zx296718.c | 6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

-- 
1.9.1
