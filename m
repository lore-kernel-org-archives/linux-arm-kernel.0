From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 20 Aug 2013 16:38:49 +0800
Subject: [PATCH 0/3] refactor some ldb related clocks
Message-ID: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ldb_di[0/1]_ipu_div clock dividers in the CSCMR2 register
of i.MX53, i.MX6Q and i.MX6DL SoCs can be configured to a 1/3.5
drivider or a 1/7 divider. The common clock framework cannot
deal with the two dividers directly even with the divider table
which only supports integral dividers. So, the idea is to take
the 1/3.5 and 1/7 dividers as separate fixed factor dividers and
introduce a new multiplexer clock to be derived from the them.
Then, the ldb display clock trees can be setup correctly.
This series contains the necessary clock driver changes, dts code
changes and imx-drm/ldb driver changes to fullfill the task.

Liu Ying (3):
  ARM: imx6q: refactor some ldb related clocks
  ARM: dts: imx6q/imx6dl: add necessary clocks for ldb node
  staging: drm/imx: ldb: correct the ldb di clock trees

 .../devicetree/bindings/clock/imx6q-clock.txt      |    6 ++--
 arch/arm/boot/dts/imx6dl.dtsi                      |    8 +++--
 arch/arm/boot/dts/imx6q.dtsi                       |    8 +++--
 arch/arm/mach-imx/clk-imx6q.c                      |   25 +++++++------
 drivers/staging/imx-drm/imx-ldb.c                  |   38 +++++++++++++++-----
 5 files changed, 61 insertions(+), 24 deletions(-)

-- 
1.7.9.5
