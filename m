From: tali.perry1@gmail.com (Tali Perry)
Date: Tue, 17 Jul 2018 14:31:28 +0300
Subject: [PATCH v1 0/1] clk: npcm7xx: fix base address and of_clk_get_by_name
Message-ID: <20180717113129.25033-1-tali.perry1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nuvoton NPCM7XX Clock Controller
fix base address and of_clk_get_by_name error handling.
    Also update error messages to be more informative.
    
    In case clk_base allocation is erronoeous the return value is null.
    Also fix handling of of_clk_get_by_name returns an error. 
    Print a better error message pointing to the dt-binding documention.

This patch is re-submitted since it was already pushed to main 
(just the diff, without the full driver which is already in 
master branch.)


Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

---

Tali Perry (1):
  clk: npcm7xx: get fixed clocks from DT

 drivers/clk/clk-npcm7xx.c | 101 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 24 deletions(-)

-- 
2.14.1
