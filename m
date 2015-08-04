From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  4 Aug 2015 14:45:31 +0000
Subject: [PATCH 6/7 v2] clk: atlas7: fix bit field and its root clk for
 coresight_tpiu
In-Reply-To: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
References: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438699532-13860-7-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <guo.zeng@csr.com>

bit4 thcpum_cpudiv4_clken 	r/w
thcpum_cpudiv4_clk clock enable (default: 1)
Root clock CPU_CLK must be enabled for this clock to be enabled

bit3 coresight_tpiu_clken 	r/w
coresight_tpiu_clk clock enable (default: 0)
Root clock TPIU_CLK must be enabled for this clock to be enabled

Signed-off-by: Guo Zeng <guo.zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index c1788df..4fc33da 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -1164,7 +1164,7 @@ static struct atlas7_unit_init_data unit_list[] __initdata = {
 	{ 122, "spram1_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 0, &leaf6_gate_lock },
 	{ 123, "spram2_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 1, &leaf6_gate_lock },
 	{ 124, "coresight_cpudiv2", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 2, &leaf6_gate_lock },
-	{ 125, "thcpum_cpudiv4", "cpum_cpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 3, &leaf6_gate_lock },
+	{ 125 , "coresight_tpiu", "cpum_tpiu", 0, SIRFSOC_CLKC_LEAF_CLK_EN6_SET, 3, &leaf6_gate_lock },
 	{ 126, "graphic_gpu", "gpum_gpu", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 0, &leaf7_gate_lock },
 	{ 127, "vss_sdr", "gpum_sdr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 1, &leaf7_gate_lock },
 	{ 128, "thgpum_nocr", "gpum_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 2, &leaf7_gate_lock },
-- 
1.9.1
