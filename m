From: tali.perry1@gmail.com (tali.perry1 at gmail.com)
Date: Sun, 11 Nov 2018 15:47:11 +0200
Subject: [PATCH v1 0/1] clk: npcm7xx: fix base address and of_clk_get_by_name
Message-ID: <20181111134712.318321-1-tali.perry1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tali Perry <tali.perry1@gmail.com>

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

 drivers/clk/clk-npcm7xx.c | 99 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 24 deletions(-)

-- 
2.14.1
