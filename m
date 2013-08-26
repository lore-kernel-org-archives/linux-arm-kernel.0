From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 26 Aug 2013 14:42:58 +0530
Subject: [PATCH v3 0/5] clk/exynos5420: add clocks for hdmi subsystem
Message-ID: <1377508383-15185-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock changes for hdmi subsystem for exynos5250 SoC. These
include addition of new clocks like mout_hdmi and smmu_tv, associating
ID to clk_hdmiphy and some essential corrections.

V3:
1) Assign new ID to divider clock keeping sclk_pixel gate same.

V2:
1) Rebase to Mike's Tree.
2) Change smmu_tv to smmu_mixer.

This set is based on Mike's clk-next branch at
https://git.linaro.org/gitweb?p=people/mturquette/linux.git

Rahul Sharma (5):
  clk/exynos5420: add sclk_hdmiphy to the list of special clocks
  clk/exynos5420: add gate clock for mixer sysmmu
  clk/exynos5420: fix the order of parents of hdmi mux
  clk/exynos5420: add hdmi mux to change parents in hdmi driver
  clk/exynos5420: assign dout_pixel id to pixel clock divider

 .../devicetree/bindings/clock/exynos5420-clock.txt  |   12 ++++++++++++
 drivers/clk/samsung/clk-exynos5420.c                |   19 +++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
1.7.10.4
