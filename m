From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 24 Sep 2012 16:43:16 +0200
Subject: [PATCH 0/3] clk: ux500: Set sdmmc clock to 100MHz
Message-ID: <1348497799-32143-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The reason behind this change is that we would like to enable all
the mmc/sd/sdio features from a hardware perspective (ARM PL18x).
It is then required that the frequency must be 100MHz.

Ulf Hansson (3):
  mfd: dbx500: Export prmcu_request_ape_opp_100_voltage
  clk: ux500: Support prcmu ape opp voltage clock
  clk: ux500: Update sdmmc clock to 100MHz for u8500

 drivers/clk/ux500/clk-prcmu.c    |   55 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/ux500/clk.h          |    6 +++++
 drivers/clk/ux500/u8500_clk.c    |    5 ++--
 drivers/mfd/db8500-prcmu.c       |    4 +--
 include/linux/mfd/db8500-prcmu.h |    4 +--
 include/linux/mfd/dbx500-prcmu.h |   10 +++++++
 6 files changed, 78 insertions(+), 6 deletions(-)

-- 
1.7.10
