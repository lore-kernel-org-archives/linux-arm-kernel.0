From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  9 Sep 2016 11:54:21 +0800
Subject: [PATCH] clk: sunxi-ng: a23: Assign base address for bus_spinlock_clk
Message-ID: <20160909035421.16119-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bus_spinlock_clk was accidentally left out of the list of clks that
need to be assigned the register base address.

Fixes: 8c9214b0e525 ("clk: sunxi-ng: Add A23 CCU")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

Missed this one in the review. Please squash this into the original
A23 CCU patch.

---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 30e3c4ee95ad..11e624ab28b1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -483,6 +483,7 @@ static struct ccu_common *sun8i_a23_ccu_clks[] = {
 	&bus_de_be_clk.common,
 	&bus_gpu_clk.common,
 	&bus_msgbox_clk.common,
+	&bus_spinlock_clk.common,
 	&bus_drc_clk.common,
 	&bus_codec_clk.common,
 	&bus_pio_clk.common,
-- 
2.9.3
