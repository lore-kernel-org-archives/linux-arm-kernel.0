From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 17:41:46 +0900
Subject: [PATCH 0/2] clk: samsung: exynos5420: Add clocks for CMU_CDREX domain
Message-ID: <1471855308-12791-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add the clocks for CMU_CDREX (DRAM Express Controller)
that generates the clocks for DRAM and NoC (Network on Chip) bus clock.

[Result for clk_summary on exynos5422-odroidxu3 board]
    fout_bpll                             0            0   825000000          0 0  
       mout_bpll                          0            0   825000000          0 0  
          mout_mclk_cdrex                 0            0   825000000          0 0  
             dout_pclk_core_mem           0            0   206250000          0 0  
             dout_sclk_cdrex              0            0   825000000          0 0  
                dout_clk2x_phy0           0            0   825000000          0 0  
                   dout_aclk_cdrex1           0            0   412500000          0 0  
                      dout_pclk_cdrex           0            0   103125000          0 0  
                   dout_cclk_drex0           0            0   412500000          0 0  

Chanwoo Choi (2):
  dt-bindings: Add the clock id for CMU_CDREX (DRAM Express Controller)
  clk: samsung: exynos5420: Add clocks for CMU_CDREX domain

 drivers/clk/samsung/clk-exynos5420.c   | 35 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h | 11 ++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
1.9.1
