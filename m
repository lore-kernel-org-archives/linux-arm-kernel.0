From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 10 Jun 2016 13:56:29 +0900
Subject: [PATCH 0/3] clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag and
Message-ID: <1465534592-18860-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set add the CLK_IGNORE_UNUSED flag to the specific clocks because
the specific clocks should remain the enable state. This patch-set support the
PCIE (PCI Express), serial3(AUD Uart) device and fix the hang issue for
suspend-to-ram.

Beomho Seo (1):
  clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag for AUD Uart

Jaehoon Chung (1):
  clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag to PCIE device

Jonghwa Lee (1):
  clk: samsung: exynos5433: Add CLK_IGNORE_UNUSED flag to clocks occurring hang at sleep

 drivers/clk/samsung/clk-exynos5433.c   | 47 +++++++++++++++++++++-------------
 include/dt-bindings/clock/exynos5433.h |  3 ++-
 2 files changed, 31 insertions(+), 19 deletions(-)

-- 
1.9.1
