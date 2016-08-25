From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 25 Aug 2016 15:57:15 +0900
Subject: [PATCH v2 0/3] clk: samsung: exynos5420: Add clocks for CMU_CDREX
 domain
Message-ID: <1472108238-24309-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add the clocks for CMU_CDREX (DRAM Express Controller)
that generates the clocks for DRAM and NoC (Network on Chip) bus clock.

[clk_summary on exynos5422-odroidxu3 board]
fout_bpll                             0            0   800000000          0 0
    mout_bpll                          0            0   800000000          0 0
       mout_mclk_cdrex                 0            0   800000000          0 0
          dout_pclk_core_mem           0            0   200000000          0 0
          dout_sclk_cdrex              0            0   800000000          0 0

Changes from v1:
- Use the BPLL for DRAM clock to generate the 800MHz
- Add patch3 to assign the clock rate for DRAM clock

Chanwoo Choi (3):
  dt-bindings: Add the clock id for CMU_CDREX (DRAM Express Controller)
  clk: samsung: exynos5420: Add clocks for CMU_CDREX domain
  ARM: dts: Set the clock rate for DREX block 800Mhz on exynos5422-odroidxu3

 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  5 +++
 drivers/clk/samsung/clk-exynos5420.c               | 37 ++++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             | 11 ++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

-- 
1.9.1
