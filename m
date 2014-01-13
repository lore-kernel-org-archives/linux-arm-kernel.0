From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 13 Jan 2014 17:14:27 +0800
Subject: [PATCH 0/2] mmc: dw_mmc: k3 remove clk_table
Message-ID: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_table is used to set clock source in each mode, as well as limitation, max_rate and init rate.
It concerned many experts though, and Seungwon recommended some limitation can be hide in clk.c.
Also soc is updated as the limitation now same as max_rate, so directly using ios->clock.

Zhangfei Gao (2):
  clk: hisilicon: add hi3620_mmc_clks
  mmc: dw_mmc: k3: remove clk_table

 .../bindings/arm/hisilicon/hisilicon.txt           |   14 +
 .../devicetree/bindings/clock/hi3620-clock.txt     |    1 +
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   14 -
 drivers/clk/hisilicon/clk-hi3620.c                 |  267 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc-k3.c                       |   41 +--
 include/dt-bindings/clock/hi3620-clock.h           |    5 +
 6 files changed, 289 insertions(+), 53 deletions(-)

-- 
1.7.9.5
